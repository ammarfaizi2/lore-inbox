Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270969AbTG0Xbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTG0Xbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:31:31 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272995AbTG0XCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:46 -0400
Date: Sun, 27 Jul 2003 21:06:20 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272006.h6RK6K7t029635@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: more typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/media/video/zr36120.c linux-2.6.0-test2-ac1/drivers/media/video/zr36120.c
--- linux-2.6.0-test2/drivers/media/video/zr36120.c	2003-07-10 21:09:33.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/media/video/zr36120.c	2003-07-15 18:01:29.000000000 +0100
@@ -488,7 +488,7 @@
 		    vcp->width < 0 || (uint)(vcp->x+vcp->width) > ztv->overinfo.w ||
 		    vcp->height < 0 || (vcp->y+vcp->height) > ztv->overinfo.h)
 		{
-			DEBUG(printk(CARD_DEBUG "illegal clipzone (%d,%d,%d,%d) not in (0,0,%d,%d), adapting\n",CARD,vcp->x,vcp->y,vcp->width,vcp->height,ztv->overinfo.w,ztv->overinfo.h));
+			DEBUG(printk(CARD_DEBUG "invalid clipzone (%d,%d,%d,%d) not in (0,0,%d,%d), adapting\n",CARD,vcp->x,vcp->y,vcp->width,vcp->height,ztv->overinfo.w,ztv->overinfo.h));
 			if (vcp->x < 0) vcp->x = 0;
 			if ((uint)vcp->x > ztv->overinfo.w) vcp->x = ztv->overinfo.w;
 			if (vcp->y < 0) vcp->y = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/mtd/maps/elan-104nc.c linux-2.6.0-test2-ac1/drivers/mtd/maps/elan-104nc.c
--- linux-2.6.0-test2/drivers/mtd/maps/elan-104nc.c	2003-07-10 21:09:03.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/mtd/maps/elan-104nc.c	2003-07-23 16:39:58.000000000 +0100
@@ -27,7 +27,7 @@
    
    16 bit I/O port (0x22) for some sort of paging.
 
-The single flash device is divided into 3 partition which appear as seperate
+The single flash device is divided into 3 partition which appear as separate
 MTD devices.
 
 Linux thinks that the I/O port is used by the PIC and hence check_region() will
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/mtd/maps/scb2_flash.c linux-2.6.0-test2-ac1/drivers/mtd/maps/scb2_flash.c
--- linux-2.6.0-test2/drivers/mtd/maps/scb2_flash.c	2003-07-10 21:10:50.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/mtd/maps/scb2_flash.c	2003-07-23 16:39:58.000000000 +0100
@@ -31,17 +31,17 @@
  *
  * The actual BIOS layout has been mostly reverse engineered.  Intel BIOS
  * updates for this board include 10 related (*.bio - &.bi9) binary files and
- * another seperate (*.bbo) binary file.  The 10 files are 64k of data + a
+ * another separate (*.bbo) binary file.  The 10 files are 64k of data + a
  * small header.  If the headers are stripped off, the 10 64k files can be
  * concatenated into a 640k image.  This is your BIOS image, proper.  The
- * seperate .bbo file also has a small header.  It is the 'Boot Block'
+ * separate .bbo file also has a small header.  It is the 'Boot Block'
  * recovery BIOS.  Once the header is stripped, no further prep is needed.
  * As best I can tell, the BIOS is arranged as such:
  * offset 0x00000 to 0x4ffff (320k):  unknown - SCSI BIOS, etc?
  * offset 0x50000 to 0xeffff (640k):  BIOS proper
  * offset 0xf0000 ty 0xfffff (64k):   Boot Block region
  *
- * Intel's BIOS update program flashes the BIOS and Boot Block in seperate
+ * Intel's BIOS update program flashes the BIOS and Boot Block in separate
  * steps.  Probably a wise thing to do.
  */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/eepro.c linux-2.6.0-test2-ac1/drivers/net/eepro.c
--- linux-2.6.0-test2/drivers/net/eepro.c	2003-07-10 21:12:49.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/eepro.c	2003-07-15 18:01:29.000000000 +0100
@@ -819,7 +819,7 @@
 					}
 				}
 				if (dev->irq < 2) {
-			printk(KERN_ERR " Duh! illegal interrupt vector stored in EEPROM.\n");
+			printk(KERN_ERR " Duh! invalid interrupt vector stored in EEPROM.\n");
 			retval = -ENODEV;
 			goto freeall;
 				} else
