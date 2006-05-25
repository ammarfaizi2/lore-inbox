Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWEYHVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWEYHVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWEYHVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:21:40 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:1859 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S965066AbWEYHVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:21:39 -0400
Message-ID: <44755B2D.5050301@ra.rockwell.com>
Date: Thu, 25 May 2006 09:22:21 +0200
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] usb gadget: update inode.c to support full speed only
 udc
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 05/25/2006 02:22:22 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 05/25/2006 02:22:23 AM,
	Serialize complete at 05/25/2006 02:22:23 AM
Content-Type: multipart/mixed;
 boundary="------------030405000804090304050804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405000804090304050804
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

Add support for full speed only udc controllers.

This patch is against 2.6.16.13.

Please apply.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---




--------------030405000804090304050804
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="inode.c.patch"
Content-Disposition: inline;
 filename="inode.c.patch"

--- orig/drivers/usb/gadget/inode.c	2006-05-15 10:21:34.000000000 +0000
+++ new_gadget/drivers/usb/gadget/inode.c	2006-05-15 11:04:40.000000000 +0000
@@ -1758,7 +1758,11 @@ static int gadgetfs_probe (struct usb_ga
 }
 
 static struct usb_gadget_driver probe_driver = {
+#ifdef	HIGHSPEED
 	.speed		= USB_SPEED_HIGH,
+#else
+	.speed		= USB_SPEED_FULL,
+#endif
 	.bind		= gadgetfs_probe,
 	.unbind		= gadgetfs_nop,
 	.setup		= (void *)gadgetfs_nop,






--------------030405000804090304050804--
