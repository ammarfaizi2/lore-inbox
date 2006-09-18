Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWIRBja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWIRBja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWIRBjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:39:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:39405 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965219AbWIRBiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:23 -0400
Message-Id: <20060918013217.356156000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:45 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 5/8] add missing #includes in user space parts of headers
Content-Disposition: inline; filename=headercheck.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These files should include some other headers in order
to be included from user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/include/asm-s390/cmb.h
===================================================================
--- linux-cg.orig/include/asm-s390/cmb.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/asm-s390/cmb.h	2006-09-18 02:36:00.000000000 +0200
@@ -1,5 +1,9 @@
 #ifndef S390_CMB_H
 #define S390_CMB_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
 /**
  * struct cmbdata -- channel measurement block data for user space
  *
Index: linux-cg/include/asm-s390/dasd.h
===================================================================
--- linux-cg.orig/include/asm-s390/dasd.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/asm-s390/dasd.h	2006-09-18 02:36:00.000000000 +0200
@@ -13,6 +13,7 @@
 #ifndef DASD_H
 #define DASD_H
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define DASD_IOCTL_LETTER 'D'
 
Index: linux-cg/include/asm-s390/qeth.h
===================================================================
--- linux-cg.orig/include/asm-s390/qeth.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/asm-s390/qeth.h	2006-09-18 02:36:00.000000000 +0200
@@ -11,6 +11,7 @@
 #ifndef __ASM_S390_QETH_IOCTL_H__
 #define __ASM_S390_QETH_IOCTL_H__
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define SIOC_QETH_ARP_SET_NO_ENTRIES    (SIOCDEVPRIVATE)
 #define SIOC_QETH_ARP_QUERY_INFO        (SIOCDEVPRIVATE + 1)
Index: linux-cg/include/linux/atm.h
===================================================================
--- linux-cg.orig/include/linux/atm.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/atm.h	2006-09-18 02:36:00.000000000 +0200
@@ -11,6 +11,7 @@
 #ifndef _LINUX_ATM_H
 #define _LINUX_ATM_H
 
+#include <linux/types.h>
 /*
  * BEGIN_xx and END_xx markers are used for automatic generation of
  * documentation. Do not change them.
Index: linux-cg/include/linux/audit.h
===================================================================
--- linux-cg.orig/include/linux/audit.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/audit.h	2006-09-18 02:36:00.000000000 +0200
@@ -25,6 +25,7 @@
 #define _LINUX_AUDIT_H_
 
 #include <linux/elf-em.h>
+#include <linux/types.h>
 
 /* The netlink messages for the audit system is divided into blocks:
  * 1000 - 1099 are for commanding the audit system
Index: linux-cg/include/linux/cm4000_cs.h
===================================================================
--- linux-cg.orig/include/linux/cm4000_cs.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/cm4000_cs.h	2006-09-18 02:36:00.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef	_CM4000_H_
 #define	_CM4000_H_
 
+#include <linux/types.h>
+
 #define	MAX_ATR			33
 
 #define	CM4000_MAX_DEV		4
Index: linux-cg/include/linux/cyclades.h
===================================================================
--- linux-cg.orig/include/linux/cyclades.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/cyclades.h	2006-09-18 02:36:00.000000000 +0200
@@ -67,6 +67,8 @@
 #ifndef _LINUX_CYCLADES_H
 #define _LINUX_CYCLADES_H
 
+#include <linux/types.h>
+
 struct cyclades_monitor {
         unsigned long           int_count;
         unsigned long           char_count;
Index: linux-cg/include/linux/ftape-header-segment.h
===================================================================
--- linux-cg.orig/include/linux/ftape-header-segment.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/ftape-header-segment.h	2006-09-18 02:36:00.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _FTAPE_HEADER_SEGMENT_H
 #define _FTAPE_HEADER_SEGMENT_H
 
+#include <linux/types.h>
 /*
  * Copyright (C) 1996-1997 Claus-Justus Heine.
 
Index: linux-cg/include/linux/hiddev.h
===================================================================
--- linux-cg.orig/include/linux/hiddev.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/hiddev.h	2006-09-18 02:36:00.000000000 +0200
@@ -29,6 +29,8 @@
  * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
  */
 
+#include <linux/types.h>
+
 /*
  * The event structure itself
  */
