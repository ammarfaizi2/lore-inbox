Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJHW0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJHW0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUJHW0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:26:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43006 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265978AbUJHW0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:26:46 -0400
Date: Fri, 08 Oct 2004 15:26:46 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, wli@holomorphy.com
Subject: [RFT 2.6] ebus.c replace pci_find_device with pci_get_device
Message-ID: <83130000.1097274406@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with a Sparc system could test it I would appreciate it.
Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm3cln/arch/sparc/kernel/ebus.c linux-2.6.9-rc3-mm3patch2/arch/sparc/kernel/ebus.c
--- linux-2.6.9-rc3-mm3cln/arch/sparc/kernel/ebus.c	2004-09-29 20:05:51.000000000 -0700
+++ linux-2.6.9-rc3-mm3patch2/arch/sparc/kernel/ebus.c	2004-10-08 15:17:41.481638808 -0700
@@ -275,7 +275,7 @@ void __init ebus_init(void)
 		}
 	}
 
-	pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
+	pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS, 0);
 	if (!pdev) {
 		return;
 	}
@@ -342,7 +342,7 @@ void __init ebus_init(void)
 		}
 
 	next_ebus:
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN,
+		pdev = pci_get_device(PCI_VENDOR_ID_SUN,
 				       PCI_DEVICE_ID_SUN_EBUS, pdev);
 		if (!pdev)
 			break;

