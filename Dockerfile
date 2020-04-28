# Arduino CLI Docker Image
# Copyright (C) 2020, Uri Shaked

FROM alpine:3

RUN apk update

# glibc is needed by Arduino AVR tools
WORKDIR /root
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk
RUN apk add --allow-untrusted glibc-2.30-r0.apk
RUN addgroup -S wokwi && adduser -S -G wokwi wokwi

USER wokwi
WORKDIR /home/wokwi
RUN mkdir -p /home/wokwi/cli
WORKDIR /home/wokwi/cli
RUN wget https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz
RUN tar zxvf arduino-cli_latest_Linux_64bit.tar.gz
RUN rm arduino-cli_latest_Linux_64bit.tar.gz
ENV PATH="/home/wokwi/cli:${PATH}"

# Install AVR core
RUN arduino-cli core update-index
RUN arduino-cli core install arduino:avr

