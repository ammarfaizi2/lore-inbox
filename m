Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUINXoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUINXoD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUINXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:44:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35559 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265051AbUINXoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:44:00 -0400
Date: Tue, 14 Sep 2004 16:41:19 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com
Subject: [2.6.9-rc1-mm5 cyrix.c] Fix one missed pci_find_device
Message-ID: <19590000.1095205279@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just noticed this in my update to the latest mm kernel... 

Hanna 
------

diff -Nrup linux-2.6.9-rc1-mm5/arch/i386/kernel/cpu/cyrix.c linux-2.6.9-rc1-mm5patch/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.9-rc1-mm5/arch/i386/kernel/cpu/cyrix.c	2004-09-14 16:25:33.000000000 -0700
+++ linux-2.6.9-rc1-mm5patch/arch/i386/kernel/cpu/cyrix.c	2004-09-14 16:35:14.036275480 -0700
@@ -280,7 +280,7 @@ static void __init init_cyrix(struct cpu
 			pci_dev_put(dev);
 			pit_latch_buggy = 1;
 		}
-		dev =  pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
+		dev =  pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
 		if (dev) {
 			pci_dev_put(dev);
 			pit_latch_buggy = 1;

