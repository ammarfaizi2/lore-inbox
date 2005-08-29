Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVH2WYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVH2WYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVH2WYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:24:49 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:10633 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751363AbVH2WYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:24:48 -0400
Date: Tue, 30 Aug 2005 00:24:39 +0200
Message-Id: <200508292224.j7TMOddY019911@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 1/7] arch: pci_find_device remove (alpha/kernel/sys_alcor.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, rth@twiddle.net,
       ink@jurassic.park.msu.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 sys_alcor.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_alcor.c b/arch/alpha/kernel/sys_alcor.c
--- a/arch/alpha/kernel/sys_alcor.c
+++ b/arch/alpha/kernel/sys_alcor.c
@@ -254,7 +254,7 @@ alcor_init_pci(void)
 	 * motherboard, by looking for a 21040 TULIP in slot 6, which is
 	 * built into XLT and BRET/MAVERICK, but not available on ALCOR.
 	 */
-	dev = pci_find_device(PCI_VENDOR_ID_DEC,
+	dev = pci_get_device(PCI_VENDOR_ID_DEC,
 			      PCI_DEVICE_ID_DEC_TULIP,
 			      NULL);
 	if (dev && dev->devfn == PCI_DEVFN(6,0)) {
@@ -262,6 +262,7 @@ alcor_init_pci(void)
 		printk(KERN_INFO "%s: Detected AS500 or XLT motherboard.\n",
 		       __FUNCTION__);
 	}
+	pci_dev_put(dev);
 }
 
 
