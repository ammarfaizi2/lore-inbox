Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUJDVS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUJDVS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUJDVS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:18:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40190 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268537AbUJDVSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:18:54 -0400
Date: Mon, 04 Oct 2004 14:19:37 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com,
       geert@linux-m68k.org, zippel@linux-m68k.org
Subject: [PATCH 2.6] hades-pci.c: replace pci_find_device with pci_get_device
Message-ID: <280230000.1096924777@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I have replaced this call with pci_get_device.
If anyone has access to a Hades Atari clone to test this one I would appreciate it..

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9-rc3-mm2cln/arch/m68k/atari/hades-pci.c linux-2.6.9-rc3-mm2patch/arch/m68k/atari/hades-pci.c
--- linux-2.6.9-rc3-mm2cln/arch/m68k/atari/hades-pci.c	2004-09-29 20:04:57.000000000 -0700
+++ linux-2.6.9-rc3-mm2patch/arch/m68k/atari/hades-pci.c	2004-10-04 13:30:44.120362824 -0700
@@ -311,7 +311,7 @@ static void __init hades_fixup(int pci_m
 	 * Go through all devices, fixing up irqs as we see fit:
 	 */
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 	{
 		if (dev->class >> 16 != PCI_BASE_CLASS_BRIDGE)
 		{


