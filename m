Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTJCXlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbTJCXlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:41:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261601AbTJCXkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:40:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:44:27 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040144.27159.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] sc1200: kill dummy init_dma_sc1200()

 drivers/ide/pci/sc1200.c |    5 -----
 drivers/ide/pci/sc1200.h |    2 --
 2 files changed, 7 deletions(-)

diff -puN drivers/ide/pci/sc1200.c~ide-sc1200-init_dma drivers/ide/pci/sc1200.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sc1200.c~ide-sc1200-init_dma	2003-10-04 01:10:32.528238904 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sc1200.c	2003-10-04 01:10:32.534237992 +0200
@@ -545,11 +545,6 @@ static void __init init_hwif_sc1200 (ide
         hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_sc1200 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 
diff -puN drivers/ide/pci/sc1200.h~ide-sc1200-init_dma drivers/ide/pci/sc1200.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sc1200.h~ide-sc1200-init_dma	2003-10-04 01:10:32.531238448 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sc1200.h	2003-10-04 01:11:10.489467920 +0200
@@ -27,7 +27,6 @@ static ide_pci_host_proc_t sc1200_procs[
 
 static unsigned int init_chipset_sc1200(struct pci_dev *, const char *);
 static void init_hwif_sc1200(ide_hwif_t *);
-static void init_dma_sc1200(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t sc1200_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -37,7 +36,6 @@ static ide_pci_device_t sc1200_chipsets[
 		.init_chipset	= init_chipset_sc1200,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_sc1200,
-		.init_dma	= init_dma_sc1200,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

