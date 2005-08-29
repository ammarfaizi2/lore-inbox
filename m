Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVH2W1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVH2W1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVH2W0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:26:22 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:41864 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751374AbVH2W0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:26:05 -0400
Date: Tue, 30 Aug 2005 00:25:50 +0200
Message-Id: <200508292225.j7TMPoib019968@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 4/7] arch: pci_find_device remove (frv/mb93090-mb00/pci-irq.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 pci-irq.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-irq.c b/arch/frv/mb93090-mb00/pci-irq.c
--- a/arch/frv/mb93090-mb00/pci-irq.c
+++ b/arch/frv/mb93090-mb00/pci-irq.c
@@ -48,9 +48,7 @@ void __init pcibios_fixup_irqs(void)
 	struct pci_dev *dev = NULL;
 	uint8_t line, pin;
 
-	while (dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev),
-	       dev != NULL
-	       ) {
+	for_each_pci_dev(dev) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 		if (pin) {
 			dev->irq = pci_bus0_irq_routing[PCI_SLOT(dev->devfn)][pin - 1];
