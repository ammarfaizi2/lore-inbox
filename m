Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVALADd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVALADd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVAKXjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:39:46 -0500
Received: from coderock.org ([193.77.147.115]:64453 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262947AbVAKXfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:02 -0500
Subject: [patch 02/11] arch/i386/pci/acpi.c Use for_each_pci_dev macro
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, hannal@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:34:54 +0100
Message-Id: <20050111233454.029A01F225@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Using the new for_each_pci_dev macro. Compiled and boot tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/pci/acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/pci/acpi.c~for-each-pci-dev-arch_i386_pci_acpi arch/i386/pci/acpi.c
--- kj/arch/i386/pci/acpi.c~for-each-pci-dev-arch_i386_pci_acpi	2005-01-10 17:59:56.000000000 +0100
+++ kj-domen/arch/i386/pci/acpi.c	2005-01-10 17:59:56.000000000 +0100
@@ -41,7 +41,7 @@ static int __init pci_acpi_init(void)
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");
_
