Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbULLOVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbULLOVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 09:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbULLOVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 09:21:08 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:21494 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262075AbULLOUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 09:20:50 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041212142111.10724.41066.68754@localhost.localdomain>
Subject: [PATCH] stallion: Update to Documentation/stallion.txt
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Sun, 12 Dec 2004 08:20:49 -0600
Date: Sun, 12 Dec 2004 08:20:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some updating and removal of dead links in the text file.

The 5.5 package is not carried on the sunsite.unc.edu or tsx-11.mit.edu FTP servers,
and the support@stallion.com address bounces.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-original/Documentation/stallion.txt linux-2.6.10-rc3/Documentation/stallion.txt
--- linux-2.6.10-rc3-original/Documentation/stallion.txt	2004-12-03 16:54:39.000000000 -0500
+++ linux-2.6.10-rc3/Documentation/stallion.txt	2004-12-12 09:12:56.763449225 -0500
@@ -1,8 +1,13 @@
+* NOTE - This is an unmaintained driver.  Lantronix, which bought Stallion
+technologies, is not active in driver maintenance, and they have no information
+on when or if they will have a 2.6 driver.
+
+James Nelson <james4765@gmail.com> - 12-12-2004
 
 Stallion Multiport Serial Driver Readme
 ---------------------------------------
 
-Copyright (C) 1994-1999,  Stallion Technologies (support@stallion.com).
+Copyright (C) 1994-1999,  Stallion Technologies.
 
 Version:   5.5.1
 Date:      28MAR99
@@ -19,29 +24,20 @@
 
 If you are using any of the Stallion intelligent multiport boards (Brumby,
 ONboard, EasyConnection 8/64 (ISA, EISA, MCA), EasyConnection/RA-PCI) with
-Linux you will need to get the driver utility package. This package is
-available at most of the Linux archive sites (and on CD-ROMs that contain
-these archives). The file will be called stallion-X.X.X.tar.gz where X.X.X
-will be the version number. In particular this package contains the board
-embedded executable images that are required for these boards. It also
-contains the downloader program. These boards cannot be used without this.
+Linux you will need to get the driver utility package.  This contains a
+firmware loader and the firmware images necessary to make the devices operate.
 
 The Stallion Technologies ftp site, ftp.stallion.com, will always have
-the latest version of the driver utility package. Other sites that usually
-have the latest version are tsx-11.mit.edu, sunsite.unc.edu and their
-mirrors.
-
-ftp.stallion.com:/drivers/ata5/Linux/v550.tar.gz
-tsx-11.mit.edu:/pub/linux/packages/stallion/stallion-5.5.0.tar.gz
-sunsite.unc.edu:/pub/Linux/kernel/patches/serial/stallion-5.5.0.tar.gz
+the latest version of the driver utility package.
+
+ftp://ftp.stallion.com/drivers/ata5/Linux/ata-linux-550.tar.gz
 
 As of the printing of this document the latest version of the driver
 utility package is 5.5.0. If a later version is now available then you
 should use the latest version.
 
 If you are using the EasyIO, EasyConnection 8/32 or EasyConnection 8/64-PCI
-boards then you don't need this package. Although it does have a handy
-script to create the /dev device nodes for these boards, and a serial stats
+boards then you don't need this package, although it does have a serial stats
 display program.
 
 If you require DIP switch settings, EISA or MCA configuration files, or any
@@ -85,7 +81,7 @@
 
 Typically to load up the smart board driver use:
 
-    insmod stallion.o
+    modprobe stallion
 
 This will load the EasyIO and EasyConnection 8/32 driver. It will output a
 message to say that it loaded and print the driver version number. It will
@@ -96,12 +92,12 @@
 
 To load the intelligent board driver use:
 
-    insmod istallion.o
+    modprobe istallion
 
 It will output similar messages to the smart board driver.
 
 If not using an auto-detectable board type (that is a PCI board) then you
-will also need to supply command line arguments to the "insmod" command
+will also need to supply command line arguments to the modprobe command
 when loading the driver. The general form of the configuration argument is
 
     board?=<name>[,<ioaddr>[,<addr>][,<irq>]]
