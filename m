Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270159AbUJSXbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270159AbUJSXbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270156AbUJSX1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:27:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:13706 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270154AbUJSWqg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:36 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257351131@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257353013@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.23, 2004/10/06 12:12:44-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-sparc-kernel-pcic.c

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/sparc/kernel/pcic.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c	2004-10-19 15:25:43 -07:00
+++ b/arch/sparc/kernel/pcic.c	2004-10-19 15:25:43 -07:00
@@ -603,7 +603,7 @@
  */
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct list_head *walk;
+	struct pci_dev *dev;
 	int i, has_io, has_mem;
 	unsigned int cmd;
 	struct linux_pcic *pcic;
@@ -625,9 +625,7 @@
 		return;
 	}
 
-	walk = &bus->devices;
-	for (walk = walk->next; walk != &bus->devices; walk = walk->next) {
-		struct pci_dev *dev = pci_dev_b(walk);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 
 		/*
 		 * Comment from i386 branch:

