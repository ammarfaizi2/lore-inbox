Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbUKLXZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbUKLXZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUKLXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:24:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64504 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262691AbUKLXWp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:45 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017194120@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017193602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.14, 2004/11/12 14:08:40-08:00, hannal@us.ibm.com

[PATCH] ret_mb_a_pci.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/v850/kernel/rte_mb_a_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/v850/kernel/rte_mb_a_pci.c b/arch/v850/kernel/rte_mb_a_pci.c
--- a/arch/v850/kernel/rte_mb_a_pci.c	2004-11-12 15:10:19 -08:00
+++ b/arch/v850/kernel/rte_mb_a_pci.c	2004-11-12 15:10:19 -08:00
@@ -254,7 +254,7 @@
 	struct pci_dev *dev = NULL;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		unsigned di_num;
 		unsigned class = dev->class >> 8;
 

