Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUIAUXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUIAUXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIAUVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:21:36 -0400
Received: from baikonur.stro.at ([213.239.196.228]:17797 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267617AbUIAUPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:40 -0400
Subject: [patch 07/12]  list_for_each: 	arch-ppc64-kernel-pci_dn.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:39 +0200
Message-ID: <E1C2bW8-0006QU-6o@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/ppc64/kernel/pci_dn.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/ppc64/kernel/pci_dn.c~list-for-each-arch_ppc64_kernel_pci_dn arch/ppc64/kernel/pci_dn.c
--- linux-2.6.9-rc1-bk7/arch/ppc64/kernel/pci_dn.c~list-for-each-arch_ppc64_kernel_pci_dn	2004-09-01 19:38:14.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/ppc64/kernel/pci_dn.c	2004-09-01 19:38:14.000000000 +0200
@@ -196,11 +196,9 @@ void __init pci_devs_phb_init(void)
 
 static void __init pci_fixup_bus_sysdata_list(struct list_head *bus_list)
 {
-	struct list_head *ln;
 	struct pci_bus *bus;
 
-	for (ln = bus_list->next; ln != bus_list; ln = ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, bus_list, node) {
 		if (bus->self)
 			bus->sysdata = bus->self->sysdata;
 		pci_fixup_bus_sysdata_list(&bus->children);

_
