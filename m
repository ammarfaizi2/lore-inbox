Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUHWTxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUHWTxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHWTvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:51:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:47043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266824AbUHWSgS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:18 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860881850@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <10932860894178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.39, 2004/08/09 14:26:14-07:00, greg@kroah.com

PCI Hotplug: fix compiler warnings in pciehp driver.


 drivers/pci/hotplug/pciehp_hpc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-08-23 11:02:55 -07:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-08-23 11:02:55 -07:00
@@ -1017,7 +1017,7 @@
 	return IRQ_HANDLED;
 }
 
-static int hpc_get_max_lnk_speed (struct slot *slot, enum pcie_link_speed *value)
+static int hpc_get_max_lnk_speed (struct slot *slot, enum pci_bus_speed *value)
 {
 	struct php_ctlr_state_s *php_ctlr = slot->ctrl->hpc_ctlr_handle;
 	enum pcie_link_speed lnk_speed;
@@ -1120,7 +1120,7 @@
 	return retval;
 }
 
-static int hpc_get_cur_lnk_speed (struct slot *slot, enum pcie_link_speed *value)
+static int hpc_get_cur_lnk_speed (struct slot *slot, enum pci_bus_speed *value)
 {
 	struct php_ctlr_state_s *php_ctlr = slot->ctrl->hpc_ctlr_handle;
 	enum pcie_link_speed lnk_speed = PCI_SPEED_UNKNOWN;

