Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270423AbTGNMHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270571AbTGNMHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:07:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37508
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270423AbTGNMFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:05:43 -0400
Date: Mon, 14 Jul 2003 13:19:31 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141219.h6ECJVRC030854@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix hpt ide crash, floppy noise
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/ide/ide-floppy.c linux.22-pre5-ac1/drivers/ide/ide-floppy.c
--- linux.22-pre5/drivers/ide/ide-floppy.c	2003-07-14 12:26:52.000000000 +0100
+++ linux.22-pre5-ac1/drivers/ide/ide-floppy.c	2003-07-09 13:24:26.000000000 +0100
@@ -2195,7 +2195,6 @@
 	idefloppy_floppy_t *floppy;
 	int failed = 0;
 
-	printk(KERN_INFO "ide-floppy driver " IDEFLOPPY_VERSION "\n");
 #endif /* CLASSIC_BUILTINS_METHOD */
 	MOD_INC_USE_COUNT;
 #ifdef CLASSIC_BUILTINS_METHOD
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/ide/setup-pci.c linux.22-pre5-ac1/drivers/ide/setup-pci.c
--- linux.22-pre5/drivers/ide/setup-pci.c	2003-07-14 12:27:36.000000000 +0100
+++ linux.22-pre5-ac1/drivers/ide/setup-pci.c	2003-07-09 13:02:14.000000000 +0100
@@ -172,7 +172,7 @@
  *	is already in DMA mode we check and enforce IDE simplex rules.
  */
 
-static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
