Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270210AbUJTEpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbUJTEpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270152AbUJSXbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:31:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:11914 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270145AbUJSWqe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257374003@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <1098225737858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.41, 2004/10/06 13:04:35-07:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: quirk fix missed out in last patch

This patch contains a fix that was missed out in the last patch I sent
you regarding fixes for writing 1's to RsvdZ in Slot Status register
causing hot-plugging of PCI-X cards not working in some slots.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/shpchp_hpc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:23:59 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-10-19 15:23:59 -07:00
@@ -1158,7 +1158,7 @@
 					hp_slot, php_ctlr->callback_instance_id);
 			
 			/* Clear all slot events */
-			temp_dword = 0xe01fffff;
+			temp_dword = 0xe01f3fff;
 			dbg("%s: Clearing slot events, temp_dword = %x\n",
 				__FUNCTION__, temp_dword); 
 			writel(temp_dword, php_ctlr->creg + SLOT1 + (4*hp_slot));

