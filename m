Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUJASPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUJASPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUJASNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:13:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33434 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266069AbUJASMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:12:43 -0400
Date: Fri, 01 Oct 2004 11:10:54 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, kernel-janitors@lists.osdl.org,
       Judith Lebzelter <judith@osdl.org>, davidm@hpl.hp.com,
       hannal@us.ibm.com, jbarnes@sgi.com
Subject: [PATCH 2.6.9-rc2-mm4 pci_bus_cvlink.c] Replace pci_find_device with pci_get_device
Message-ID: <112570000.1096654254@w-hlinder.beaverton.ibm.com>
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

diff -Nrup linux-2.6.9-rc2-mm4cln/arch/ia64/sn/io/machvec/pci_bus_cvlink.c linux-2.6.9-rc2-mm4patch2/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- linux-2.6.9-rc2-mm4cln/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-09-28 14:58:07.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch2/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	2004-09-30 16:56:57.454516072 -0700
@@ -904,7 +904,7 @@ sn_pci_init (void)
 	/*
 	 * Initialize the device vertex in the pci_dev struct.
 	 */
-	while ((pci_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
+	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL) {
 		ret = sn_pci_fixup_slot(pci_dev);
 		if ( ret ) {
 			printk(KERN_WARNING

