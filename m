Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUIAU1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUIAU1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUIAUU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:20:58 -0400
Received: from baikonur.stro.at ([213.239.196.228]:39848 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267542AbUIAUPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:20 -0400
Subject: [patch 03/12]  list_for_each: arch-ia64-pci-pci.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:17 +0200
Message-ID: <E1C2bVm-0006Ne-9L@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Change for loops with list_for_each_entry().

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>




---

 linux-2.6.9-rc1-bk7-max/arch/ia64/pci/pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/ia64/pci/pci.c~list-for-each-arch_ia64_pci_pci arch/ia64/pci/pci.c
--- linux-2.6.9-rc1-bk7/arch/ia64/pci/pci.c~list-for-each-arch_ia64_pci_pci	2004-09-01 19:38:06.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/ia64/pci/pci.c	2004-09-01 19:38:06.000000000 +0200
@@ -360,10 +360,10 @@ pcibios_fixup_device_resources (struct p
 void __devinit
 pcibios_fixup_bus (struct pci_bus *b)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 
-	for (ln = b->devices.next; ln != &b->devices; ln = ln->next)
-		pcibios_fixup_device_resources(pci_dev_b(ln), b);
+	list_for_each_entry(dev, &b->devices, bus_list)
+		pcibios_fixup_device_resources(dev, b);
 
 	return;
 }

_
