Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266419AbUF3DhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266419AbUF3DhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 23:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUF3DhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 23:37:17 -0400
Received: from penguin.linuxhardware.org ([63.173.68.170]:29613 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id S266419AbUF3Dg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 23:36:28 -0400
Date: Tue, 29 Jun 2004 23:38:54 -0400 (EDT)
From: augustus@penguin.linuxhardware.org
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] K8T800Pro AGP Support
Message-ID: <Pine.LNX.4.58.0406292326480.24803@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add support for the K8T800Pro chip in the AGPGART driver for 
amd64-agp.

Signed-off-by: Kris Kersey <augustus@linuxhardware.org>

Let me know if there are any problems.  Please reply to sender on this 
one.

Kris Kersey (Augustus)
LinuxHardware.org Site Manager
augustus@linuxhardware.org
Gentoo Linux AMD64 Developer
augustus@gentoo.org

diff -uprN linux-2.6.7/drivers/char/agp/amd64-agp.c linux-2.6.7-K8T800Pro/drivers/char/agp/amd64-agp.c
--- linux-2.6.7/drivers/char/agp/amd64-agp.c    2004-06-21 00:01:41.000000000 -0400
+++ linux-2.6.7-K8T800Pro/drivers/char/agp/amd64-agp.c  2004-06-29 23:27:02.474431400 -0400
@@ -536,6 +536,15 @@ static struct pci_device_id agp_amd64_pc
        .subvendor      = PCI_ANY_ID,
        .subdevice      = PCI_ANY_ID,
        },
+       /* VIA K8T800Pro */
+       {
+       .class          = (PCI_CLASS_BRIDGE_HOST << 8),
+       .class_mask     = ~0,
+       .vendor         = PCI_VENDOR_ID_VIA,
+       .device         = PCI_DEVICE_ID_VIA_K8T800PRO_0,
+       .subvendor      = PCI_ANY_ID,
+       .subdevice      = PCI_ANY_ID,
+       },
        /* VIA K8T800 */
        {
        .class          = (PCI_CLASS_BRIDGE_HOST << 8),
diff -uprN linux-2.6.7/include/linux/pci_ids.h linux-2.6.7-K8T800Pro/include/linux/pci_ids.h
--- linux-2.6.7/include/linux/pci_ids.h 2004-06-21 00:01:41.000000000 -0400
+++ linux-2.6.7-K8T800Pro/include/linux/pci_ids.h       2004-06-29 23:27:02.475431248 -0400
@@ -1174,6 +1174,7 @@
 #define PCI_DEVICE_ID_VIA_8763_0       0x0198
 #define PCI_DEVICE_ID_VIA_8380_0       0x0204
 #define PCI_DEVICE_ID_VIA_PX8X0_0      0x0259
+#define PCI_DEVICE_ID_VIA_K8T800PRO_0  0x0282
 #define PCI_DEVICE_ID_VIA_8363_0       0x0305 
 #define PCI_DEVICE_ID_VIA_8371_0       0x0391
 #define PCI_DEVICE_ID_VIA_8501_0       0x0501

