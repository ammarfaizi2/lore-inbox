Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292559AbSBTWwy>; Wed, 20 Feb 2002 17:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292561AbSBTWwu>; Wed, 20 Feb 2002 17:52:50 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:30231 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292559AbSBTWwh>;
	Wed, 20 Feb 2002 17:52:37 -0500
Message-ID: <3C7429D8.1060601@gmx.de>
Date: Wed, 20 Feb 2002 23:57:28 +0100
From: Daniel =?ISO-8859-1?Q?G=FCnther?= <daniel_guenther@gmx.de>
Reply-To: daniel_guenther@gmx.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; QXW0329u) Gecko/20010726 Netscape6/6.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug: device_interrupt: illegal interrupt 3?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

at first: this I already wrote this to debian, bug #13379, package 
boot-floppies, and someone told me to have a try with the actual test 
distribution "woody". No, I won't, I saw it comes from somewhere near 
the kernel AND I had the same problem with a Mandrake distribution.

I got ISO-Images of debian 2.2r5 stable for our noname alpha. As you can
see, I boot from CD. I tried it with floppy, too, and got the same problem.
Description: after loading Milo and entering:
MILO> boot scd0:/boot/linux root=/dev/scd0 load_ramdisk=1
a endless loop start with following message:

device_interrupt: illegal interrupt 3?

the "?" stands for "I don't know what number", because it could be 36, 37,
38, 39 or whatever else, it's scrolling too fast for my eyes. But it's
shure, that this are two digits. B

Then I can only reboot the machine, and then I have to do all the settings
in the firmware again, from ground up. I have to set the default environment
variables and the default configuration of the machine's firmware.

I choose eb64p because on the Aspen Homepage (www.aspsys.com) they told 
to use eb64, but I
only found eb64p.

greetings + thank's for reading

Daniel

More data of this system below.

Settings in Boot-Manager:
LOADIDENTIFIER=Debion CD
SYSTEMPARTITION=scsi(0)cdrom(5)fdisk(0)
OSLOADER=scsi(0)cdrom(5)fdisk(0)\milo\linload.exe
OSLOADPARTITION=scsi(0)cdrom(5)fdisk(0)
OSLOADFILENAME=\milo\eb64p
OSLOADOPTIONS=
(OSLOADOPTIONS are empty)

Architecture: Alpha
Board: Aspen Alpine with ARC


Firmware:
Alpha Firmware Version 4.35
Copyright 1993 Microsoft Corp.
copyright 1993 digital Equipment corp., copyright 1994 Aspen Systems Inc.



Processor ID: 21064
Processer Revision: 3
System Revision: 0x1
Processor Speed: 274.95 Mhz
Physical Memory: 128 MB
Backup Cache Size: 2 MB

Extended Firmware Information:
Version: 4.35 950614.1315
NVRAM Environment Usage: 15 %
(462 of 3052 bytes)

Video Option detected:
BIOS controlled video card

Devices detected by the firmware:

multi(0)video(0)monitor(0)
multi(0)key(0)keyboard(0)
multi(0)disk(0)fdisk(0) 
(Removable)
multi(0)serial(0)
multi(0)serial(1)
scsi(0)disk(1)rdisk(0) 
(1 Partition) QUANTUM XP39100S	LXY4
scsi(0)disk(2)rdisk(0) 	(1 Partition) QUANTUM XP39100S	LXY4
scsi(0)cdrom(5)fdisk(0) 
(Removable) TOSHIBA CD-ROM XM-3701TA0236


PCI slot information:

SCSI: Bus=0, Virtual Slot=5, Function=0, Vendor=1000, Device=1, Revision=1
Ethernet, Bus=0, Virtual Slot=7, Function=0, Vendor=1011, Device=9,
Revision=20
ISA bridge, Bus=0, Virtual Slot=8, Function=0, Vendor=8086, Device=484,
Revision=43
VGA: Bus=0, Virtual Slot=9, Function=0, Vendor=5333, Device=8811, Revision=0


Output of MILO with "show devices"
MILO (EB64+)
Built against Linux version 2.0.35
Device drivers:
SCSI (NCR (ncr53c8xx), Qlogic ISP, Buslogic, AHA2940UW
IDE
Floppy
Memory size is 128 MBytes
Devices:
fd (0200)     sd (0800)     sr (0B00)
sda: sda1 sda5    sdb: sdb1  sdb5
File systems:
ext2 iso9660 msdos

Output of MILO with "pci"
PCI devices found:
Bus 0, device 9, function 0:
VGA compatible controller: S3 Inc. Trio32/Trio64 (rev 0)
Medium devsel. IRQ 22.
Non-prefetchable 32 bit memory at 0x4800000

Bus 0, device 8, function 0:
Non-VGA device: Intel 82378IB (rev 67).
medium devsel. Master Capable. No bursts.

Bus 0, device 7, function 0:
Ethernet controller: DEC DC21140 (rev 32).
Medium devsel. Fast back-to-back capable. IRQ 17. Master Capable.
Latency=32. Min Gnt=20.Max Lat=40.
I/O at 0x8000
Non-prefetchable 32 bit memory at 0x5000000.

Bus 0, device 5, function 0:
Non-VGA device: NCR 53c810 (rev 1).
Medium devsel . IRQ 23. Master Capable. Latency=32.
I/O at 0x8800.
Non-prefetchable 32 bit memory at 0x5001000.







