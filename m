Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264272AbTCXQvC>; Mon, 24 Mar 2003 11:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264275AbTCXQuh>; Mon, 24 Mar 2003 11:50:37 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:39658 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264272AbTCXQax>; Mon, 24 Mar 2003 11:30:53 -0500
Message-Id: <200303241642.h2OGg235008241@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:50 +0000
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: extra dmfe ID.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Snarfed from Alans tree, and tested to work ok here
on a 1563.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tulip/dmfe.c linux-2.5/drivers/net/tulip/dmfe.c
--- bk-linus/drivers/net/tulip/dmfe.c	2003-03-08 09:57:19.000000000 +0000
+++ linux-2.5/drivers/net/tulip/dmfe.c	2003-03-17 23:42:29.000000000 +0000
@@ -49,6 +49,10 @@
     support.  Updated PCI resource allocation.  Do not
     forget to unmap PCI mapped skbs.
 
+    Alan Cox <alan@redhat.com>
+    Added new PCI identifiers provided by Clear Zhang at ALi 
+    for their 1563 ethernet device.
+
     TODO
 
     Implement pci_driver::suspend() and pci_driver::resume()
@@ -1975,6 +1979,7 @@ static struct pci_device_id dmfe_pci_tbl
 	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9102_ID },
 	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9100_ID },
 	{ 0x1282, 0x9009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9009_ID },
+	{ 0x10B9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9102_ID },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, dmfe_pci_tbl);
