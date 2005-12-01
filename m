Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVLAM7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVLAM7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVLAM7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:59:35 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:31742 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932207AbVLAM7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:59:34 -0500
Date: Thu, 1 Dec 2005 13:59:29 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051201130438.28376.78967.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
References: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 2.6.15-rc3(-mm1) 3/3] pci.h:
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

#if 0'ing no-longer-needed pci_module_init().

Need remove-pci_module_init-patches for both 2.6.15-rc3 and 2.6.15-rc3-mm1 to be implemented.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 pci.h |    2 ++
 1 files changed, 2 insertions(+)

diff -Narup a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-12-01 02:15:06.000000000 +0100
+++ b/include/linux/pci.h	2005-12-01 03:53:48.000000000 +0100
@@ -345,11 +345,13 @@ struct pci_driver {
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
+#if 0
 /*
  * pci_module_init is obsolete, this stays here till we fix up all usages of it
  * in the tree.
  */
 #define pci_module_init	pci_register_driver
+#endif
 
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
