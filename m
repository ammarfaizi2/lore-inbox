Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUA3BtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266506AbUA3Bek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:34:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:7900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266508AbUA3BcA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:00 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263091836@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:49 -0800
Message-Id: <1075426309208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1518, 2004/01/29 15:35:19-08:00, lxiep@us.ibm.com

[PATCH] PCI Hotplug: add unlimited PHP slot name lengths support


 drivers/pci/hotplug/pci_hotplug_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Thu Jan 29 17:24:09 2004
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Thu Jan 29 17:24:09 2004
@@ -571,7 +571,7 @@
 	if ((slot->info == NULL) || (slot->ops == NULL))
 		return -EINVAL;
 
-	strlcpy(slot->kobj.name, slot->name, KOBJ_NAME_LEN);
+	kobject_set_name(&slot->kobj, slot->name);
 	kobj_set_kset_s(slot, pci_hotplug_slots_subsys);
 
 	/* this can fail if we have already registered a slot with the same name */

