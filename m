Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUKMTyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUKMTyY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 14:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKMTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 14:54:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:27264 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261159AbUKMTyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 14:54:13 -0500
Date: Sat, 13 Nov 2004 20:54:05 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __devinit in pci/generic.c
Message-ID: <20041113195404.GA2240@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines referred to from __devinitdata.

diff -uprN -X /linux/dontdiff a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
--- a/drivers/ide/pci/generic.c	2004-10-30 21:44:00.000000000 +0200
+++ b/drivers/ide/pci/generic.c	2004-11-13 20:56:09.000000000 +0100
@@ -41,12 +41,12 @@
 
 #include "generic.h"
 
-static unsigned int __init init_chipset_generic (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_generic (struct pci_dev *dev, const char *name)
 {
 	return 0;
 }
 
-static void __init init_hwif_generic (ide_hwif_t *hwif)
+static void __devinit init_hwif_generic (ide_hwif_t *hwif)
 {
 	switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_UMC_UM8673F:
