Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUIAU1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUIAU1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUIAUVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:21:07 -0400
Received: from baikonur.stro.at ([213.239.196.228]:11669 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267635AbUIAUPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:15:25 -0400
Subject: [patch 04/12]  list_for_each: 	arch-ia64-sn-io-machvec-pci_bus_cvlink.c
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:15:23 +0200
Message-ID: <E1C2bVr-0006OM-PA@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/arch/ia64/sn/io/machvec/pci_bus_cvlink.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/ia64/sn/io/machvec/pci_bus_cvlink.c~list-for-each-arch_ia64_sn_io_machvec_pci_bus_cvlink arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- linux-2.6.9-rc1-bk7/arch/ia64/sn/io/machvec/pci_bus_cvlink.c~list-for-each-arch_ia64_sn_io_machvec_pci_bus_cvlink	2004-09-01 19:38:06.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-09-01 19:38:06.000000000 +0200
@@ -819,7 +819,6 @@ sn_pci_init (void)
 {
 	int i = 0;
 	struct pci_controller *controller;
-	struct list_head *ln;
 	struct pci_bus *pci_bus = NULL;
 	struct pci_dev *pci_dev = NULL;
 	int ret;
@@ -866,8 +865,7 @@ sn_pci_init (void)
 	/*
 	 * Initialize the pci bus vertex in the pci_bus struct.
 	 */
-	for( ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		pci_bus = pci_bus_b(ln);
+	list_for_each_entry(pci_bus, &pci_root_buses, node) {
 		ret = sn_pci_fixup_bus(pci_bus);
 		if ( ret ) {
 			printk(KERN_WARNING

_
