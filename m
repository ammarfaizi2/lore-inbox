Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbUKDHVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUKDHVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUKDHOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:14:34 -0500
Received: from [211.58.254.17] ([211.58.254.17]:53154 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262124AbUKDHCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:02:19 -0500
Date: Thu, 4 Nov 2004 16:02:16 +0900
From: Tejun Heo <tj@home-tj.org>
To: mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 1/5] driver-model: comment fix in bus.c
Message-ID: <20041104070216.GB25567@home-tj.org>
References: <20041104070134.GA25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070134.GA25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 df_01_driver_attach_comment_fix.patch

 bus_match() was renamed to driver_probe_device() but the comment for
device_attach() wasn't updated.  This patch updates it.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/bus.c
===================================================================
--- linux-export.orig/drivers/base/bus.c	2004-11-04 11:04:13.000000000 +0900
+++ linux-export/drivers/base/bus.c	2004-11-04 11:04:13.000000000 +0900
@@ -335,10 +335,10 @@ int device_attach(struct device * dev)
  *	driver_attach - try to bind driver to devices.
  *	@drv:	driver.
  *
- *	Walk the list of devices that the bus has on it and try to match
- *	the driver with each one.
- *	If bus_match() returns 0 and the @dev->driver is set, we've found
- *	a compatible pair.
+ *	Walk the list of devices that the bus has on it and try to
+ *	match the driver with each one.  If driver_probe_device()
+ *	returns 0 and the @dev->driver is set, we've found a
+ *	compatible pair.
  *
  *	Note that we ignore the -ENODEV error from driver_probe_device(),
  *	since it's perfectly valid for a driver not to bind to any devices.
