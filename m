Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156322AbPIQBEC>; Thu, 16 Sep 1999 21:04:02 -0400
Received: by vger.rutgers.edu id <S155898AbPIQBDk>; Thu, 16 Sep 1999 21:03:40 -0400
Received: from proxy2.ba.best.com ([206.184.139.14]:2029 "EHLO proxy2.ba.best.com") by vger.rutgers.edu with ESMTP id <S156259AbPIQBDc>; Thu, 16 Sep 1999 21:03:32 -0400
Message-ID: <37E19313.6090BE36@ostel.com>
Date: Thu, 16 Sep 1999 18:02:11 -0700
From: Rich Bodo <rsb@ostel.com>
Organization: OST
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: PLX 9050 chip
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

Does anyone on this list have experience with the PLX 9050 PCI bus
interface chip?  I am having this strange problem when reading from
registers in a xilinx across the local bus.  I can read pci config
registers, local config registers, and even the xilinx registes, until I
do a write to the xilinx.  After that, I can no longer read from
anywhere on the local bus.  I have implemented the PLX workarounds
mentioned in their FAQ and Errata.  Looking at a scope, I can see that I
am reading and writing to the local bus, but I get squat back from the
plx for reads.

I also want to make sure I am not re-inventing the wheel.  Grepping
through the kernel I found:

Some 9060 drivers
Lots of multi-port serial cards that use the 9050, are based on serial.c
and read their config from an eeprom. 

I am working on a card that will use a lot of the features of the 9050,
including burst mode across the local bus.  I also implement all the
workarounds in software and don't have an eeprom to work with, so I have
to do a little extra setup.  There is a neat PLX supplied tool called
PLXmon that I am able to run under FreeDOS to get and set register
values, I am thinking of writing a linux version.

-Rich

-- 
OST - the open source telecom corporation
Rich Bodo | rsb@ostel.com | 650-964-4-OST

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
