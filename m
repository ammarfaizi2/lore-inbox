Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUJ1OkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUJ1OkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUJ1Oh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:37:27 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:54982 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261677AbUJ1Oft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:35:49 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au, james4765@verizon.net
Message-Id: <20041028143548.2667.72439.46892@localhost.localdomain>
Subject: [PATCH 1/2] to Documentation/cpqarray.txt
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 09:35:48 -0500
Date: Thu, 28 Oct 2004 09:35:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: General cleanup of Documentation/cpqarray.txt.  Removal of old and
obsolete references, removed references to an external patch.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/cpqarray.txt linux-2.6.9/Documentation/cpqarray.txt
--- linux-2.6.9-original/Documentation/cpqarray.txt	2004-10-18 17:54:29.000000000 -0400
+++ linux-2.6.9/Documentation/cpqarray.txt	2004-10-28 10:28:46.156798094 -0400
@@ -26,31 +26,13 @@
 	* IDA-2
 	* IAES
 
-Installing:
------------
-
-You need to build a new kernel to use this device, even if you want to
-use a loadable module.  
-
-Apply the patch to a 2.2.x kernel:
-
-# cd linux
-# patch -p1 <smart2.patch
-
-Then build a new kernel and turn on Compaq SMART2 Disk Array support.
-Create device nodes for the diskarray device:
-
-# mkdev.ida [ctlrs]
-
-Where ctlrs is the number of controllers you have (defaults to 1 if not
-specified).
 
 EISA Controllers:
 -----------------
 
 If you want to use an EISA controller you'll have to supply some
-insmod/lilo parameters.  If the driver is compiled into the kernel, must
-give it the controller's IO port address at boot time (it is no longer
+modprobe/lilo parameters.  If the driver is compiled into the kernel, must
+give it the controller's IO port address at boot time (it is not
 necessary to specify the IRQ).  For example, if you had two SMART-2/E
 controllers, in EISA slots 1 and 2 you'd give it a boot argument like
 this:
@@ -59,29 +41,27 @@
 
 If you were loading the driver as a module, you'd give load it like this:
 
-	insmod cpqarray.o eisa=0x1000,0x2000
+	modprobe cpqarray eisa=0x1000,0x2000
 
 You can use EISA and PCI adapters at the same time.
 
-Booting:
---------
-
-You'll need to use a modified lilo if you want to boot from a disk array.
-Its simply a version of lilo with some code added to tell it how to
-understand Compaq diskarray devices.
 
 Device Naming:
 --------------
 
-You need some entries in /dev for the ida device.  The mkdev.ida script
-can make device nodes for you automatically.  Currently the device setup
-is as follows:
+You need some entries in /dev for the ida device.  MAKEDEV in the /dev
+directory can make device nodes for you automatically.  The device setup is
+as follows:
 
 Major numbers:
 	72	ida0
 	73	ida1
 	74	ida2
-	etc...
+	75	ida3
+	76	ida4
+	77	ida5
+	78	ida6
+	79	ida7
 
 Minor numbers:
         b7 b6 b5 b4 b3 b2 b1 b0
@@ -91,7 +71,7 @@
              |
              +-------------------- Logical Volume number
 
-The suggested device naming scheme is:
+The device naming scheme is:
 /dev/ida/c0d0		Controller 0, disk 0, whole device
 /dev/ida/c0d0p1		Controller 0, disk 0, partition 1
 /dev/ida/c0d0p2		Controller 0, disk 0, partition 2
@@ -101,3 +81,13 @@
 /dev/ida/c1d1p1		Controller 1, disk 1, partition 1
 /dev/ida/c1d1p2		Controller 1, disk 1, partition 2
 /dev/ida/c1d1p3		Controller 1, disk 1, partition 3
+
+
+Changelog:
+==========
+
+10-28-2004 :	General cleanup, syntax fixes for in-kernel driver version.
+		James Nelson <james4765@gmail.com>
+
+
+1999 :		Original Document
