Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273667AbRIWWmw>; Sun, 23 Sep 2001 18:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273670AbRIWWmm>; Sun, 23 Sep 2001 18:42:42 -0400
Received: from CPE-61-9-150-176.vic.bigpond.net.au ([61.9.150.176]:42748 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273667AbRIWWmj>; Sun, 23 Sep 2001 18:42:39 -0400
Message-ID: <3BAE64E8.EC552B76@eyal.emu.id.au>
Date: Mon, 24 Sep 2001 08:40:41 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10 - necessary patches
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------CE51B378516A67323015C190"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CE51B378516A67323015C190
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

To build 2.4.10 I needed these two (old) patches.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------CE51B378516A67323015C190
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-aironet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-aironet.patch"

--- linux/drivers/net/aironet4500_card.c.orig	Fri Sep 21 22:14:16 2001
+++ linux/drivers/net/aironet4500_card.c	Fri Sep 21 22:14:37 2001
@@ -17,6 +17,7 @@
 #endif
 
 #include <linux/version.h>
+#include <linux/init.h>
 #include <linux/config.h>
 #include <linux/module.h>
 

--------------CE51B378516A67323015C190
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-cpqfc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-cpqfc.patch"

--- linux-2.4.10-pre7/include/scsi/scsi.h	Fri Apr 27 13:59:19 2001
+++ linux/include/scsi/scsi.h	Mon Sep 10 03:53:58 2001
@@ -214,6 +214,12 @@
 /* Used to get the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387
 
+/* Used to invoke Target Defice Reset for Fibre Channel */
+#define SCSI_IOCTL_FC_TDR 0x5388
+
+/* Used to get Fibre Channel WWN and port_id from device */
+#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5389
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
--- linux-2.4.10-pre7/drivers/scsi/cpqfcTSinit.c	Sun Aug 12 10:51:41 2001
+++ linux/drivers/scsi/cpqfcTSinit.c	Mon Sep 10 03:54:23 2001
@@ -63,6 +63,7 @@
 
 #include <linux/config.h>  
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/version.h> 
 
 /* Embedded module documentation macros - see module.h */

--------------CE51B378516A67323015C190--

