Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbVJXN6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVJXN6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVJXN6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:58:54 -0400
Received: from magic.adaptec.com ([216.52.22.17]:9657 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751033AbVJXN6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:58:54 -0400
Subject: [PATCH] pcie: Fixes Several Warnings in
	drivers/pci/pcie/portdrv_pci.c
From: Ashutosh Naik <ashutosh_naik@adaptec.com>
To: tom.l.nguyen@intel.com, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1130162333.16820.92.camel@kir9060.adaptec.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Oct 2005 19:28:53 +0530
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2005 13:58:39.0152 (UTC) FILETIME=[08F5C300:01C5D8A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch fixes the compilation warnings of the type "defined but not
used" when CONFIG_PM is enabled.

Signed-off-by: Ashutosh Naik <ashutosh_naik@adaptec.com>

--

diff -ruNp linux-2.6.14-rc5-pcie-patch/drivers/pci/pcie/portdrv_pci.c
linux-2.6.14-rc5/drivers/pci/pcie/portdrv_pci.c
--- linux-2.6.14-rc5-pcie-patch/drivers/pci/pcie/portdrv_pci.c 
2005-10-24 14:05:03.000000000 +0530
+++ linux-2.6.14-rc5/drivers/pci/pcie/portdrv_pci.c     2005-10-23
13:06:54.000000000 +0530
@@ -29,7 +29,6 @@ MODULE_LICENSE("GPL");
 /* global data */
 static const char device_name[] = "pcieport-driver";
  
-#ifdef CONFIG_PM
 static void pci_save_msi_state(struct pci_dev *dev)
 {
        struct pcie_port_device_ext *p_ext = pci_get_drvdata(dev);
@@ -105,7 +104,6 @@ static int pcie_portdrv_restore_config(s
        pci_set_master(dev);
        return 0;
 }
-#endif
  
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices


