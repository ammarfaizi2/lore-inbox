Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266413AbUBLGfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUBLGfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:35:37 -0500
Received: from ozlabs.org ([203.10.76.45]:40407 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266413AbUBLGfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:35:32 -0500
Subject: [PATCH] Fix typo in ppc32 build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076567568.866.184.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 17:32:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The patch adding the OF platform entries had a typo ;) I sent a
revised patch but apparently you merged the old one. ppc64 is fine
since the G5 patch contains the fix, ppc32 need this:

Cheers,
Ben.

===== arch/ppc/kernel/pci.c 1.37 vs edited =====
--- 1.37/arch/ppc/kernel/pci.c	Tue Feb 10 17:20:41 2004
+++ edited/arch/ppc/kernel/pci.c	Thu Feb 12 17:31:26 2004
@@ -1039,7 +1039,7 @@
 #endif /* CONFIG_PPC_OF */
 
 /* Add sysfs properties */
-void pcibios_add_platform_entries(struct pci_dev *dev)
+void pcibios_add_platform_entries(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PPC_OF
 	device_create_file(&pdev->dev, &dev_attr_devspec);


