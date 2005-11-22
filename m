Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVKVQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVKVQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVKVQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:01:25 -0500
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:19461 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S964974AbVKVQBZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:01:25 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] pci hotplug: Fix cut/paste error
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 22 Nov 2005 11:01:13 -0500
Message-ID: <5E735516D527134997ABD465886BBDA61AC2FF@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] pci hotplug: Fix cut/paste error
Thread-Index: AcXvffat5aawXJVtTBSv3ckPI6UiJA==
From: "Jordan, William P" <William.Jordan@unisys.com>
To: <gregkh@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Nov 2005 16:01:14.0914 (UTC) FILETIME=[F750B820:01C5EF7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Jordan <william.jordan@unisys.com>

Fixed code which checked the wrong PCI config register.
Against linux-2.6.15-rc1

Signed-off-by: William Jordan <william.jordan@unisys.com>
---

--- linux-2.6.15-rc1/drivers/pci/hotplug/ibmphp_pci.c.orig
2005-11-22 10:14:30.000000000 -0500
+++ linux-2.6.15-rc1/drivers/pci/hotplug/ibmphp_pci.c	2005-11-22
10:15:05.000000000 -0500
@@ -969,7 +969,7 @@ static int configure_bridge (struct pci_
 			debug ("io 32\n");
 			need_io_upper = TRUE;
 		}
-		if ((io_base & PCI_PREF_RANGE_TYPE_MASK) ==
PCI_PREF_RANGE_TYPE_64) {
+		if ((pfmem_base & PCI_PREF_RANGE_TYPE_MASK) ==
PCI_PREF_RANGE_TYPE_64) {
 			debug ("pfmem 64\n");
 			need_pfmem_upper = TRUE;
 		}

