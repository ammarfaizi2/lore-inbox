Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbUKLXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUKLXoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUKLXoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:44:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49123 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262703AbUKLXWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:51 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017153917@kroah.com>
Date: Fri, 12 Nov 2004 15:21:55 -0800
Message-Id: <11003017152328@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.35.6, 2004/10/28 16:26:11-05:00, akpm@osdl.org

[PATCH] PCI: Changed pci_find_device to pci_get_device

From: Hanna Linder <hannal@us.ibm.com>

Another simple patch to complete the /i386 conversion to pci_get_device.  I
was able to compile and boot this patch to verify it didn't break anything
(on my T22).

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	2004-11-12 15:14:14 -08:00
+++ b/arch/i386/pci/acpi.c	2004-11-12 15:14:14 -08:00
@@ -41,7 +41,7 @@
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");