Index: linux-cg/include/linux/i2o-dev.h
===================================================================
--- linux-cg.orig/include/linux/i2o-dev.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/i2o-dev.h	2006-09-18 02:36:00.000000000 +0200
@@ -24,6 +24,7 @@
 #define MAX_I2O_CONTROLLERS	32
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 /*
  * I2O Control IOCTLs and structures
Index: linux-cg/include/linux/ite_gpio.h
===================================================================
--- linux-cg.orig/include/linux/ite_gpio.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/ite_gpio.h	2006-09-18 02:36:00.000000000 +0200
@@ -33,6 +33,7 @@
 #ifndef __ITE_GPIO_H
 #define __ITE_GPIO_H
 
+#include <linux/types.h>
 #include <linux/ioctl.h>
 
 struct ite_gpio_ioctl_data {
Index: linux-cg/include/linux/loop.h
===================================================================
--- linux-cg.orig/include/linux/loop.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/loop.h	2006-09-18 02:36:00.000000000 +0200
@@ -77,8 +77,8 @@
 	LO_FLAGS_USE_AOPS	= 2,
 };
 
-#include <asm/posix_types.h>	/* for __kernel_old_dev_t */
-#include <asm/types.h>		/* for __u64 */
+#include <linux/posix_types.h>	/* for __kernel_old_dev_t */
+#include <linux/types.h>		/* for __u64 */
 
 /* Backwards compatibility version */
 struct loop_info {
Index: linux-cg/include/linux/nbd.h
===================================================================
--- linux-cg.orig/include/linux/nbd.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/nbd.h	2006-09-18 02:36:00.000000000 +0200
@@ -15,6 +15,8 @@
 #ifndef LINUX_NBD_H
 #define LINUX_NBD_H
 
+#include <linux/types.h>
+
 #define NBD_SET_SOCK	_IO( 0xab, 0 )
 #define NBD_SET_BLKSIZE	_IO( 0xab, 1 )
 #define NBD_SET_SIZE	_IO( 0xab, 2 )
Index: linux-cg/include/linux/pkt_sched.h
===================================================================
--- linux-cg.orig/include/linux/pkt_sched.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/pkt_sched.h	2006-09-18 02:45:05.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_PKT_SCHED_H
 #define __LINUX_PKT_SCHED_H
 
+#include <linux/types.h>
+
 /* Logical priority bands not depending on specific packet scheduler.
    Every scheduler will map them to real traffic classes, if it has
    no more precise mechanism to classify packets.
Index: linux-cg/include/linux/ppp_defs.h
===================================================================
--- linux-cg.orig/include/linux/ppp_defs.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/ppp_defs.h	2006-09-18 02:43:44.000000000 +0200
@@ -42,6 +42,8 @@
 #ifndef _PPP_DEFS_H_
 #define _PPP_DEFS_H_
 
+#include <linux/types.h>
+
 /*
  * The basic PPP frame.
  */
Index: linux-cg/include/linux/qic117.h
===================================================================
--- linux-cg.orig/include/linux/qic117.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/qic117.h	2006-09-18 02:36:00.000000000 +0200
@@ -53,6 +53,8 @@
  *       QIC-CRF3,    Rev. B, 15 Jun 95.
  * */
 
+#include <linux/types.h>
+
 /*
  *      QIC-117 common command set rev. J.
  *      These commands are sent to the tape unit
Index: linux-cg/include/linux/qnxtypes.h
===================================================================
--- linux-cg.orig/include/linux/qnxtypes.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/qnxtypes.h	2006-09-18 02:36:00.000000000 +0200
@@ -12,6 +12,8 @@
 #ifndef _QNX4TYPES_H
 #define _QNX4TYPES_H
 
+#include <linux/types.h>
+
 typedef __le16 qnx4_nxtnt_t;
 typedef __u8  qnx4_ftype_t;
 
Index: linux-cg/include/linux/raid/md_p.h
===================================================================
--- linux-cg.orig/include/linux/raid/md_p.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/raid/md_p.h	2006-09-18 02:36:00.000000000 +0200
@@ -15,6 +15,7 @@
 #ifndef _MD_P_H
 #define _MD_P_H
 
+#include <linux/types.h>
 /*
  * RAID superblock.
  *
Index: linux-cg/include/linux/random.h
===================================================================
--- linux-cg.orig/include/linux/random.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/random.h	2006-09-18 02:36:00.000000000 +0200
@@ -8,6 +8,7 @@
 #define _LINUX_RANDOM_H
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 /* ioctl()'s for the random number generator */
 
Index: linux-cg/include/linux/reiserfs_xattr.h
===================================================================
--- linux-cg.orig/include/linux/reiserfs_xattr.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/reiserfs_xattr.h	2006-09-18 02:36:00.000000000 +0200
@@ -3,6 +3,7 @@
 */
 
 #include <linux/xattr.h>
+#include <linux/types.h>
 
 /* Magic value in header */
 #define REISERFS_XATTR_MAGIC 0x52465841	/* "RFXA" */
Index: linux-cg/include/linux/video_decoder.h
===================================================================
--- linux-cg.orig/include/linux/video_decoder.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/video_decoder.h	2006-09-18 02:36:00.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_VIDEO_DECODER_H
 #define _LINUX_VIDEO_DECODER_H
 
+#include <linux/types.h>
+
 #define HAVE_VIDEO_DECODER 1
 
 struct video_decoder_capability { /* this name is too long */
Index: linux-cg/include/linux/video_encoder.h
===================================================================
--- linux-cg.orig/include/linux/video_encoder.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/video_encoder.h	2006-09-18 02:36:00.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_VIDEO_ENCODER_H
 #define _LINUX_VIDEO_ENCODER_H
 
+#include <linux/types.h>
+
 struct video_encoder_capability { /* this name is too long */
 	__u32	flags;
 #define	VIDEO_ENCODER_PAL	1	/* can encode PAL signal */
Index: linux-cg/include/linux/videodev2.h
===================================================================
--- linux-cg.orig/include/linux/videodev2.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/linux/videodev2.h	2006-09-18 02:36:00.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/compiler.h> /* need __user */
 #else
 #define __user
+#include <sys/time.h>
 #endif
 #include <linux/types.h>
 
Index: linux-cg/include/sound/hdsp.h
===================================================================
--- linux-cg.orig/include/sound/hdsp.h	2006-09-18 02:36:00.000000000 +0200
+++ linux-cg/include/sound/hdsp.h	2006-09-18 02:36:00.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __SOUND_HDSP_H
 #define __SOUND_HDSP_H
 
+#include <linux/types.h>
+
 /*
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
  *    

--

