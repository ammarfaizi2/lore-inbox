Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263203AbVCDVsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbVCDVsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbVCDVpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:45:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:36513 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263110AbVCDUyQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:16 -0500
Cc: c.lucas@ifrance.com
Subject: [PATCH] drivers/pci/*: convert to pci_register_driver
In-Reply-To: <11099696371910@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <11099696372884@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.16, 2005/02/17 15:05:08-08:00, c.lucas@ifrance.com

[PATCH] drivers/pci/*: convert to pci_register_driver

convert from pci_module_init to pci_register_driver
(from:http://kerneljanitors.org/TODO).

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/pcie/portdrv_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
--- a/drivers/pci/pcie/portdrv_pci.c	2005-03-04 12:42:24 -08:00
+++ b/drivers/pci/pcie/portdrv_pci.c	2005-03-04 12:42:24 -08:00
@@ -106,7 +106,7 @@
 	int retval = 0;
 
 	pcie_port_bus_register();
-	retval = pci_module_init(&pcie_portdrv);
+	retval = pci_register_driver(&pcie_portdrv);
 	if (retval)
 		pcie_port_bus_unregister();
 	return retval;

