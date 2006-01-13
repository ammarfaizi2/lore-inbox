Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422866AbWAMUCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422866AbWAMUCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422876AbWAMUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:02:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:42132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422871AbWAMTu3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:29 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add zorro_bus_type probe and remove methods
In-Reply-To: <11371818123046@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <11371818121788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add zorro_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b6a01e9bda69aaf22f3a23bafc91c0fb51420a7a
tree f98effb1d882d8d2648a989e3a6bd72d853bdb16
parent ac33bc3d54936d364c1f979e50f43dfa3f9a13c1
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:43:43 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:10 -0800

 drivers/zorro/zorro-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index ccba227..fcbee74 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -77,7 +77,6 @@ int zorro_register_driver(struct zorro_d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &zorro_bus_type;
-	drv->driver.probe = zorro_device_probe;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
@@ -132,7 +131,8 @@ static int zorro_bus_match(struct device
 
 struct bus_type zorro_bus_type = {
 	.name	= "zorro",
-	.match	= zorro_bus_match
+	.match	= zorro_bus_match,
+	.probe	= zorro_device_probe,
 };
 
 

