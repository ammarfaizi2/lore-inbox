Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUJHW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUJHW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJHWzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:55:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48033 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266183AbUJHWxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:53:43 -0400
Date: Fri, 08 Oct 2004 15:53:42 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, davem@davemloft.net, ecd@skynet.be,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org
Subject: [RFT 2.6] ebus.c replace pci_find_device with pci_get_device
Message-ID: <87310000.1097276022@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a Sparc64 system could test it I would appreciate it.
Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/sparc64/kernel/ebus.c linux-2.6.9-rc3-mm3patch2/arch/sparc64/kernel/ebus.c
--- linux-2.6.9-rc3-mm3cln/arch/sparc64/kernel/ebus.c	2004-09-29 20:04:25.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch2/arch/sparc64/kernel/ebus.c	2004-10-08 15:37:52.333561336 -0700
@@ -528,7 +528,7 @@ static struct pci_dev *find_next_ebus(st
 	struct pci_dev *pdev = start;
 
 	do {
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
+		pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
 		if (pdev &&
 		    (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
 		     pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))


