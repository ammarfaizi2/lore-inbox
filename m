Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbTH3RaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTH3RaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 13:30:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:59286 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261795AbTH3RaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 13:30:01 -0400
X-KENId: 00007976KEN0F6031C2
X-KENRelayed: 00007976KEN0F6031C2@KEN
Date: Sat, 30 Aug 2003 19:30:21 +0200
From: =?ISO-8859-1?Q?Johannes_H=F6lzl?= <johannes.hoelzl@gmx.de>
Subject: [PATCH] add MODULE_DEVICE_TABLE to ide/pci/*.c, EXPORT_NO_SYMBOL
   to triflex.c, kernel 2.4.21
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Message-Id: <3F50DF2D.6050907@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
   boundary="------------070108010508040601000508"
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: de-de, de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070108010508040601000508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

this simple patch adds MODULE_DEVICE_TABLE for every driver in 
drivers/ide/pci.
So their PCI-ID is listed in modules.pcimap.

It also adds EXPORT_NO_SYMBOL to "triflex.c". I have added it because every
other module in drivers/ide/pci defines it .

Greetings,
    Johannes Hölzl


--------------070108010508040601000508
Content-Type: text/plain;
 name="patch-pcimap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pcimap"

--- kernel-source-2.4.21/drivers/ide/pci/adma100.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/adma100.c	2003-08-30 17:02:37.000000000 +0200
@@ -76,5 +76,7 @@
 MODULE_DESCRIPTION("Basic PIO support for ADMA100 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, adma100_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
 
--- kernel-source-2.4.21/drivers/ide/pci/aec62xx.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/aec62xx.c	2003-08-30 17:03:14.000000000 +0200
@@ -565,4 +565,6 @@
 MODULE_DESCRIPTION("PCI driver module for ARTOP AEC62xx IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/alim15x3.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/alim15x3.c	2003-08-30 18:18:31.000000000 +0200
@@ -913,4 +913,6 @@
 MODULE_DESCRIPTION("PCI driver module for ALi 15x3 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/amd74xx.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/amd74xx.c	2003-08-30 17:04:24.000000000 +0200
@@ -480,4 +480,6 @@
 MODULE_DESCRIPTION("AMD PCI IDE driver");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/cmd64x.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/cmd64x.c	2003-08-30 17:04:48.000000000 +0200
@@ -794,5 +794,7 @@
 MODULE_DESCRIPTION("PCI driver module for CMD64x IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, cmd64x_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
 
--- kernel-source-2.4.21/drivers/ide/pci/cs5530.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/cs5530.c	2003-08-30 17:28:21.000000000 +0200
@@ -460,4 +460,6 @@
 MODULE_DESCRIPTION("PCI driver module for Cyrix/NS 5530 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, cs5530_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/cy82c693.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/cy82c693.c	2003-08-30 17:29:13.000000000 +0200
@@ -465,4 +465,6 @@
 MODULE_DESCRIPTION("PCI driver module for the Cypress CY82C693 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, cy82c693_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/generic.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/generic.c	2003-08-30 17:29:34.000000000 +0200
@@ -166,4 +166,6 @@
 MODULE_DESCRIPTION("PCI driver module for generic PCI IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/hpt34x.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/hpt34x.c	2003-08-30 17:34:26.000000000 +0200
@@ -367,4 +367,6 @@
 MODULE_DESCRIPTION("PCI driver module for Highpoint 34x IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, hpt34x_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/hpt366.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/hpt366.c	2003-08-30 17:30:34.000000000 +0200
@@ -1435,4 +1435,6 @@
 MODULE_DESCRIPTION("PCI driver module for Highpoint HPT366 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, hpt366_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/it8172.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/it8172.c	2003-08-30 17:31:03.000000000 +0200
@@ -331,4 +331,6 @@
 MODULE_DESCRIPTION("PCI driver module for ITE 8172 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, it8172_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/ns87415.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/ns87415.c	2003-08-30 17:31:17.000000000 +0200
@@ -264,4 +264,6 @@
 MODULE_DESCRIPTION("PCI driver module for NS87415 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, ns87415_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/opti621.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/opti621.c	2003-08-30 17:31:30.000000000 +0200
@@ -400,4 +400,6 @@
 MODULE_DESCRIPTION("PCI driver module for Opti621 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/pdc202xx_new.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/pdc202xx_new.c	2003-08-30 17:31:49.000000000 +0200
@@ -677,4 +677,6 @@
 MODULE_DESCRIPTION("PCI driver module for Promise PDC20268 and higher");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, pdc202new_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/pdc202xx_old.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/pdc202xx_old.c	2003-08-27 15:20:51.000000000 +0200
@@ -960,4 +960,6 @@
 MODULE_DESCRIPTION("PCI driver module for older Promise IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, pdc202xx_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/piix.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/piix.c	2003-08-30 17:31:57.000000000 +0200
@@ -839,4 +839,6 @@
 MODULE_DESCRIPTION("PCI driver module for Intel PIIX IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/rz1000.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/rz1000.c	2003-08-30 17:32:08.000000000 +0200
@@ -95,5 +95,7 @@
 MODULE_DESCRIPTION("PCI driver module for RZ1000 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
 
--- kernel-source-2.4.21/drivers/ide/pci/sc1200.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/sc1200.c	2003-08-30 17:32:17.000000000 +0200
@@ -595,4 +595,6 @@
 MODULE_DESCRIPTION("PCI driver module for NS SC1200 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/serverworks.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/serverworks.c	2003-08-30 17:32:35.000000000 +0200
@@ -834,4 +834,6 @@
 MODULE_DESCRIPTION("PCI driver module for Serverworks OSB4/CSB5/CSB6 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/siimage.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/siimage.c	2003-08-30 17:32:46.000000000 +0200
@@ -913,4 +913,6 @@
 MODULE_DESCRIPTION("PCI driver module for SiI IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, siimage_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/sis5513.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/sis5513.c	2003-08-30 17:33:04.000000000 +0200
@@ -1091,6 +1091,8 @@
 MODULE_DESCRIPTION("PCI driver module for SIS IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
 
 /*
--- kernel-source-2.4.21/drivers/ide/pci/sl82c105.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/sl82c105.c	2003-08-30 17:33:13.000000000 +0200
@@ -536,4 +536,6 @@
 MODULE_DESCRIPTION("PCI driver module for W82C105 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, sl82c105_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/slc90e66.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/slc90e66.c	2003-08-30 17:33:23.000000000 +0200
@@ -409,4 +409,6 @@
 MODULE_DESCRIPTION("PCI driver module for SLC90E66 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/triflex.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/triflex.c	2003-08-30 19:11:33.000000000 +0200
@@ -253,4 +253,6 @@
 MODULE_DESCRIPTION("PCI driver module for Compaq Triflex IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
 
+EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/trm290.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/trm290.c	2003-08-30 17:34:18.000000000 +0200
@@ -449,4 +449,6 @@
 MODULE_DESCRIPTION("PCI driver module for Tekram TRM290 IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, trm290_pci_tbl);
+
 EXPORT_NO_SYMBOLS;
--- kernel-source-2.4.21/drivers/ide/pci/via82cxxx.c	2003-06-01 05:06:25.000000000 +0200
+++ kernel-source-2.4.21-pcimap/drivers/ide/pci/via82cxxx.c	2003-08-27 15:21:17.000000000 +0200
@@ -667,4 +667,6 @@
 MODULE_DESCRIPTION("PCI driver module for VIA IDE");
 MODULE_LICENSE("GPL");
 
+MODULE_DEVICE_TABLE(pci, via_pci_tbl);
+
 EXPORT_NO_SYMBOLS;

--------------070108010508040601000508--

