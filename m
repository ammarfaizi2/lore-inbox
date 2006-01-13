Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422887AbWAMTwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887AbWAMTwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbWAMTwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:52:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:54932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422885AbWAMTud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:33 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add of_platform_bus_type probe and remove methods
In-Reply-To: <113718180990@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:09 -0800
Message-Id: <1137181809252@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add of_platform_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 79f9fb8886d901fd549793a4ad632ece51c68405
tree f51fb4fd185efde0cf2c82245ee1f9a67848d062
parent c6a09196bab3bc9e515b713193d61e3e87c720f7
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:36:16 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:06 -0800

 arch/powerpc/kernel/of_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 7065e40..22d83d4 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -132,6 +132,8 @@ static int of_device_resume(struct devic
 struct bus_type of_platform_bus_type = {
        .name	= "of_platform",
        .match	= of_platform_bus_match,
+       .probe	= of_device_probe,
+       .remove	= of_device_remove,
        .suspend	= of_device_suspend,
        .resume	= of_device_resume,
 };
@@ -150,8 +152,6 @@ int of_register_driver(struct of_platfor
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &of_platform_bus_type;
-	drv->driver.probe = of_device_probe;
-	drv->driver.remove = of_device_remove;
 
 	/* register with core */
 	count = driver_register(&drv->driver);

