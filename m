Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266504AbUA3BeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUA3BeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:34:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:5852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266504AbUA3Bb5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:31:57 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263101304@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:50 -0800
Message-Id: <1075426310499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1520, 2004/01/29 16:19:53-08:00, ogasawara@osdl.org

[PATCH] PCI hotplug: pcihp_zt5550.c ioremap/iounmap audit

insert missing iounmap()


 drivers/pci/hotplug/cpcihp_zt5550.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
--- a/drivers/pci/hotplug/cpcihp_zt5550.c	Thu Jan 29 17:24:01 2004
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c	Thu Jan 29 17:24:01 2004
@@ -133,6 +133,8 @@
 {
 	if(!hc_dev)
 		return -ENODEV;
+
+	iounmap(hc_registers);
 	release_mem_region(pci_resource_start(hc_dev, 1),
 			   pci_resource_len(hc_dev, 1));
 	return 0;

