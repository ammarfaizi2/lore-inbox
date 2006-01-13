Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422904AbWAMT7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422904AbWAMT7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422883AbWAMT54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:50836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422870AbWAMTuc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:32 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add parisc_bus_type probe and remove methods
In-Reply-To: <11371818093332@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:09 -0800
Message-Id: <11371818091202@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add parisc_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ad3ed31c682d956d2187e562635c55c8c74c1021
tree b050cef6a5f686f9cf2b9b16cbf63c7387053da3
parent 83dfb8b67522f6cf1fc5771a8be0a9095eea65d4
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:34:38 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:06 -0800

 arch/parisc/kernel/drivers.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 1eaa0d3..2d804e2 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -173,8 +173,6 @@ int register_parisc_driver(struct parisc
 	WARN_ON(driver->drv.probe != NULL);
 	WARN_ON(driver->drv.remove != NULL);
 
-	driver->drv.probe = parisc_driver_probe;
-	driver->drv.remove = parisc_driver_remove;
 	driver->drv.name = driver->name;
 
 	return driver_register(&driver->drv);
@@ -575,6 +573,8 @@ struct bus_type parisc_bus_type = {
 	.name = "parisc",
 	.match = parisc_generic_match,
 	.dev_attrs = parisc_device_attrs,
+	.probe = parisc_driver_probe,
+	.remove = parisc_driver_remove,
 };
 
 /**

