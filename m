Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVALPC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVALPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVALPC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:02:56 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21170 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261204AbVALPCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:02:55 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16869.15363.922789.694931@alkaid.it.uu.se>
Date: Wed, 12 Jan 2005 16:02:27 +0100
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, davem@redhat.com,
       jgarzik@pobox.com, mj@ucw.cz
Subject: [PATCH][2.4.29-rc1] 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Sun GEM/GMAC NIC driver in 2.4.29-rc1 doesn't recognise
the UniNorth 2 GMAC chip, aka 106b:0032, in my Apple eMac.
Fixed by this patch.

/Mikael

--- linux-2.4.29-rc1/drivers/net/sungem.c.~1~	2004-11-17 18:36:42.000000000 +0100
+++ linux-2.4.29-rc1/drivers/net/sungem.c	2005-01-12 15:09:06.000000000 +0100
@@ -119,6 +119,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMACP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{0, }
 };
 
--- linux-2.4.29-rc1/include/linux/pci_ids.h.~1~	2005-01-12 14:06:59.000000000 +0100
+++ linux-2.4.29-rc1/include/linux/pci_ids.h	2005-01-12 15:12:53.000000000 +0100
@@ -761,6 +761,7 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP_P	0x0027
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP15	0x002d
 #define PCI_DEVICE_ID_APPLE_UNI_N_FW2	0x0030
+#define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
