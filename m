Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266269AbSKGBow>; Wed, 6 Nov 2002 20:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbSKGBow>; Wed, 6 Nov 2002 20:44:52 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:34948 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266269AbSKGBow>;
	Wed, 6 Nov 2002 20:44:52 -0500
Date: Wed, 6 Nov 2002 20:54:45 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Improved Debug Message Placement - 2.5.46 (2/6)
Message-ID: <20021106205445.GM316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pointed out by Joe Perches.


diff -ur --new-file a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Wed Oct 30 17:16:54 2002
+++ b/drivers/pnp/driver.c	Wed Oct 30 17:28:19 2002
@@ -153,8 +153,6 @@
 	int count;
 	struct list_head *pos;
 
-	pnp_dbg("the driver '%s' has been registered", drv->name);
-
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pnp_bus_type;
 	drv->driver.probe = pnp_device_probe;
@@ -169,13 +167,14 @@
 			count++;
 		}
 	}
+	pnp_dbg("the driver '%s' has been registered", drv->name);
 	return count;
 }
 
 void pnp_unregister_driver(struct pnp_driver *drv)
 {
-	pnp_dbg("the driver '%s' has been unregistered", drv->name);
 	driver_unregister(&drv->driver);
+	pnp_dbg("the driver '%s' has been unregistered", drv->name);
 }
 
 /**
