Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUEOBO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUEOBO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUENXMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:12:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:56028 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263229AbUENXIK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:10 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <1084576042851@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <10845760424123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.18, 2004/05/02 20:30:19-07:00, kenn@linux.ie

[PATCH] Re: Platform device matching

On Mon, Apr 26, 2004 at 12:27:33AM +0100, Russell King wrote:
> So, this comment needs updating:
>
>  *      So, extract the <name> from the device, and compare it against
>  *      the name of the driver. Return whether they match or not.

Want a patch?


 drivers/base/platform.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Fri May 14 15:58:28 2004
+++ b/drivers/base/platform.c	Fri May 14 15:58:28 2004
@@ -57,8 +57,9 @@
  *	type of device, like "pci" or "floppy", and <instance> is the 
  *	enumerated instance of the device, like '0' or '42'.
  *	Driver IDs are simply "<name>". 
- *	So, extract the <name> from the device, and compare it against 
- *	the name of the driver. Return whether they match or not.
+ *	So, extract the <name> from the platform_device structure, 
+ *	and compare it against the name of the driver. Return whether 
+ *	they match or not.
  */
 
 static int platform_match(struct device * dev, struct device_driver * drv)