@@ -111,7 +107,7 @@
     board?  -- specifies the arbitrary board number of this board,
                can be in the range 0 to 3.
 
-    name    -- textual name of this board. The board name is the comman
+    name    -- textual name of this board. The board name is the common
                board name, or any "shortened" version of that. The board
                type number may also be used here.
 
@@ -127,24 +123,24 @@
 Up to 4 board configuration arguments can be specified on the load line.
 Here is some examples:
 
-    insmod stallion.o board0=easyio,0x2a0,5
+    modprobe stallion board0=easyio,0x2a0,5
 
 This configures an EasyIO board as board 0 at I/O address 0x2a0 and IRQ 5.
 
-    insmod istallion.o board3=ec8/64,0x2c0,0xcc000
+    modprobe istallion board3=ec8/64,0x2c0,0xcc000
 
 This configures an EasyConnection 8/64 ISA as board 3 at I/O address 0x2c0 at
 memory address 0xcc000.
 
-    insmod stallion.o board1=ec8/32-at,0x2a0,0x280,10
+    modprobe stallion board1=ec8/32-at,0x2a0,0x280,10
 
 This configures an EasyConnection 8/32 ISA board at primary I/O address 0x2a0,
 secondary address 0x280 and IRQ 10.
 
 You will probably want to enter this module load and configuration information
 into your system startup scripts so that the drivers are loaded and configured
-on each system boot. Typically the start up script would be something line
-/etc/rc.d/rc.modules.
+on each system boot. Typically the start up script would be something like
+/etc/modprobe.conf.
 
 
 2.2 STATIC DRIVER CONFIGURATION:
@@ -161,8 +157,8 @@
 To set up the driver(s) for the boards that you want to use you need to
 edit the appropriate driver file and add configuration entries.
 
-If using EasyIO or EasyConnection 8/32 ISA or MCA boards, do:
-   vi /usr/src/linux/drivers/char/stallion.c
+If using EasyIO or EasyConnection 8/32 ISA or MCA boards,
+   In drivers/char/stallion.c:
       - find the definition of the stl_brdconf array (of structures)
         near the top of the file
       - modify this to match the boards you are going to install
@@ -170,8 +166,8 @@
       - save and exit
 
 If using ONboard, Brumby, Stallion or EasyConnection 8/64 (ISA or EISA)
-boards then do:
-   vi /usr/src/linux/drivers/char/istallion.c
+boards,
+   In drivers/char/istallion.c:
       - find the definition of the stli_brdconf array (of structures)
         near the top of the file
       - modify this to match the boards you are going to install
@@ -291,20 +287,20 @@
 of course the ports will not be operational!
 
 If you are using the modularized version of the driver you might want to put
-the insmod calls in the startup script as well (before the download lines
+the modprobe calls in the startup script as well (before the download lines
 obviously).
 
 
 3.2 USING THE SERIAL PORTS
 
 Once the driver is installed you will need to setup some device nodes to
-access the serial ports. The simplest method is to use the stallion utility
-"mkdevnods" script. It will automatically create device entries for Stallion
-boards. This will create the normal serial port devices as /dev/ttyE# where
-# is the port number starting from 0. A bank of 64 minor device numbers is
-allocated to each board, so the first port on the second board is port 64,
-etc. A set of callout type devices is also created. They are created as the
-devices /dev/cue# where # is the same as for the ttyE devices.
+access the serial ports. The simplest method is to use the /dev/MAKEDEV program.
+It will automatically create device entries for Stallion boards. This will
+create the normal serial port devices as /dev/ttyE# where# is the port number
+starting from 0. A bank of 64 minor device numbers is allocated to each board,
+so the first port on the second board is port 64,etc. A set of callout type
+devices may also be created. They are created as the devices /dev/cue# where #
+is the same as for the ttyE devices.
 
 For the most part the Stallion driver tries to emulate the standard PC system
 COM ports and the standard Linux serial driver. The idea is that you should
