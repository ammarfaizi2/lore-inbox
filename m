Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVD3UOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVD3UOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVD3UO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:14:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11023 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261410AbVD3UId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:08:33 -0400
Date: Sat, 30 Apr 2005 22:08:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Lionel.Bouton@inet6.fr, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.6 patch] drivers/ide/pci/sis5513.c: section fixes
Message-ID: <20050430200831.GU3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These three functions are referenced from the __devinitdata 
sis5513_chipset.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Apr 2005

 drivers/ide/pci/sis5513.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc3/drivers/ide/pci/sis5513.c.old	2005-04-21 04:26:36.000000000 +0200
+++ linux-2.6.12-rc3/drivers/ide/pci/sis5513.c	2005-04-21 04:27:32.000000000 +0200
@@ -726,7 +726,7 @@
 */
 
 /* Chip detection and general config */
-static unsigned int __init init_chipset_sis5513 (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *host;
 	int i = 0;
@@ -879,7 +879,7 @@
 	return 0;
 }
 
-static unsigned int __init ata66_sis5513 (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_sis5513 (ide_hwif_t *hwif)
 {
 	u8 ata66 = 0;
 
@@ -897,7 +897,7 @@
         return ata66;
 }
 
-static void __init init_hwif_sis5513 (ide_hwif_t *hwif)
+static void __devinit init_hwif_sis5513 (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 

