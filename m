Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbUAGEm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 23:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUAGEm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 23:42:29 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:63964 "HELO
	develer.com") by vger.kernel.org with SMTP id S266106AbUAGEm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 23:42:27 -0500
Message-ID: <3FFB8E2D.1070406@develer.com>
Date: Wed, 07 Jan 2004 05:42:21 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: ajoshi@shell.unixbox.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Identify RADEON Yd in radeonfb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

identify a recent Radeon video card in radeonfb.
Please, apply.

diff -Nrup linux-2.6.0-1.24/include/linux/pci_ids.h linux-2.6.0-1.23/include/linux/pci_ids.h
--- linux-2.6.0-1.24/include/linux/pci_ids.h	2004-01-05 17:43:45.000000000 +0100
+++ linux-2.6.0-1.24/include/linux/pci_ids.h	2004-01-05 01:16:18.000000000 +0100
@@ -291,6 +291,7 @@
 #define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
 /* Radeon RV280 (9200) */
 #define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
+#define PCI_DEVICE_ID_ATI_RADEON_Yd	0x5964
 /* Radeon R300 (9500) */
 #define PCI_DEVICE_ID_ATI_RADEON_AD	0x4144
 /* Radeon R300 (9700) */
diff -Nrup linux-2.6.0-1.24/drivers/video/radeonfb.c linux-2.6.0-1.23/drivers/video/radeonfb.c
--- linux-2.6.0-1.24/drivers/video/radeonfb.c	2003-12-18 03:59:44.000000000 +0100
+++ linux-2.6.0-1.24/drivers/video/radeonfb.c	2004-01-07 05:29:44.418248063 +0100
@@ -114,6 +114,7 @@ enum radeon_chips {
 	RADEON_Ie,
 	RADEON_If,
 	RADEON_Ig,
+	RADEON_Yd,
 	RADEON_Ld,
 	RADEON_Le,
 	RADEON_Lf,
@@ -207,6 +208,7 @@ static struct pci_device_id radeonfb_pci
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ie, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ie},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_If, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_If},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ig, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ig},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yd},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ld, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ld},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Le, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Le},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Lf, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Lf},

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/


