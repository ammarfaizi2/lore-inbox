Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUDORYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbUDORYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:24:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:13486 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263081AbUDORYC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:02 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10820498251037@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <1082049825348@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.9, 2004/03/31 14:55:47-08:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: RPA PCI Hotplug - redundant free

Please commit the following patch, which removes a redundant call to a
cleanup function from an error path of the module init code.


 drivers/pci/hotplug/rpaphp_pci.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	Thu Apr 15 10:04:29 2004
+++ b/drivers/pci/hotplug/rpaphp_pci.c	Thu Apr 15 10:04:29 2004
@@ -304,7 +304,6 @@
 	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
 		dbg("%s: NOT_VALID: skip dn->full_name=%s\n",
 		    __FUNCTION__, slot->dn->full_name);
-		dealloc_slot_struct(slot);
 		return (-1);
 	}
 	return (0);

