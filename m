Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUJASPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUJASPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUJASOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:14:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:43717 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266009AbUJASMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:12:22 -0400
Date: Fri, 01 Oct 2004 11:10:43 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, kernel-janitors@lists.osdl.org,
       Judith Lebzelter <judith@osdl.org>, davidm@hpl.hp.com,
       hannal@us.ibm.com
Subject: [PATCH 2.6.9-rc2-mm4 ia64/pci/pci.c] Replace pci_find_device with pci_get_device
Message-ID: <112540000.1096654243@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away soon I have replaced the call with pci_get_device.
Judith, could you run these 3 ia64 ones through PLM, please? 

Thanks a lot.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc2-mm4cln/arch/ia64/pci/pci.c linux-2.6.9-rc2-mm4patch/arch/ia64/pci/pci.c
--- linux-2.6.9-rc2-mm4cln/arch/ia64/pci/pci.c	2004-09-28 14:58:07.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch/arch/ia64/pci/pci.c	2004-09-30 16:48:22.511799264 -0700
@@ -154,7 +154,7 @@ extern acpi_status acpi_map_iosapic (acp
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");

