Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSJ2Sng>; Tue, 29 Oct 2002 13:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSJ2Snf>; Tue, 29 Oct 2002 13:43:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37389 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262045AbSJ2Sn3>;
	Tue, 29 Oct 2002 13:43:29 -0500
Date: Tue, 29 Oct 2002 10:47:16 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP driver changes for 2.5.44
Message-ID: <20021029184715.GF27082@kroah.com>
References: <20021029184010.GA27082@kroah.com> <20021029184318.GB27082@kroah.com> <20021029184419.GC27082@kroah.com> <20021029184453.GD27082@kroah.com> <20021029184541.GE27082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029184541.GE27082@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.808.4.5, 2002/10/24 00:27:01-07:00, ambx1@neo.rr.com

[PATCH] update PnP layer to driver model changes - 2.5.44 (4/4)

Updates to the driver model changes.  This should fix a potential panic.


diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Tue Oct 29 10:38:28 2002
+++ b/drivers/pnp/driver.c	Tue Oct 29 10:38:28 2002
@@ -175,7 +175,7 @@
 void pnp_unregister_driver(struct pnp_driver *drv)
 {
 	pnp_dbg("the driver '%s' has been unregistered", drv->name);
-	remove_driver(&drv->driver);
+	driver_unregister(&drv->driver);
 }
 
 /**
