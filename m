Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269943AbUJTK0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269943AbUJTK0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270075AbUJSXBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:01:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:1674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270105AbUJSWqZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:25 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225734438@kroah.com>
Date: Tue, 19 Oct 2004 15:42:14 -0700
Message-Id: <10982257342714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.18, 2004/10/06 11:59:04-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-ia64-pci-pci.c

Change for loops with list_for_each_entry().

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ia64/pci/pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	2004-10-19 15:26:11 -07:00
+++ b/arch/ia64/pci/pci.c	2004-10-19 15:26:11 -07:00
@@ -365,10 +365,10 @@
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

