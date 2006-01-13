Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWAMT7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWAMT7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWAMT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:52884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422882AbWAMTud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:33 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add pcmcia_bus_type probe and remove methods
In-Reply-To: <11371818103208@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:10 -0800
Message-Id: <11371818103670@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add pcmcia_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1d0baa3a1c836f0403b318d549fd49ebc73ee631
tree 22a59c7e5840c035f79703419bdb25fde180ce2a
parent 4d0b653cdfde193944784c01fa3359b0a444dcf1
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:40:58 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:08 -0800

 drivers/pcmcia/ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 621ec45..0a424a4 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -311,8 +311,6 @@ int pcmcia_register_driver(struct pcmcia
 	/* initialize common fields */
 	driver->drv.bus = &pcmcia_bus_type;
 	driver->drv.owner = driver->owner;
-	driver->drv.probe = pcmcia_device_probe;
-	driver->drv.remove = pcmcia_device_remove;
 
 	return driver_register(&driver->drv);
 }
@@ -1200,6 +1198,8 @@ struct bus_type pcmcia_bus_type = {
 	.uevent = pcmcia_bus_uevent,
 	.match = pcmcia_bus_match,
 	.dev_attrs = pcmcia_dev_attrs,
+	.probe = pcmcia_device_probe,
+	.remove = pcmcia_device_remove,
 	.suspend = pcmcia_dev_suspend,
 	.resume = pcmcia_dev_resume,
 };

