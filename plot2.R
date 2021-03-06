#Script for Plot 2 - Electric Power Consumption
library(dplyr)
library(lubridate)

#download, unzip, and read  source data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="powercons.zip")
unzip("powercons.zip")
epc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

#investigating/file overview
head(epc)
str(epc)

#process data file: format Data,Time variables, select relevant data
epc$Date <- as.Date(epc$Date,"%d/%m/%Y")
epc$Time <- strftime(strptime(epc$Time,format="%H:%M:%S"),format="%H:%M:%S")
rel.dat <- subset(epc,epc$Date == "2007-02-01" | epc$Date == "2007-02-02")
rel.dat[,3:8] <- rel.dat[,3:8] %>% sapply(as.character) %>% sapply(as.numeric)
rel.dat <- mutate(rel.dat,Date = paste(rel.dat$Date,rel.dat$Time))

#Plot 2
png(filename = "plot2.png",width = 480, height = 480, units = "px",type = "quartz")
par(mar = c(5,5,2,2))
with(rel.dat,plot(ymd_hms(Date),Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab=""))
dev.off()