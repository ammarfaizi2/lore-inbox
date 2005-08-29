Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVH2W0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVH2W0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVH2WZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:25:54 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:59784 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751366AbVH2WZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:25:07 -0400
Date: Tue, 30 Aug 2005 00:25:00 +0200
Message-Id: <200508292225.j7TMP0dP019924@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 2/7] arch: pci_find_device remove (alpha/kernel/sys_sio.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, rth@twiddle.net,
       ink@jurassic.park.msu.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 sys_sio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
--- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -105,7 +105,7 @@ sio_collect_irq_levels(void)
 	struct pci_dev *dev = NULL;
 
 	/* Iterate through the devices, collecting IRQ levels.  */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		if ((dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) &&
 		    (dev->class >> 8 != PCI_CLASS_BRIDGE_PCMCIA))
 			continue;
@@ -229,8 +229,8 @@ alphabook1_init_pci(void)
 	 */
 
 	dev = NULL;
-	while ((dev = pci_find_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
-                if (dev->device == PCI_DEVICE_ID_NCR_53C810
+	while ((dev = pci_get_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
+		if (dev->device == PCI_DEVICE_ID_NCR_53C810
 		    || dev->device == PCI_DEVICE_ID_NCR_53C815
 		    || dev->device == PCI_DEVICE_ID_NCR_53C820
 		    || dev->device == PCI_DEVICE_ID_NCR_53C825) {
