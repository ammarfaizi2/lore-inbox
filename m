Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422884AbWAMT5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWAMT5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWAMT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:53908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422884AbWAMTud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:33 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add pnp_bus_type probe and remove methods
In-Reply-To: <11371818113200@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:11 -0800
Message-Id: <11371818114002@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add pnp_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4681fc320889de4591f945c4fdf08546eb9ab266
tree 84da79632be2925c68eed99636c184f8342d270e
parent 1d0baa3a1c836f0403b318d549fd49ebc73ee631
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:41:37 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:09 -0800

 drivers/pnp/driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 15fb758..7cafacd 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -195,6 +195,8 @@ static int pnp_bus_resume(struct device 
 struct bus_type pnp_bus_type = {
 	.name	= "pnp",
 	.match	= pnp_bus_match,
+	.probe	= pnp_device_probe,
+	.remove	= pnp_device_remove,
 	.suspend = pnp_bus_suspend,
 	.resume = pnp_bus_resume,
 };
@@ -215,8 +217,6 @@ int pnp_register_driver(struct pnp_drive
 
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pnp_bus_type;
-	drv->driver.probe = pnp_device_probe;
-	drv->driver.remove = pnp_device_remove;
 
 	count = driver_register(&drv->driver);
 

