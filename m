Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263686AbTCUSQA>; Fri, 21 Mar 2003 13:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263698AbTCUSPI>; Fri, 21 Mar 2003 13:15:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45955
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263700AbTCUSO1>; Fri, 21 Mar 2003 13:14:27 -0500
Date: Fri, 21 Mar 2003 19:29:41 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211929.h2LJTfnV025808@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Update ide/legacy makefile to match changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/Makefile linux-2.5.65-ac2/drivers/ide/legacy/Makefile
--- linux-2.5.65/drivers/ide/legacy/Makefile	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/Makefile	2003-03-14 01:21:29.000000000 +0000
@@ -2,6 +2,7 @@
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+= ali14xx.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+= dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+= ht6560b.o
+obj-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
 obj-$(CONFIG_BLK_DEV_PDC4030)		+= pdc4030.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+= qd65xx.o
 obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
@@ -15,6 +16,10 @@
 obj-$(CONFIG_BLK_DEV_IDECS)		+= ide-cs.o
 
 # Last of all
+ifneq ($(CONFIG_X86_PC9800),y)
 obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
+else
+obj-$(CONFIG_BLK_DEV_HD)		+= hd98.o
+endif
 
 EXTRA_CFLAGS	:= -Idrivers/ide
