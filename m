Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbUKLXZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbUKLXZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUKLXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:25:30 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39395 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262684AbUKLXWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:42 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017181959@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <11003017181589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.5, 2004/11/12 14:01:55-08:00, hannal@us.ibm.com

[PATCH] chrp_pci.c: replace pci_find_device with for_each_pci_dev

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/chrp_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/chrp_pci.c b/arch/ppc/platforms/chrp_pci.c
--- a/arch/ppc/platforms/chrp_pci.c	2004-11-12 15:11:26 -08:00
+++ b/arch/ppc/platforms/chrp_pci.c	2004-11-12 15:11:26 -08:00
@@ -158,7 +158,7 @@
 	struct device_node *np;
 
 	/* PCI interrupts are controlled by the OpenPIC */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		np = pci_device_to_OF_node(dev);
 		if ((np != 0) && (np->n_intrs > 0) && (np->intrs[0].line != 0))
 			dev->irq = np->intrs[0].line;

