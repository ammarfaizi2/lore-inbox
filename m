Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbVBDHRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVBDHRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVBDHRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:17:07 -0500
Received: from [211.58.254.17] ([211.58.254.17]:39081 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263270AbVBDHNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:13:21 -0500
To: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 05/14] ide_pci: Merges generic.h into generic.c
From: Tejun Heo <tj@home-tj.org>
In-Reply-To: <42032014.1020606@home-tj.org>
References: <42032014.1020606@home-tj.org>
Message-Id: <20050204071318.2F0EB132650@htj.dyndns.org>
Date: Fri,  4 Feb 2005 16:13:18 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


05_ide_pci_generic_merge.patch

	Merges ide/pci/generic.h into generic.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/generic.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/generic.c	2005-02-04 16:07:36.891360866 +0900
+++ linux-idepci-export/drivers/ide/pci/generic.c	2005-02-04 16:08:25.160499511 +0900
@@ -39,8 +39,6 @@
 
 #include <asm/io.h>
 
-#include "generic.h"
-
 static unsigned int __devinit init_chipset_generic (struct pci_dev *dev, const char *name)
 {
 	return 0;
@@ -83,6 +81,115 @@ static void __devinit init_hwif_generic 
 	return 0;
 #endif	
 
+static ide_pci_device_t generic_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "NS87410",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
+		.bootable	= ON_BOARD,
+        },{	/* 1 */
+		.name		= "SAMURAI",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 2 */
+		.name		= "HT6565",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 3 */
+		.name		= "UM8673F",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 4 */
+		.name		= "UM8886A",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 5 */
+		.name		= "UM8886BF",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 6 */
+		.name		= "HINT_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 7 */
+		.name		= "VIA_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 8 */
+		.name		= "OPTI621V",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{	/* 9 */
+		.name		= "VIA8237SATA",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
+	},{ /* 10 */
+		.name 		= "Piccolo0102",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{ /* 11 */
+		.name 		= "Piccolo0103",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	},{ /* 12 */
+		.name 		= "Piccolo0105",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= NOAUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+
+#if 0
+static ide_pci_device_t unknown_chipset[] __devinitdata = {
+	{	/* 0 */
+		.name		= "PCI_IDE",
+		.init_chipset	= init_chipset_generic,
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+	}
+};
+#endif
+
 /**
  *	generic_init_one	-	called when a PIIX is found
  *	@dev: the generic device
Index: linux-idepci-export/drivers/ide/pci/generic.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/generic.h	2005-02-04 16:07:36.891360866 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,120 +0,0 @@
-#ifndef IDE_GENERIC_H
-#define IDE_GENERIC_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static unsigned int init_chipset_generic(struct pci_dev *, const char *);
-static void init_hwif_generic(ide_hwif_t *);
-
-static ide_pci_device_t generic_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "NS87410",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
-		.bootable	= ON_BOARD,
-        },{	/* 1 */
-		.name		= "SAMURAI",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 2 */
-		.name		= "HT6565",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 3 */
-		.name		= "UM8673F",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 4 */
-		.name		= "UM8886A",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 5 */
-		.name		= "UM8886BF",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 6 */
-		.name		= "HINT_IDE",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 7 */
-		.name		= "VIA_IDE",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 8 */
-		.name		= "OPTI621V",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{	/* 9 */
-		.name		= "VIA8237SATA",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= OFF_BOARD,
-	},{ /* 10 */
-		.name 		= "Piccolo0102",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{ /* 11 */
-		.name 		= "Piccolo0103",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	},{ /* 12 */
-		.name 		= "Piccolo0105",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-
-#if 0
-static ide_pci_device_t unknown_chipset[] __devinitdata = {
-	{	/* 0 */
-		.name		= "PCI_IDE",
-		.init_chipset	= init_chipset_generic,
-		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.bootable	= ON_BOARD,
-	}
-};
-#endif
-
-#endif /* IDE_GENERIC_H */
