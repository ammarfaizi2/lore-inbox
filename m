Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269508AbUIZMSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269508AbUIZMSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 08:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUIZMSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 08:18:12 -0400
Received: from verein.lst.de ([213.95.11.210]:34700 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269508AbUIZMSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 08:18:09 -0400
Date: Sun, 26 Sep 2004 14:18:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't build vio.o for pmac-only configs
Message-ID: <20040926121803.GA2179@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 1.48/arch/ppc64/kernel/Makefile	2004-09-21 03:17:40 +02:00
+++ edited/arch/ppc64/kernel/Makefile	2004-09-25 12:35:26 +02:00
@@ -21,7 +21,7 @@
 
 obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o $(pci-obj-y)
 
-obj-$(CONFIG_PPC_ISERIES) += iSeries_irq.o \
+obj-$(CONFIG_PPC_ISERIES) += vio.o iSeries_irq.o \
 			     iSeries_VpdInfo.o XmPciLpEvent.o \
 			     HvCall.o HvLpConfig.o LparData.o mf_proc.o \
 			     iSeries_setup.o ItLpQueue.o hvCall.o \
@@ -30,7 +30,7 @@
 
 obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o open_pic.o i8259.o prom_init.o prom.o
 
-obj-$(CONFIG_PPC_PSERIES) += pSeries_pci.o pSeries_lpar.o pSeries_hvCall.o \
+obj-$(CONFIG_PPC_PSERIES) += vio.o pSeries_pci.o pSeries_lpar.o pSeries_hvCall.o \
 			     eeh.o pSeries_nvram.o rtasd.o ras.o \
 			     xics.o rtas.o pSeries_setup.o pSeries_iommu.o
 
