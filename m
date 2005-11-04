Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVKDWMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVKDWMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVKDWMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:12:07 -0500
Received: from verein.lst.de ([213.95.11.210]:5542 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751028AbVKDWMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:12:06 -0500
Date: Fri, 4 Nov 2005 23:12:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move some COMPATIBLE_IOCTL entries from x86_64 to common code
Message-ID: <20051104221201.GA9354@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_50_75
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ia32_ioctl.c	2005-11-04 14:00:50.000000000 +0100
+++ linux-2.6/arch/x86_64/ia32/ia32_ioctl.c	2005-11-04 14:00:59.000000000 +0100
@@ -64,12 +64,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "compat_ioctl.c"
-COMPATIBLE_IOCTL(HDIO_SET_KEEPSETTINGS)
-COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
-COMPATIBLE_IOCTL(BLKRASET)
-COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
-COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
-COMPATIBLE_IOCTL(FIOQSIZE)
 
 /* And these ioctls need translation */
 /* realtime device */
Index: linux-2.6/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.orig/include/linux/compat_ioctl.h	2005-11-04 14:00:50.000000000 +0100
+++ linux-2.6/include/linux/compat_ioctl.h	2005-11-04 14:00:59.000000000 +0100
@@ -10,6 +10,10 @@
 #define ULONG_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
 #endif
 
+
+COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
+COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
+
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
 COMPATIBLE_IOCTL(TCSETA)
@@ -81,6 +85,8 @@
 COMPATIBLE_IOCTL(HDIO_DRIVE_TASK)
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
 COMPATIBLE_IOCTL(HDIO_SET_NICE)
+COMPATIBLE_IOCTL(HDIO_SET_KEEPSETTINGS)
+COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON)
 COMPATIBLE_IOCTL(FDMSGOFF)
@@ -99,6 +105,7 @@
 COMPATIBLE_IOCTL(FDFMTTRK)
 COMPATIBLE_IOCTL(FDRAWCMD)
 /* 0x12 */
+COMPATIBLE_IOCTL(BLKRASET)
 COMPATIBLE_IOCTL(BLKROSET)
 COMPATIBLE_IOCTL(BLKROGET)
 COMPATIBLE_IOCTL(BLKRRPART)
@@ -262,6 +269,7 @@
 /* Little m */
 COMPATIBLE_IOCTL(MTIOCTOP)
 /* Socket level stuff */
+COMPATIBLE_IOCTL(FIOQSIZE)
 COMPATIBLE_IOCTL(FIOSETOWN)
 COMPATIBLE_IOCTL(SIOCSPGRP)
 COMPATIBLE_IOCTL(FIOGETOWN)
