Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUKCWkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUKCWkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUKCWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:36:33 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:10466 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261947AbUKCWec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:34:32 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, roms@lievin.net, james4765@verizon.net
Message-Id: <20041103223430.25508.36023.26676@localhost.localdomain>
Subject: [PATCH] tipar: Documentation/tipar.txt cleanup
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 16:34:30 -0600
Date: Wed, 3 Nov 2004 16:34:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup of Documentation/tipar.txt.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/tipar.txt linux-2.6.9/Documentation/tipar.txt
--- linux-2.6.9-original/Documentation/tipar.txt	2004-10-18 17:53:06.000000000 -0400
+++ linux-2.6.9/Documentation/tipar.txt	2004-11-03 10:54:22.532837902 -0500
@@ -4,7 +4,7 @@
 
 
 Author: Romain Lievin
-Homepage: http://lpg.ticalc.org/prj_dev
+Homepage: http://lpg.ticalc.org/prj_tidev/index.html
 
 
 INTRODUCTION:
@@ -12,31 +12,30 @@
 This is a driver for the very common home-made parallel link cable, a cable 
 designed for connecting TI8x/9x graphing calculators (handhelds) to a computer
 or workstation (Alpha, Sparc). Given that driver is built on parport, the 
-parallel port abstraction layer, this driver is independent of the platform.
+parallel port abstraction layer, this driver is architecture-independent.
 
 It can also be used with another device plugged on the same port (such as a
-ZIP drive). I have a 100MB ZIP and both of them work fine !
+ZIP drive). I have a 100MB ZIP and both of them work fine!
 
 If you need more information, please visit the 'TI drivers' homepage at the URL
 above.
 
 WHAT YOU NEED:
 
-A TI calculator of course and a program capable to communicate with your 
-calculator.
-TiLP will work for sure (since I am his developer !). yal92 may be able to use
+A TI calculator and a program capable of communicating with your calculator.
+
+TiLP will work for sure (since I am its developer!). yal92 may be able to use
 it by changing tidev for tipar (may require some hacking...).
 
 HOW TO USE IT:
 
 You must have first compiled parport support (CONFIG_PARPORT_DEV): either 
 compiled in your kernel, either as a module. 
-This driver supports the new device hierarchy (devfs).
 
-Next, (as root) from your appropriate modules directory (lib/modules/2.5.XX):
+Next, (as root):
 
        modprobe parport
-       insmod tipar.o
+       modprobe tipar
 
 If it is not already there (it usually is), create the device:
 
@@ -47,14 +46,14 @@
 You will have to set permissions on this device to allow you to read/write
 from it:
 
-       chmod 666 /dev/tipar?
+       chmod 666 /dev/tipar[0..2]
        
 Now you are ready to run a linking program such as TiLP. Be sure to configure 
 it properly (RTFM).
        
 MODULE PARAMETERS:
 
-  You can set these with:  insmod tipar NAME=VALUE
+  You can set these with:  modprobe tipar NAME=VALUE
   There is currently no way to set these on a per-cable basis.
 
   NAME: timeout
@@ -66,11 +65,12 @@
   NAME: delay
   TYPE: integer
   DEFAULT: 10
-  DESC: Inter-bit delay in micro-seconds. An lower value gives an higher data 
+  DESC: Inter-bit delay in micro-seconds. A lower value gives an higher data 
 	rate but makes transmission less reliable.
 
 These parameters can be changed at run time by any program via ioctl(2) calls 
-as listed in ./include/linux/ticable.h
+as listed in ./include/linux/ticable.h.
+
 Rather than write 50 pages describing the ioctl() and so on, it is
 perhaps more useful you look at ticables library (dev_link.c) that demonstrates
 how to use them, and demonstrates the features of the driver. This is
