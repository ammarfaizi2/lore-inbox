Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTDTSLS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTDTSLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:11:18 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7864 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263648AbTDTSLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:11:17 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:23:15 +0200 (MEST)
Message-Id: <UTC200304201823.h3KINFi18073.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] hpt366.c compilation fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove declaration of unused variables.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	Sun Apr 20 12:59:31 2003
+++ b/drivers/ide/pci/hpt366.c	Sun Apr 20 20:11:59 2003
@@ -1105,7 +1105,6 @@
 		    (findev->device == dev->device) &&
 		    ((findev->devfn - dev->devfn) == 1) &&
 		    (PCI_FUNC(findev->devfn) & 1)) {
-			u8 irq = 0, irq2 = 0;
 			if (findev->irq != dev->irq) {
 				/* FIXME: we need a core pci_set_interrupt() */
 				findev->irq = dev->irq;
