Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270167AbUJSXW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270167AbUJSXW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270031AbUJSXWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:22:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:19594 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270165AbUJSWql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:41 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257341560@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <1098225734848@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.16, 2004/10/06 11:51:24-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-i386-pci-i386.c

Replace for with more readable list_for_each.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/i386.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c	2004-10-19 15:26:27 -07:00
+++ b/arch/i386/pci/i386.c	2004-10-19 15:26:27 -07:00
@@ -96,15 +96,13 @@
 
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

