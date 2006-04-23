Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWDWOZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWDWOZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWDWOZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 10:25:28 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:47531 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751405AbWDWOZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 10:25:27 -0400
Date: Sun, 23 Apr 2006 16:25:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] Update devices.txt
Message-ID: <Pine.LNX.4.61.0604231622120.5207@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


the following patch updates Documentation/devices.txt with a new version 
from the LANANA site [1]. Is it ok?

[1] http://www.lanana.org/docs/device-list/devices-2.6+.txt
Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndru linux-2.6.17-rc2~/Documentation/devices.txt linux-2.6.17-rc2+update/Documentation/devices.txt
--- linux-2.6.17-rc2~/Documentation/devices.txt	2006-04-19 05:00:49.000000000 +0200
+++ linux-2.6.17-rc2+update/Documentation/devices.txt	2006-03-01 14:22:20.000000000 +0100
@@ -3,7 +3,7 @@
 
 	     Maintained by Torben Mathiasen <device@lanana.org>
 
-		      Last revised: 25 January 2005
+		      Last revised: 01 March 2006
 
 This list is the Linux Device List, the official registry of allocated
 device numbers and /dev directory nodes for the Linux operating
@@ -94,7 +94,6 @@
 		  9 = /dev/urandom	Faster, less secure random number gen.
 		 10 = /dev/aio		Asyncronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
-		 12 = /dev/oldmem	Access to crash dump from kexec kernel
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
@@ -262,13 +261,13 @@
 		NOTE: These devices permit both read and write access.
 
   7 block	Loopback devices
-		  0 = /dev/loop0	First loopback device
-		  1 = /dev/loop1	Second loopback device
+		  0 = /dev/loop0	First loop device
+		  1 = /dev/loop1	Second loop device
 		    ...
 
-		The loopback devices are used to mount filesystems not
+		The loop devices are used to mount filesystems not
 		associated with block devices.	The binding to the
-		loopback devices is handled by mount(8) or losetup(8).
+		loop devices is handled by mount(8) or losetup(8).
 
   8 block	SCSI disk devices (0-15)
 		  0 = /dev/sda		First SCSI disk whole disk
@@ -943,7 +942,7 @@
 		240 = /dev/ftlp		FTL on 16th Memory Technology Device 
 
 		Partitions are handled in the same way as for IDE
-		disks (see major number 3) expect that the partition
+		disks (see major number 3) except that the partition
 		limit is 15 rather than 63 per disk (same as SCSI.)
 
  45 char	isdn4linux ISDN BRI driver
@@ -1168,7 +1167,7 @@
 		The filename of the encrypted container and the passwords
 		are sent via ioctls (using the sdmount tool) to the master
 		node which then activates them via one of the
