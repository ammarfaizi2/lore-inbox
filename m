Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270160AbUJSXbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270160AbUJSXbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270112AbUJSXY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:24:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:18314 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270163AbUJSWqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:40 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257342714@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <10982257344160@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.19, 2004/10/06 12:00:23-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-ia64-sn-io-machvec-pci_bus_cvlink.c

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ia64/sn/io/machvec/pci_bus_cvlink.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-10-19 15:26:04 -07:00
+++ b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-10-19 15:26:04 -07:00
@@ -832,7 +832,6 @@
 {
 	int i = 0;
 	struct pci_controller *controller;
-	struct list_head *ln;
 	struct pci_bus *pci_bus = NULL;
 	struct pci_dev *pci_dev = NULL;
 	int ret;
@@ -879,8 +878,7 @@
 	/*
 	 * Initialize the pci bus vertex in the pci_bus struct.
 	 */
-	for( ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		pci_bus = pci_bus_b(ln);
+	list_for_each_entry(pci_bus, &pci_root_buses, node) {
 		ret = sn_pci_fixup_bus(pci_bus);
 		if ( ret ) {
 			printk(KERN_WARNING

