Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbUKEBmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUKEBmC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUKEAvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:51:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:38622 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262523AbUKEAsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:48:51 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <109961570456@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <1099615705170@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.4, 2004/11/04 10:28:20-08:00, tj@home-tj.org

[PATCH] driver-model: comment fix in bus.c

 df_01_driver_attach_comment_fix.patch

bus_match() was renamed to driver_probe_device() but the comment for
device_attach() wasn't updated.  This patch updates it.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-04 16:30:54 -08:00
+++ b/drivers/base/bus.c	2004-11-04 16:30:54 -08:00
@@ -325,10 +325,10 @@
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

