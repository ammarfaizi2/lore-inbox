Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbUKLXly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUKLXly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUKLXcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:32:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46998 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262676AbUKLXWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:38 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017191176@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017194120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.13, 2004/11/12 14:08:14-08:00, hannal@us.ibm.com

[PATCH] pci-gart.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/x86_64/kernel/pci-gart.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/x86_64/kernel/pci-gart.c b/arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	2004-11-12 15:10:27 -08:00
+++ b/arch/x86_64/kernel/pci-gart.c	2004-11-12 15:10:27 -08:00
@@ -81,7 +81,7 @@
 
 #define for_all_nb(dev) \
 	dev = NULL;	\
-	while ((dev = pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
+	while ((dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1103, dev))!=NULL)\
 	     if (dev->bus->number == 0 && 				     \
 		    (PCI_SLOT(dev->devfn) >= 24) && (PCI_SLOT(dev->devfn) <= 31))
 