-		/dev/scramdisk/x nodes for loopback mounting (all handled
+		/dev/scramdisk/x nodes for loop mounting (all handled
 		through the sdmount tool).
 
 		Requested by: andy@scramdisklinux.org
@@ -1523,7 +1522,7 @@
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
- 83 char	Matrox mga_vid video driver
+ 83 char	Matrox mga_vid video driver 
  		 0 = /dev/mga_vid0	1st video card
 		 1 = /dev/mga_vid1	2nd video card
 		 2 = /dev/mga_vid2	3rd video card
@@ -1737,7 +1736,7 @@
 		  0 = /dev/ubda		First user-mode block device
 		 16 = /dev/udbb		Second user-mode block device
 		    ...
-
+		
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the limit on
 		partitions is 15.
@@ -2311,7 +2310,7 @@
 		  0 = /dev/drbd0	First DRBD device
 		  1 = /dev/drbd1	Second DRBD device
 		    ...
-
+		
 148 char	Technology Concepts serial card
 		  0 = /dev/ttyT0	First TCL port
 		  1 = /dev/ttyT1	Second TCL port
@@ -2543,18 +2542,32 @@
 		  0 = /dev/usb/lp0	First USB printer
 		    ...
 		 15 = /dev/usb/lp15	16th USB printer
-		 16 = /dev/usb/mouse0	First USB mouse
-		    ...
-		 31 = /dev/usb/mouse15	16th USB mouse
-		 32 = /dev/usb/ez0	First USB firmware loader
-		    ...
-		 47 = /dev/usb/ez15	16th USB firmware loader
 		 48 = /dev/usb/scanner0	First USB scanner
 		    ...
 		 63 = /dev/usb/scanner15 16th USB scanner
 		 64 = /dev/usb/rio500	Diamond Rio 500
 		 65 = /dev/usb/usblcd	USBLCD Interface (info@usblcd.de)
 		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
+		 96 = /dev/usb/hiddev0	1st USB HID device
+		    ...
+		111 = /dev/usb/hiddev15	16th USB HID device
+		112 = /dev/usb/auer0	1st auerswald ISDN device
+		    ...
+		127 = /dev/usb/auer15	16th auerswald ISDN device
+		128 = /dev/usb/brlvgr0	First Braille Voyager device
+		    ...
+		131 = /dev/usb/brlvgr3	Fourth Braille Voyager device
+		132 = /dev/usb/idmouse	ID Mouse (fingerprint scanner) device
+		133 = /dev/usb/sisusbvga1	First SiSUSB VGA device
+		    ...
+		140 = /dev/usb/sisusbvga8	Eigth SISUSB VGA device
+		144 = /dev/usb/lcd	USB LCD device
+		160 = /dev/usb/legousbtower0	1st USB Legotower device
+		    ...
+		175 = /dev/usb/legousbtower15	16th USB Legotower device
+		240 = /dev/usb/dabusb0	First daubusb device
+		    ...
+		243 = /dev/usb/dabusb3	Fourth dabusb device
 
 180 block	USB block devices
 		0 = /dev/uba		First USB block device
@@ -2715,6 +2728,17 @@
 		  1 = /dev/cpu/1/msr		MSRs on CPU 1
 		    ...
 
+202 block	Xen Virtual Block Device
+		  0 = /dev/xvda       First Xen VBD whole disk
+		  16 = /dev/xvdb      Second Xen VBD whole disk
+		  32 = /dev/xvdc      Third Xen VBD whole disk
+		    ...
+		  240 = /dev/xvdp     Sixteenth Xen VBD whole disk
+
+                Partitions are handled in the same way as for IDE
+                disks (see major number 3) except that the limit on
+                partitions is 15.
+
 203 char	CPU CPUID information
 		  0 = /dev/cpu/0/cpuid		CPUID on CPU 0
 		  1 = /dev/cpu/1/cpuid		CPUID on CPU 1
@@ -2748,15 +2772,30 @@
 		 42 = /dev/ttySMX1		Motorola i.MX - port 1
 		 43 = /dev/ttySMX2		Motorola i.MX - port 2
 		 44 = /dev/ttyMM0		Marvell MPSC - port 0
-		 45 = /dev/ttyMM1		Marvell MPSC - port 1
+		 45 = /dev/ttyMM1		Marvell MPSC - port 1	
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
 		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
-		 50 = /dev/ttyIOC40		Altix serial card
+		 50 = /dev/ttyIOC0		Altix serial card
 		    ...
-		 81 = /dev/ttyIOC431		Altix serial card
-		 82 = /dev/ttyVR0               NEC VR4100 series SIU
-		 83 = /dev/ttyVR1               NEC VR4100 series DSIU
+		 81 = /dev/ttyIOC31		Altix serial card
+		 82 = /dev/ttyVR0		NEC VR4100 series SIU
+		 83 = /dev/ttyVR1		NEC VR4100 series DSIU
+		 84 = /dev/ttyIOC84		Altix ioc4 serial card
+		    ...
+		 115 = /dev/ttyIOC115		Altix ioc4 serial card
+		 116 = /dev/ttySIOC0		Altix ioc3 serial card
+		    ...
+		 147 = /dev/ttySIOC31		Altix ioc3 serial card
+		 148 = /dev/ttyPSC0		PPC PSC - port 0
+		    ...
+		 153 = /dev/ttyPSC5		PPC PSC - port 5
+		 154 = /dev/ttyAT0		ATMEL serial port 0
+		    ...
+		 169 = /dev/ttyAT15		ATMEL serial port 15
+		 170 = /dev/ttyNX0		Hilscher netX serial port 0
+		    ...
+		 185 = /dev/ttyNX15		Hilscher netX serial port 15
 
 205 char	Low-density serial ports (alternate device)
 		  0 = /dev/culu0		Callout device for ttyLU0
@@ -2791,8 +2830,8 @@
 		 50 = /dev/cuioc40		Callout device for ttyIOC40
 		    ...
 		 81 = /dev/cuioc431		Callout device for ttyIOC431
-		 82 = /dev/cuvr0                Callout device for ttyVR0
-		 83 = /dev/cuvr1                Callout device for ttyVR1
+		 82 = /dev/cuvr0		Callout device for ttyVR0
+		 83 = /dev/cuvr1		Callout device for ttyVR1
 
 
 206 char	OnStream SC-x0 tape devices
@@ -2902,7 +2941,6 @@
 		    ...
 		196 = /dev/dvb/adapter3/video0    first video decoder of fourth card
 
-
 216 char	Bluetooth RFCOMM TTY devices
 		  0 = /dev/rfcomm0		First Bluetooth RFCOMM TTY device
 		  1 = /dev/rfcomm1		Second Bluetooth RFCOMM TTY device
@@ -3007,12 +3045,43 @@
 		ioctl()'s can be used to rewind the tape regardless of
 		the device used to access it.
 
-231 char	InfiniBand MAD
+231 char	InfiniBand
 		0 = /dev/infiniband/umad0
 		1 = /dev/infiniband/umad1
-		 ...
+		  ...
+		63 = /dev/infiniband/umad63    63rd InfiniBandMad device
+		64 = /dev/infiniband/issm0     First InfiniBand IsSM device
+		65 = /dev/infiniband/issm1     Second InfiniBand IsSM device
+		  ...
+		127 = /dev/infiniband/issm63    63rd InfiniBand IsSM device
+		128 = /dev/infiniband/uverbs0   First InfiniBand verbs device
+		129 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
+		  ...
+		159 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
 
-232-239		UNASSIGNED
+232 char	Biometric Devices
+		0 = /dev/biometric/sensor0/fingerprint	first fingerprint sensor on first device
+		1 = /dev/biometric/sensor0/iris		first iris sensor on first device
+		2 = /dev/biometric/sensor0/retina	first retina sensor on first device
+		3 = /dev/biometric/sensor0/voiceprint	first voiceprint sensor on first device
+		4 = /dev/biometric/sensor0/facial	first facial sensor on first device
+		5 = /dev/biometric/sensor0/hand		first hand sensor on first device
+		  ...
+		10 = /dev/biometric/sensor1/fingerprint	first fingerprint sensor on second device
+		  ...
+		20 = /dev/biometric/sensor2/fingerprint	first fingerprint sensor on third device
+		  ...
+
+233 char	PathScale InfiniPath interconnect
+		0 = /dev/ipath        Primary device for programs (any unit)
+		1 = /dev/ipath0       Access specifically to unit 0
+		2 = /dev/ipath1       Access specifically to unit 1
+		  ...
+		4 = /dev/ipath3       Access specifically to unit 3
+		129 = /dev/ipath_sma    Device used by Subnet Management Agent
+		130 = /dev/ipath_diag   Device used by diagnostics programs
+
+234-239		UNASSIGNED
 
 240-254 char	LOCAL/EXPERIMENTAL USE
 240-254 block	LOCAL/EXPERIMENTAL USE
@@ -3026,6 +3095,24 @@
 		This major is reserved to assist the expansion to a
 		larger number space.  No device nodes with this major
 		should ever be created on the filesystem.
+		(This is probaly not true anymore, but I'll leave it 
+		for now /Torben)
+
+---LARGE MAJORS!!!!!---
+
+256 char	Equinox SST multi-port serial boards
+		   0 = /dev/ttyEQ0	First serial port on first Equinox SST board
+		 127 = /dev/ttyEQ127	Last serial port on first Equinox SST board
+		 128 = /dev/ttyEQ128	First serial port on second Equinox SST board
+		  ...
+		1027 = /dev/ttyEQ1027	Last serial port on eighth Equinox SST board
+
+256 block	Resident Flash Disk Flash Translation Layer
+		  0 = /dev/rfda		First RFD FTL layer
+		 16 = /dev/rfdb		Second RFD FTL layer
+		  ...
+		240 = /dev/rfdp		16th RFD FTL layer
+
 
  ****	ADDITIONAL /dev DIRECTORY ENTRIES
 
#<<eof>>


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
