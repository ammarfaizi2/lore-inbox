Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422879AbWAMT6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422879AbWAMT6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422870AbWAMT57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:48788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422879AbWAMTub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:31 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add dio_bus_type probe and remove methods
In-Reply-To: <11371818101175@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818101170@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add dio_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5b34bf88779fa965a134b92ab61688e0d1ddfe1d
tree bf3387d7cc4d8880894d8884baf9f3e318e1e26e
parent 2f53a80fc0f6287d4bd6cc2422cd095c90f30410
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:37:18 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:07 -0800

 drivers/dio/dio-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
index ffe6f44..ca8e69d 100644
--- a/drivers/dio/dio-driver.c
+++ b/drivers/dio/dio-driver.c
@@ -83,7 +83,6 @@ int dio_register_driver(struct dio_drive
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &dio_bus_type;
-	drv->driver.probe = dio_device_probe;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
@@ -145,7 +144,8 @@ static int dio_bus_match(struct device *
 
 struct bus_type dio_bus_type = {
 	.name	= "dio",
-	.match	= dio_bus_match
+	.match	= dio_bus_match,
+	.probe	= dio_device_probe,
 };
 
 

