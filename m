Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVCYAuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVCYAuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVCYAts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:49:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261255AbVCYAV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:21:57 -0500
Date: Fri, 25 Mar 2005 01:21:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pci/hotplug/cpqphp_core.c: fix a check after use
Message-ID: <20050325002155.GJ3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/pci/hotplug/cpqphp_core.c.old	2005-03-23 05:10:34.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/pci/hotplug/cpqphp_core.c	2005-03-23 05:10:55.000000000 +0100
@@ -577,11 +577,11 @@ cpqhp_set_attention_status(struct contro
 {
 	u8 hp_slot;
 
-	hp_slot = func->device - ctrl->slot_device_offset;
-
 	if (func == NULL)
 		return(1);
 
+	hp_slot = func->device - ctrl->slot_device_offset;
+
 	// Wait for exclusive access to hardware
 	down(&ctrl->crit_sect);
 

