Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVAKXTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVAKXTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVAKXSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:18:06 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:51931 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262878AbVAKXQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:16:43 -0500
Subject: [PATCH] use modern format for PCI addresses
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Jan 2005 16:16:36 -0700
Message-Id: <1105485396.31942.64.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_name() rather than "%02x:%02x" when printing PCI
address information.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/pci/pcbios.c 1.17 vs edited =====
--- 1.17/arch/i386/pci/pcbios.c	2004-07-11 06:41:13 -06:00
+++ edited/arch/i386/pci/pcbios.c	2005-01-11 09:41:24 -07:00
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


