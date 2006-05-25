Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWEYHWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWEYHWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWEYHWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:22:01 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:32067 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S965070AbWEYHVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:21:47 -0400
Message-ID: <44755B35.1040809@ra.rockwell.com>
Date: Thu, 25 May 2006 09:22:29 +0200
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] usb gadget: don't build small version if usbgadgetfs
 is selected
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 05/25/2006 02:22:30 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 05/25/2006 02:22:32 AM,
	Serialize complete at 05/25/2006 02:22:32 AM
Content-Type: multipart/mixed;
 boundary="------------000505030407080002000404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000505030407080002000404
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

usbgadgetfs allows userspace to open as many enpoints as it
needs. It's not good to limit number of endpoints by the udc
driver in this case.

This patch is against 2.6.16.13.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---




--------------000505030407080002000404
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="Kconfig.patch"
Content-Disposition: inline;
 filename="Kconfig.patch"

--- orig/drivers/usb/gadget/Kconfig	2006-05-15 10:20:49.000000000 +0000
+++ new_gadget/drivers/usb/gadget/Kconfig	2006-05-15 12:02:58.000000000 +0000
@@ -117,6 +117,7 @@ config USB_PXA2XX_SMALL
 	depends on USB_GADGET_PXA2XX
 	bool
 	default n if USB_ETH_RNDIS
+	default n if USB_GADGETFS
 	default y if USB_ZERO
 	default y if USB_ETH
 	default y if USB_G_SERIAL





--------------000505030407080002000404--
