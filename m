Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUJFV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUJFV2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269445AbUJFU2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51371 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269475AbUJFUXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:23:18 -0400
Date: Wed, 06 Oct 2004 13:23:48 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       hannal@us.ibm.com, hch@infradead.org
Subject: [PATCH 2.6][2/54] arch/i386/pci/acpi.c Use for_each_pci_dev macro
Message-ID: <3740000.1097094228@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using the new for_each_pci_dev macro. Compiled and boot tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/i386/pci/acpi.c linux-2.6.9-rc3-mm2patch3/arch/i386/pci/acpi.c
--- linux-2.6.9-rc3-mm2cln/arch/i386/pci/acpi.c	2004-10-04 11:38:04.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch3/arch/i386/pci/acpi.c	2004-10-06 12:27:55.818932576 -0700
@@ -41,7 +41,7 @@ static int __init pci_acpi_init(void)
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		for_each_pci_dev(dev);
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");

