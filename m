Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUIPV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUIPV5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIPV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:57:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:962 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267589AbUIPV5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:57:10 -0400
Date: Thu, 16 Sep 2004 14:54:11 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: len.brown@intel.com
cc: linux-kernel@vger.kernel.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.9-rc1-mm5 acpi.c] Changed pci_find_device to pci_get_device
Message-ID: <8240000.1095371651@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another simple patch to complete the /i386 conversion to pci_get_device.
I was able to compile and boot this patch to verify it didn't break anything
(on my T22).

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
----

diff -Nrup linux-2.6.9-rc1-mm5/arch/i386/pci/acpi.c linux-2.6.9-rc1-mm5patch/arch/i386/pci/acpi.c
--- linux-2.6.9-rc1-mm5/arch/i386/pci/acpi.c	2004-09-14 16:25:34.000000000 -0700
+++ linux-2.6.9-rc1-mm5patch/arch/i386/pci/acpi.c	2004-09-15 16:17:06.000000000 -0700
@@ -41,7 +41,7 @@ static int __init pci_acpi_init(void)
 		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
 		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
 		printk(KERN_INFO "** so I can fix the driver.\n");
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 			acpi_pci_irq_enable(dev);
 	} else {
 		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");

