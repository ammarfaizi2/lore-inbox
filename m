Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTJCXix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbTJCXix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:38:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14036 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261552AbTJCXip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:38:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:42:14 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040142.14911.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] cmd64x: kill dummy init_dma_cmd64x()

 drivers/ide/pci/cmd64x.c |    5 -----
 drivers/ide/pci/cmd64x.h |    5 -----
 2 files changed, 10 deletions(-)

diff -puN drivers/ide/pci/cmd64x.c~ide-cmd64x-init_dma drivers/ide/pci/cmd64x.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd64x.c~ide-cmd64x-init_dma	2003-10-04 00:59:18.224748616 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd64x.c	2003-10-04 00:59:18.231747552 +0200
@@ -742,11 +742,6 @@ static void __init init_hwif_cmd64x (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_cmd64x (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -puN drivers/ide/pci/cmd64x.h~ide-cmd64x-init_dma drivers/ide/pci/cmd64x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd64x.h~ide-cmd64x-init_dma	2003-10-04 00:59:18.227748160 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd64x.h	2003-10-04 00:59:18.232747400 +0200
@@ -81,7 +81,6 @@ static ide_pci_host_proc_t cmd64x_procs[
 
 static unsigned int init_chipset_cmd64x(struct pci_dev *, const char *);
 static void init_hwif_cmd64x(ide_hwif_t *);
-static void init_dma_cmd64x(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -91,7 +90,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_chipset	= init_chipset_cmd64x,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
-		.init_dma	= init_dma_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -104,7 +102,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_chipset	= init_chipset_cmd64x,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
-		.init_dma	= init_dma_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
@@ -117,7 +114,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_chipset	= init_chipset_cmd64x,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
-		.init_dma	= init_dma_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -130,7 +126,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_chipset	= init_chipset_cmd64x,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cmd64x,
-		.init_dma	= init_dma_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

