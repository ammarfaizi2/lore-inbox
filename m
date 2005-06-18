Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFRTuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFRTuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVFRTuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:50:10 -0400
Received: from mato.luukku.com ([193.209.83.251]:57022 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S261195AbVFRTuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:50:03 -0400
Date: Sat, 18 Jun 2005 22:49:56 +0300
To: hch@infradead.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12] Fix typo in drivers/pci/pci-driver.c
Message-ID: <20050618194956.GA4665@miku.homelinux.net>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mikukkon@miku.homelinux.net (Mika Kukkonen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The git commit 794f5bfa77955c4455f6d72d8b0e2bee25f1ff0c
accidentally suffers from a previous typo in that file
(',' instead of ';' in end of line). Patch included.

Signed-off-by: Mika Kukkonen (mikukkon@iki.fi)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c	2005-06-18 22:05:42.642463416 +0300
+++ linux-2.6/drivers/pci/pci-driver.c	2005-06-18 22:10:37.486761280 +0300
@@ -396,7 +396,7 @@
 	/* FIXME, once all of the existing PCI drivers have been fixed to set
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
-		drv->driver.shutdown = pci_device_shutdown,
+		drv->driver.shutdown = pci_device_shutdown;
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
