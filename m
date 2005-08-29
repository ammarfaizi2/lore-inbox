Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVH2WZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVH2WZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVH2WZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:25:53 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:51592 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751368AbVH2WZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:25:49 -0400
Date: Tue, 30 Aug 2005 00:25:34 +0200
Message-Id: <200508292225.j7TMPYiY019957@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 3/7] arch: pci_find_device remove (frv/mb93090-mb00/pci-frv.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 pci-frv.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
--- a/arch/frv/mb93090-mb00/pci-frv.c
+++ b/arch/frv/mb93090-mb00/pci-frv.c
@@ -142,9 +142,7 @@ static void __init pcibios_allocate_reso
 	u16 command;
 	struct resource *r, *pr;
 
-	while (dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev),
-	       dev != NULL
-	       ) {
+	for_each_pci_dev(dev) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for(idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -188,9 +186,7 @@ static void __init pcibios_assign_resour
 	int idx;
 	struct resource *r;
 
-	while (dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev),
-	       dev != NULL
-	       ) {
+	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */
