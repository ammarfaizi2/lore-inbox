Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVDAXuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVDAXuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVDAXtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:49:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:28636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262811AbVDAXsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:11 -0500
Cc: bunk@stusta.de
Subject: [PATCH] drivers/pci/hotplug/cpqphp_core.c: fix a check after use
In-Reply-To: <11123992733687@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:53 -0800
Message-Id: <11123992731314@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.20, 2005/03/28 15:10:15-08:00, bunk@stusta.de

[PATCH] drivers/pci/hotplug/cpqphp_core.c: fix a check after use

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/cpqphp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	2005-04-01 15:33:05 -08:00
+++ b/drivers/pci/hotplug/cpqphp_core.c	2005-04-01 15:33:05 -08:00
@@ -577,10 +577,10 @@
 {
 	u8 hp_slot;
 
-	hp_slot = func->device - ctrl->slot_device_offset;
-
 	if (func == NULL)
 		return(1);
+
+	hp_slot = func->device - ctrl->slot_device_offset;
 
 	// Wait for exclusive access to hardware
 	down(&ctrl->crit_sect);

