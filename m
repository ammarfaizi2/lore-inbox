Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbTEMJWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 05:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTEMJWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 05:22:34 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:9222 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263393AbTEMJW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 05:22:26 -0400
Message-ID: <3EC0BBEC.7030701@aitel.hist.no>
Date: Tue, 13 May 2003 11:33:32 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Some Kconfig corrections for ide drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ide hardware seems to have moved from drivers/ide
to drivers/ide/pci or drivers/ide/legacy.

This patch updates Kconfig accordingly, so people
reading the help texts are told to look at
<file:drivers/ide/pci/sis5513.c>
instead of the nonexistant
<file:drivers/ide/sis5513.c>
There are similiar updated for the other ide drivers.

Helge Hafting

--- Kconfig.orig        2003-05-05 01:53:14.000000000 +0200
+++ Kconfig     2003-05-13 11:18:19.000000000 +0200
@@ -456,7 +456,7 @@

           If you say Y here, you also need to say Y to "Use DMA by default
           when available", above.  Please read the comments at the top of
-         <file:drivers/ide/alim15x3.c>.
+         <file:drivers/ide/pci/alim15x3.c>.

           If unsure, say N.

@@ -543,7 +543,7 @@
         depends on BLK_DEV_HPT34X && IDEDMA_PCI_WIP
         help
           This is a dangerous thing to attempt currently! Please read the
-         comments at the top of <file:drivers/ide/hpt34x.c>.  If you say Y
+         comments at the top of <file:drivers/ide/pci/hpt34x.c>.  If 
you say Y
           here, then say Y to "Use DMA by default when available" as well.

           If unsure, say N.
@@ -605,14 +605,14 @@
           This driver adds detection and support for the NS87415 chip
           (used in SPARC64, among others).

-         Please read the comments at the top of 
<file:drivers/ide/ns87415.c>.
+         Please read the comments at the top of 
<file:drivers/ide/pci/ns87415.c>.

  config BLK_DEV_OPTI621
         tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"
         depends on PCI && BLK_DEV_IDEPCI && EXPERIMENTAL
         help
           This is a driver for the OPTi 82C621 EIDE controller.
-         Please read the comments at the top of 
<file:drivers/ide/opti621.c>.
+         Please read the comments at the top of 
<file:drivers/ide/pci/opti621.c>.

  config BLK_DEV_PDC202XX_OLD
         tristate "PROMISE PDC202{46|62|65|67} support"
@@ -631,7 +631,8 @@
           when the PDC20265 BIOS has been disabled (for faster boot up).

           Please read the comments at the top of
-         <file:drivers/ide/pdc202xx.c>.
+         <file:drivers/ide/pci/pdc202xx_old.c>, and
+         <file:drivers/ide/pci/pdc202xx_new.c>.

           If unsure, say N.

@@ -689,7 +690,7 @@
           If you say Y here, you need to say Y to "Use DMA by default when
           available" as well.

-         Please read the comments at the top of 
<file:drivers/ide/sis5513.c>.
+         Please read the comments at the top of 
<file:drivers/ide/pci/sis5513.c>.

  config BLK_DEV_SLC90E66
         tristate "SLC90E66 chipset support"
@@ -705,7 +706,7 @@
           available" as well.

           Please read the comments at the top of
-         drivers/ide/slc90e66.c.
+         <file:drivers/ide/pci/slc90e66.c>.

  config BLK_DEV_TRM290
         tristate "Tekram TRM290 chipset support"
@@ -714,7 +715,7 @@
           This driver adds support for bus master DMA transfers
           using the Tekram TRM290 PCI IDE chip. Volunteers are
           needed for further tweaking and development.
-         Please read the comments at the top of 
<file:drivers/ide/trm290.c>.
+         Please read the comments at the top of 
<file:drivers/ide/pci/trm290.c>.

  config BLK_DEV_VIA82CXXX
         tristate "VIA82CXXX chipset support"
@@ -945,7 +946,7 @@
           boot parameter.  It enables support for the secondary IDE 
interface
           of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
           I/O speeds to be set as well.  See the files
-         <file:Documentation/ide.txt> and <file:drivers/ide/ali14xx.c> for
+         <file:Documentation/ide.txt> and 
<file:drivers/ide/legacy/ali14xx.c> for
           more info.

  config BLK_DEV_DTC2278
@@ -956,7 +957,7 @@
           boot parameter. It enables support for the secondary IDE 
interface
           of the DTC-2278 card, and permits faster I/O speeds to be set as
           well. See the <file:Documentation/ide.txt> and
-         <file:drivers/ide/dtc2278.c> files for more info.
+         <file:drivers/ide/legacy/dtc2278.c> files for more info.

  config BLK_DEV_HT6560B
         tristate "Holtek HT6560B support"
@@ -966,7 +967,7 @@
           boot parameter. It enables support for the secondary IDE 
interface
           of the Holtek card, and permits faster I/O speeds to be set 
as well.
           See the <file:Documentation/ide.txt> and
-         <file:drivers/ide/ht6560b.c> files for more info.
+         <file:drivers/ide/legacy/ht6560b.c> files for more info.

  config BLK_DEV_PDC4030
         tristate "PROMISE DC4030 support (EXPERIMENTAL)"
@@ -979,7 +980,7 @@
           supported (and probably never will be since I don't think the 
cards
           support them). This driver is enabled at runtime using the 
"ide0=dc4030"
           or "ide1=dc4030" kernel boot parameter. See the
-         <file:drivers/ide/pdc4030.c> file for more info.
+         <file:drivers/ide/legacy/pdc4030.c> file for more info.

  config BLK_DEV_QD65XX
         tristate "QDI QD65xx support"
@@ -987,7 +988,7 @@
         help
           This driver is enabled at runtime using the "ide0=qd65xx" kernel
           boot parameter.  It permits faster I/O speeds to be set.  See the
-         <file:Documentation/ide.txt> and <file:drivers/ide/qd65xx.c> for
+         <file:Documentation/ide.txt> and 
<file:drivers/ide/legacy/qd65xx.c> for
           more info.

  config BLK_DEV_UMC8672
@@ -998,7 +999,7 @@
           boot parameter. It enables support for the secondary IDE 
interface
           of the UMC-8672, and permits faster I/O speeds to be set as well.
           See the files <file:Documentation/ide.txt> and
-         <file:drivers/ide/umc8672.c> for more info.
+         <file:drivers/ide/legacy/umc8672.c> for more info.

  config BLK_DEV_HD_ONLY
         bool "Old hard disk (MFM/RLL/IDE) driver"
@@ -1067,7 +1068,8 @@
           available" as well.

           Please read the comments at the top of
-         <file:drivers/ide/pdc202xx.c>.
+         <file:drivers/ide/pci/pdc202xx_old.c>, and
+         <file:drivers/ide/pci/pdc202xx_new.c>.

           If unsure, say N.


