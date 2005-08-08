Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVHHXyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVHHXyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHHXyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:54:01 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:38793 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932366AbVHHXyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:54:00 -0400
Date: Tue, 9 Aug 2005 01:54:01 +0200
Message-Id: <200508082354.j78Ns1Cn028468@wscnet.wsc.cz>
Subject: [PATCH] pci_find_device and pci_find_slot mark as deprecated
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-reply-to: <42F72D4D.8030102@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This marks these functions as deprecated not to use in latest drivers (it
doesn't use reference counts and the device returned by it can disappear in
any time).

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -328,9 +328,11 @@ void pci_setup_cardbus(struct pci_bus *b
 
 /* Generic PCI functions exported to card drivers */
 
-struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
+struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device,
+	const struct pci_dev *from) __deprecated;
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
-struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
+struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn)
+	__deprecated;
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
