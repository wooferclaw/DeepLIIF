# Use nvidia/cuda image
# Ubuntu 22.04 base replaces EOL Ubuntu 18.04 to eliminate ~100 OS-level CVEs
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y \
    gcc git wget \
    ffmpeg libsm6 libxext6 default-jdk \
    python3 python3-dev python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# install requirements for API
COPY cli.py cli.py
COPY deepliif deepliif
COPY setup.py setup.py
COPY README.md README.md

RUN pip3 install --upgrade pip
RUN pip3 install numpy>=1.23.0
RUN pip3 install .
