Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbTHORSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270640AbTHORSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:18:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:45755 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270655AbTHORSC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:18:02 -0400
Date: Fri, 15 Aug 2003 10:11:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] RFC: remove "Linux 2.4" strings
Message-Id: <20030815101143.72bbea51.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes "Linux 2.4" printed strings from a few
drivers and net protocols.

Instead of changing them to "Linux 2.6", they should just
be deleted, I think.  Other suggestions?

--
~Randy


patch_name:	linux_24_string.patch
patch_version:	2003-08-15.09:24:48
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	remove "Linux 2.4" and variants from printed messages
product:	Linux
product_versions: 260-815
diffstat:	=
 drivers/scsi/imm.h         |    2 +-
 drivers/scsi/ppa.h         |    2 +-
 drivers/usb/misc/brlvger.c |    2 +-
 net/netrom/af_netrom.c     |    2 +-
 net/rose/af_rose.c         |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


diff -Naurp ./drivers/scsi/imm.h~str24 ./drivers/scsi/imm.h
--- ./drivers/scsi/imm.h~str24	2003-08-15 08:28:12.000000000 -0700
+++ ./drivers/scsi/imm.h	2003-08-15 09:15:16.000000000 -0700
@@ -10,7 +10,7 @@
 #ifndef _IMM_H
 #define _IMM_H
 
-#define   IMM_VERSION   "2.05 (for Linux 2.4.0)"
+#define   IMM_VERSION   "2.05"
 
 /* 
  * 10 Apr 1998 (Good Friday) - Received EN144302 by email from Iomega.
diff -Naurp ./drivers/scsi/ppa.h~str24 ./drivers/scsi/ppa.h
--- ./drivers/scsi/ppa.h~str24	2003-08-15 08:29:01.000000000 -0700
+++ ./drivers/scsi/ppa.h	2003-08-15 09:15:39.000000000 -0700
@@ -10,7 +10,7 @@
 #ifndef _PPA_H
 #define _PPA_H
 
-#define   PPA_VERSION   "2.07 (for Linux 2.4.x)"
+#define   PPA_VERSION   "2.07"
 
 /* 
  * this driver has been hacked by Matteo Frigo (athena@theory.lcs.mit.edu)
diff -Naurp ./drivers/usb/misc/brlvger.c~str24 ./drivers/usb/misc/brlvger.c
--- ./drivers/usb/misc/brlvger.c~str24	2003-08-15 08:28:42.000000000 -0700
+++ ./drivers/usb/misc/brlvger.c	2003-08-15 09:08:01.000000000 -0700
@@ -31,7 +31,7 @@
 #define DRIVER_AUTHOR \
 	"Stephane Dalton <sdalton@videotron.ca> " \
 	"and Stéphane Doyon <s.doyon@videotron.ca>"
-#define DRIVER_DESC "Tieman Voyager braille display USB driver for Linux 2.4"
+#define DRIVER_DESC "Tieman Voyager braille display USB driver for Linux"
 #define DRIVER_SHORTDESC "Voyager"
 
 #define BANNER \
diff -Naurp ./net/rose/af_rose.c~str24 ./net/rose/af_rose.c
--- ./net/rose/af_rose.c~str24	2003-08-15 08:28:41.000000000 -0700
+++ ./net/rose/af_rose.c	2003-08-15 09:04:19.000000000 -0700
@@ -1472,7 +1472,7 @@ static struct notifier_block rose_dev_no
 
 static struct net_device **dev_rose;
 
-static const char banner[] = KERN_INFO "F6FBB/G4KLX ROSE for Linux. Version 0.62 for AX25.037 Linux 2.4\n";
+static const char banner[] = KERN_INFO "F6FBB/G4KLX ROSE for Linux. Version 0.62 for AX25.037\n";
 
 static int __init rose_proto_init(void)
 {
diff -Naurp ./net/netrom/af_netrom.c~str24 ./net/netrom/af_netrom.c
--- ./net/netrom/af_netrom.c~str24	2003-08-15 08:28:41.000000000 -0700
+++ ./net/netrom/af_netrom.c	2003-08-15 09:06:51.000000000 -0700
@@ -1381,7 +1381,7 @@ static struct notifier_block nr_dev_noti
 
 static struct net_device **dev_nr;
 
-static char banner[] __initdata = KERN_INFO "G4KLX NET/ROM for Linux. Version 0.7 for AX25.037 Linux 2.4\n";
+static char banner[] __initdata = KERN_INFO "G4KLX NET/ROM for Linux. Version 0.7 for AX25.037\n";
 
 static int __init nr_proto_init(void)
 {
