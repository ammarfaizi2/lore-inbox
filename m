Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271753AbTGRN6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271723AbTGRN6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:58:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16261
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271469AbTGRN5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:57:05 -0400
Date: Fri, 18 Jul 2003 15:11:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181411.h6IEBQwU017702@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix all the paths in ide Kconfig docs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Helge Hafting)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/ide/Kconfig linux-2.6.0-test1-ac2/drivers/ide/Kconfig
--- linux-2.6.0-test1/drivers/ide/Kconfig	2003-07-10 21:08:56.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/ide/Kconfig	2003-07-15 18:14:39.000000000 +0100
@@ -521,7 +521,7 @@
 
 	  If you say Y here, you also need to say Y to "Use DMA by default
 	  when available", above.  Please read the comments at the top of
-	  <file:drivers/ide/alim15x3.c>.
+	  <file:drivers/ide/pci/alim15x3.c>.
 
 	  If unsure, say N.
 
@@ -608,7 +608,7 @@
 	depends on BLK_DEV_HPT34X && IDEDMA_PCI_WIP
 	help
 	  This is a dangerous thing to attempt currently! Please read the
-	  comments at the top of <file:drivers/ide/hpt34x.c>.  If you say Y
+	  comments at the top of <file:drivers/ide/pci/hpt34x.c>.  If you say Y
 	  here, then say Y to "Use DMA by default when available" as well.
 
 	  If unsure, say N.
@@ -670,14 +670,14 @@
 	  This driver adds detection and support for the NS87415 chip
 	  (used in SPARC64, among others).
 
-	  Please read the comments at the top of <file:drivers/ide/ns87415.c>.
+	  Please read the comments at the top of <file:drivers/ide/pci/ns87415.c>.
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"
 	depends on PCI && BLK_DEV_IDEPCI && EXPERIMENTAL
 	help
 	  This is a driver for the OPTi 82C621 EIDE controller.
-	  Please read the comments at the top of <file:drivers/ide/opti621.c>.
+	  Please read the comments at the top of <file:drivers/ide/pci/opti621.c>.
 
 config BLK_DEV_PDC202XX_OLD
 	tristate "PROMISE PDC202{46|62|65|67} support"
@@ -696,7 +696,7 @@
 	  when the PDC20265 BIOS has been disabled (for faster boot up).
 
 	  Please read the comments at the top of
-	  <file:drivers/ide/pdc202xx.c>.
+	  <file:drivers/ide/pci/pdc202xx_old.c>.
 
 	  If unsure, say N.
 
@@ -754,7 +754,7 @@
 	  If you say Y here, you need to say Y to "Use DMA by default when
 	  available" as well.
 
-	  Please read the comments at the top of <file:drivers/ide/sis5513.c>.
+	  Please read the comments at the top of <file:drivers/ide/pci/sis5513.c>.
 
 config BLK_DEV_SLC90E66
 	tristate "SLC90E66 chipset support"
@@ -770,7 +770,7 @@
 	  available" as well.
 
 	  Please read the comments at the top of
-	  drivers/ide/slc90e66.c.
+	  drivers/ide/pci/slc90e66.c.
 
 config BLK_DEV_TRM290
 	tristate "Tekram TRM290 chipset support"
@@ -779,7 +779,7 @@
 	  This driver adds support for bus master DMA transfers
 	  using the Tekram TRM290 PCI IDE chip. Volunteers are
 	  needed for further tweaking and development.
-	  Please read the comments at the top of <file:drivers/ide/trm290.c>.
+	  Please read the comments at the top of <file:drivers/ide/pci/trm290.c>.
 
 config BLK_DEV_VIA82CXXX
 	tristate "VIA82CXXX chipset support"
@@ -1010,7 +1010,7 @@
 	  boot parameter.  It enables support for the secondary IDE interface
 	  of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
 	  I/O speeds to be set as well.  See the files
-	  <file:Documentation/ide.txt> and <file:drivers/ide/ali14xx.c> for
+	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/ali14xx.c> for
 	  more info.
 
 config BLK_DEV_DTC2278
@@ -1021,7 +1021,7 @@
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the DTC-2278 card, and permits faster I/O speeds to be set as
 	  well. See the <file:Documentation/ide.txt> and
-	  <file:drivers/ide/dtc2278.c> files for more info.
+	  <file:drivers/ide/legacy/dtc2278.c> files for more info.
 
 config BLK_DEV_HT6560B
 	tristate "Holtek HT6560B support"
@@ -1031,7 +1031,7 @@
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the Holtek card, and permits faster I/O speeds to be set as well.
 	  See the <file:Documentation/ide.txt> and
-	  <file:drivers/ide/ht6560b.c> files for more info.
+	  <file:drivers/ide/legacy/ht6560b.c> files for more info.
 
 config BLK_DEV_PDC4030
 	tristate "PROMISE DC4030 support (EXPERIMENTAL)"
@@ -1044,7 +1044,7 @@
 	  supported (and probably never will be since I don't think the cards
 	  support them). This driver is enabled at runtime using the "ide0=dc4030"
 	  or "ide1=dc4030" kernel boot parameter. See the
-	  <file:drivers/ide/pdc4030.c> file for more info.
+	  <file:drivers/ide/legacy/pdc4030.c> file for more info.
 
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
@@ -1052,7 +1052,7 @@
 	help
 	  This driver is enabled at runtime using the "ide0=qd65xx" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
-	  <file:Documentation/ide.txt> and <file:drivers/ide/qd65xx.c> for
+	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/qd65xx.c> for
 	  more info.
 
 config BLK_DEV_UMC8672
@@ -1063,7 +1063,7 @@
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the UMC-8672, and permits faster I/O speeds to be set as well.
 	  See the files <file:Documentation/ide.txt> and
-	  <file:drivers/ide/umc8672.c> for more info.
+	  <file:drivers/ide/legacy/umc8672.c> for more info.
 
 config BLK_DEV_HD_ONLY
 	bool "Old hard disk (MFM/RLL/IDE) driver"
@@ -1132,7 +1132,7 @@
 	  available" as well.
 
 	  Please read the comments at the top of
-	  <file:drivers/ide/pdc202xx.c>.
+	  <file:drivers/ide/pdc202xx_old.c>.
 
 	  If unsure, say N.
 
