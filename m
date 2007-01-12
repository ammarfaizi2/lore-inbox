Return-Path: <linux-kernel-owner+w=401wt.eu-S1751601AbXALEXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbXALEXX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbXALEXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:23:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbXALEXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:23:09 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=tUSvG6oOjy3UBH51YwaTDPBj5g0krNm26XkgjZhG4gkn7ZgoqrCa6Dwo+h5imukq7f4WQFNDPv9ypDqH0R/PqtfKH0XGFmTZMPepOHYSlUDDUQG/gRaPHkTSrsF4P/sCTPg5wxYlEgEgfxNUEVjRCY+LqdAv7NHn7KTOkFZNtRc=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:26:46 +0100
Message-Id: <20070112042646.28794.7500.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Subject: [PATCH 6/19] pdc202xx_old: remove dead code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pdc202xx_old: remove dead code

CONFIG_PDC202XX_MASTER config option doesn't exist

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/pdc202xx_old.c |   19 -------------------
 1 file changed, 19 deletions(-)

Index: a/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a.orig/drivers/ide/pci/pdc202xx_old.c
+++ a/drivers/ide/pci/pdc202xx_old.c
@@ -557,25 +557,6 @@ static void __devinit init_dma_pdc202xx(
 			(hwif->INB(dmabase|0x1f)&1) ? "":"IN");
 	}
 #endif /* CONFIG_PDC202XX_BURST */
-#ifdef CONFIG_PDC202XX_MASTER
-	if (!(primary_mode & 1)) {
-		printk(KERN_INFO "%s: FORCING PRIMARY MODE BIT "
-			"0x%02x -> 0x%02x ", hwif->cds->name,
-			primary_mode, (primary_mode|1));
-		hwif->OUTB(primary_mode|1, (dmabase|0x1a));
-		printk("%s\n",
-			(hwif->INB((dmabase|0x1a)) & 1) ? "MASTER" : "PCI");
-	}
-
-	if (!(secondary_mode & 1)) {
-		printk(KERN_INFO "%s: FORCING SECONDARY MODE BIT "
-			"0x%02x -> 0x%02x ", hwif->cds->name,
-			secondary_mode, (secondary_mode|1));
-		hwif->OUTB(secondary_mode|1, (dmabase|0x1b));
-		printk("%s\n",
-			(hwif->INB((dmabase|0x1b)) & 1) ? "MASTER" : "PCI");
-	}
-#endif /* CONFIG_PDC202XX_MASTER */
 
 	ide_setup_dma(hwif, dmabase, 8);
 }
