Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWHJUEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWHJUEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWHJUEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:55787 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932321AbWHJTgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:37 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [79/145] x86_64: Calgary IOMMU: calgary_init_one_nontraslated() can return void
Message-Id: <20060810193635.D14D913C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:35 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -784,13 +784,11 @@ static inline unsigned int __init locate
 	return address;
 }
 
-static int __init calgary_init_one_nontraslated(struct pci_dev *dev)
+static void __init calgary_init_one_nontraslated(struct pci_dev *dev)
 {
 	pci_dev_get(dev);
 	dev->sysdata = NULL;
 	dev->bus->self = dev;
-
-	return 0;
 }
 
 static int __init calgary_init_one(struct pci_dev *dev)
