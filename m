Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270116AbUJSXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270116AbUJSXbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270087AbUJSX1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:27:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:15498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270155AbUJSWqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:38 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257342890@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <109822573458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.21, 2004/10/06 12:03:13-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-ppc64-kernel-pci_dn.c

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc64/kernel/pci_dn.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/arch/ppc64/kernel/pci_dn.c b/arch/ppc64/kernel/pci_dn.c
--- a/arch/ppc64/kernel/pci_dn.c	2004-10-19 15:25:53 -07:00
+++ b/arch/ppc64/kernel/pci_dn.c	2004-10-19 15:25:53 -07:00
@@ -196,11 +196,9 @@
 
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

