Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVAQXYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVAQXYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVAQWRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:17:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:18079 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262926AbVAQWCF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:05 -0500
Cc: bjorn.helgaas@hp.com
Subject: [PATCH] PCI: use modern format for PCI addresses
In-Reply-To: <1105999312295@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:52 -0800
Message-Id: <1105999312534@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.2, 2005/01/14 15:56:59-08:00, bjorn.helgaas@hp.com

[PATCH] PCI: use modern format for PCI addresses

Use pci_name() rather than "%02x:%02x" when printing PCI
address information.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/pcbios.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/pci/pcbios.c b/arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	2005-01-17 13:56:28 -08:00
+++ b/arch/i386/pci/pcbios.c	2005-01-17 13:56:28 -08:00
@@ -385,8 +385,8 @@
 			}
 		}
 		if (!found) {
-			printk(KERN_WARNING "PCI: Device %02x:%02x not found by BIOS\n",
-				dev->bus->number, dev->devfn);
+			printk(KERN_WARNING "PCI: Device %s not found by BIOS\n",
+				pci_name(dev));
 			list_del(&dev->global_list);
 			list_add_tail(&dev->global_list, &sorted_devices);
 		}

