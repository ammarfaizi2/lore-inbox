Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUA3Bgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUA3Bg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:36:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:11996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266513AbUA3BcF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:05 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263054147@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:46 -0800
Message-Id: <1075426306325@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1510, 2004/01/29 14:26:28-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Fixup pcihp_skeleton.c

The functions are not named *_skel_*, so it seems useful not to call them with
this.


 drivers/pci/hotplug/pcihp_skeleton.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
--- a/drivers/pci/hotplug/pcihp_skeleton.c	Thu Jan 29 17:24:44 2004
+++ b/drivers/pci/hotplug/pcihp_skeleton.c	Thu Jan 29 17:24:44 2004
@@ -370,10 +370,10 @@
 		 * Initilize the slot info structure with some known
 		 * good values.
 		 */
-		info->power_status = get_skel_power_status(slot);
-		info->attention_status = get_skel_attention_status(slot);
-		info->latch_status = get_skel_latch_status(slot);
-		info->adapter_status = get_skel_adapter_status(slot);
+		info->power_status = get_power_status(slot);
+		info->attention_status = get_attention_status(slot);
+		info->latch_status = get_latch_status(slot);
+		info->adapter_status = get_adapter_status(slot);
 		
 		dbg ("registering slot %d\n", i);
 		retval = pci_hp_register (slot->hotplug_slot);

