Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJCXxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTJCXm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:42:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261580AbTJCXk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:40:26 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:43:53 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040143.53218.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] pdc202xx_new: kill dummy init_dma_pdc202new()

 drivers/ide/pci/pdc202xx_new.c |    5 -----
 drivers/ide/pci/pdc202xx_new.h |    8 --------
 2 files changed, 13 deletions(-)

diff -puN drivers/ide/pci/pdc202xx_new.c~ide-pdcnew-init_dma drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_new.c~ide-pdcnew-init_dma	2003-10-04 01:04:55.593460776 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_new.c	2003-10-04 01:04:55.599459864 +0200
@@ -563,11 +563,6 @@ static void __init init_hwif_pdc202new (
 #endif /* PDC202_DEBUG_CABLE */
 }
 
-static void __init init_dma_pdc202new (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 extern void ide_setup_pci_devices(struct pci_dev *, struct pci_dev *, ide_pci_device_t *);
 
diff -puN drivers/ide/pci/pdc202xx_new.h~ide-pdcnew-init_dma drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_new.h~ide-pdcnew-init_dma	2003-10-04 01:04:55.596460320 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_new.h	2003-10-04 01:05:43.315205968 +0200
@@ -188,7 +188,6 @@ static void init_setup_pdc20270(struct p
 static void init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
 static unsigned int init_chipset_pdcnew(struct pci_dev *, const char *);
 static void init_hwif_pdc202new(ide_hwif_t *);
-static void init_dma_pdc202new(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t pdcnew_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -199,7 +198,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -213,7 +211,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -227,7 +224,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 #ifdef CONFIG_PDC202XX_FORCE
@@ -245,7 +241,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -259,7 +254,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -273,7 +267,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 #ifdef CONFIG_PDC202XX_FORCE
@@ -291,7 +284,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_chipset	= init_chipset_pdcnew,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_pdc202new,
-		.init_dma	= init_dma_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

