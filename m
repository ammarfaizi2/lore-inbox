Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSJWTYi>; Wed, 23 Oct 2002 15:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSJWTYi>; Wed, 23 Oct 2002 15:24:38 -0400
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:43150 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265168AbSJWTYh>;
	Wed, 23 Oct 2002 15:24:37 -0400
Date: Wed, 23 Oct 2002 15:33:42 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] update PnP layer to driver model changes - 2.5.44 (4/4)
Message-ID: <20021023153342.GF10638@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the driver model changes.  This should fix a potential panic.

Please Apply,
Adam



diff -ur a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Tue Oct 22 19:04:37 2002
+++ b/drivers/pnp/driver.c	Tue Oct 22 20:59:49 2002
@@ -175,7 +175,7 @@
 void pnp_unregister_driver(struct pnp_driver *drv)
 {
 	pnp_dbg("the driver '%s' has been unregistered", drv->name);
-	remove_driver(&drv->driver);
+	driver_unregister(&drv->driver);
 }
 
 /**
