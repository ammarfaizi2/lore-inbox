Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUIAU1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUIAU1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUIAUUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:20:50 -0400
Received: from baikonur.stro.at ([213.239.196.228]:27569 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267628AbUIAUPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:15 -0400
Subject: [patch 02/12]  list_for_each: 	arch-i386-pci-i386.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:12 +0200
Message-ID: <E1C2bVg-0006Mw-PZ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Replace for with more readable list_for_each.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/i386/pci/i386.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/i386/pci/i386.c~list-for-each-arch_i386_pci_i386 arch/i386/pci/i386.c
--- linux-2.6.9-rc1-bk7/arch/i386/pci/i386.c~list-for-each-arch_i386_pci_i386	2004-09-01 19:38:06.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/i386/pci/i386.c	2004-09-01 19:38:06.000000000 +0200
@@ -96,15 +96,13 @@ pcibios_align_resource(void *data, struc
 
 static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
 {
-	struct list_head *ln;
 	struct pci_bus *bus;
 	struct pci_dev *dev;
 	int idx;
 	struct resource *r, *pr;
 
 	/* Depth-First Search on bus tree */
-	for (ln=bus_list->next; ln != bus_list; ln=ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, bus_list, node) {
 		if ((dev = bus->self)) {
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];

_
