Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUJDV2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUJDV2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUJDV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:27:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58089 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268541AbUJDV0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:26:06 -0400
Date: Mon, 04 Oct 2004 14:26:47 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com,
       ralf@linux-mips.org
Subject: [PATCH 2.6] pci-hplj.c: replace pci_find_device with pci_get_device
Message-ID: <281940000.1096925207@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As pci_find_device is going away I have replaced this call with pci_get_device.
If  someone has access to an RM200 or RM300 and could test this I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---

diff -Nrup linux-2.6.9-rc3-mm2cln/arch/mips/pci/pci-hplj.c linux-2.6.9-rc3-mm2patch/arch/mips/pci/pci-hplj.c
--- linux-2.6.9-rc3-mm2cln/arch/mips/pci/pci-hplj.c	2004-09-29 20:05:21.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/mips/pci/pci-hplj.c	2004-10-04 14:20:25.307153544 -0700
@@ -118,7 +118,7 @@ void __init pcibios_fixup_irqs(void)
 	struct pci_dev *dev = NULL;
 	int slot_num;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		slot_num = PCI_SLOT(dev->devfn);
 		switch (slot_num) {
 		case 2:


