Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbVCKFle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbVCKFle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbVCKFkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:40:06 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:30167 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S263203AbVCKFjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:39:07 -0500
Date: Thu, 10 Mar 2005 23:38:58 -0600
From: DHollenbeck <dick@softplc.com>
Subject: [PATCH] sealevel 8 port RS-232/RS-422/RS-485 board
To: rmk+serial@arm.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <42312EF2.1040505@softplc.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vendor Sealevel suggested these changes for its new board.  Tried them, 
they work with the card.  Please apply the patch below, which was made 
from 2.6.10 but can be applied to 2.6.11.2 without errors.

Dick


--- linux/drivers/serial/8250_pci.orig  2005-03-10 13:09:39.000000000 -0600
+++ linux/drivers/serial/8250_pci.c     2005-03-10 15:03:39.000000000 -0600
@@ -1867,6 +1867,9 @@
        {       PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM8,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                pbn_b2_8_115200 },
+       {       PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM8,
+               PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+               pbn_b2_8_115200 },

        {       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0,
--- linux/drivers/pci/pci.ids.orig      2005-03-10 13:10:10.000000000 -0600
+++ linux/drivers/pci/pci.ids   2005-03-10 15:21:43.000000000 -0600
@@ -5714,6 +5714,7 @@
        7401  Four Port RS-232 Interface
        7402  Four Port RS-422/485 Interface
        7801  Eight Port RS-232 Interface
+       7804  Eight Port RS-232/422/485 Interface
        8001  8001 Digital I/O Adapter
 135f  I-Data International A-S
 1360  Meinberg Funkuhren
--- linux/include/linux/pci_ids.h.orig  2005-03-10 13:11:25.000000000 -0600
+++ linux/include/linux/pci_ids.h       2005-03-10 15:06:07.000000000 -0600
@@ -1780,6 +1780,7 @@
 #define PCI_DEVICE_ID_SEALEVEL_UCOMM232        0x7202
 #define PCI_DEVICE_ID_SEALEVEL_COMM4   0x7401
 #define PCI_DEVICE_ID_SEALEVEL_COMM8   0x7801
+#define PCI_DEVICE_ID_SEALEVEL_UCOMM8  0x7804

 #define PCI_VENDOR_ID_HYPERCOPE                0x1365
 #define PCI_DEVICE_ID_HYPERCOPE_PLX    0x9050



