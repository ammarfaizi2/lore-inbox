Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTJCXpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbTJCXos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:44:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40148 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261470AbTJCXlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:41:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:45:09 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040145.09820.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] slc90e66: kill dummy init_dma_slc90e66()

 drivers/ide/pci/slc90e66.c |    5 -----
 drivers/ide/pci/slc90e66.h |    2 --
 2 files changed, 7 deletions(-)

diff -puN drivers/ide/pci/slc90e66.c~ide-slc90e66-init_dma drivers/ide/pci/slc90e66.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/slc90e66.c~ide-slc90e66-init_dma	2003-10-04 01:14:42.877180080 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/slc90e66.c	2003-10-04 01:14:42.883179168 +0200
@@ -362,11 +362,6 @@ static void __init init_hwif_slc90e66 (i
 #endif /* !CONFIG_BLK_DEV_IDEDMA */
 }
 
-static void __init init_dma_slc90e66 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 
diff -puN drivers/ide/pci/slc90e66.h~ide-slc90e66-init_dma drivers/ide/pci/slc90e66.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/slc90e66.h~ide-slc90e66-init_dma	2003-10-04 01:14:42.879179776 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/slc90e66.h	2003-10-04 01:15:27.292427936 +0200
@@ -29,7 +29,6 @@ static ide_pci_host_proc_t slc90e66_proc
 
 static unsigned int init_chipset_slc90e66(struct pci_dev *, const char *);
 static void init_hwif_slc90e66(ide_hwif_t *);
-static void init_dma_slc90e66(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t slc90e66_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -39,7 +38,6 @@ static ide_pci_device_t slc90e66_chipset
 		.init_chipset	= init_chipset_slc90e66,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_slc90e66,
-		.init_dma	= init_dma_slc90e66,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},

_

