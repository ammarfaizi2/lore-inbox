Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267687AbUIAU1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUIAU1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267670AbUIAUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:24:13 -0400
Received: from baikonur.stro.at ([213.239.196.228]:36314 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267687AbUIAUQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:16:02 -0400
Subject: [patch 11/12]  list_for_each: 	arch-sparc-kernel-pcic.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:16:01 +0200
Message-ID: <E1C2bWU-0006TK-4y@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/sparc/kernel/pcic.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN arch/sparc/kernel/pcic.c~list-for-each-arch_sparc_kernel_pcic arch/sparc/kernel/pcic.c
--- linux-2.6.9-rc1-bk7/arch/sparc/kernel/pcic.c~list-for-each-arch_sparc_kernel_pcic	2004-09-01 19:38:15.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/sparc/kernel/pcic.c	2004-09-01 19:38:15.000000000 +0200
@@ -603,7 +603,7 @@ pcic_fill_irq(struct linux_pcic *pcic, s
  */
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct list_head *walk;
+	struct pci_dev *dev;
 	int i, has_io, has_mem;
 	unsigned int cmd;
 	struct linux_pcic *pcic;
@@ -625,9 +625,7 @@ void __init pcibios_fixup_bus(struct pci
 		return;
 	}
 
-	walk = &bus->devices;
-	for (walk = walk->next; walk != &bus->devices; walk = walk->next) {
-		struct pci_dev *dev = pci_dev_b(walk);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 
 		/*
 		 * Comment from i386 branch:

_
