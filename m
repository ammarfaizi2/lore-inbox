Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWIDREu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWIDREu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWIDREs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:04:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964939AbWIDRE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:04:27 -0400
Date: Mon, 4 Sep 2006 19:04:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [-mm patch] make drivers/usb/core/driver.c:usb_device_match() static
Message-ID: <20060904170423.GV4416@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usb_device_match() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Aug 2006
- 15 Aug 2006

--- linux-2.6.18-rc1-mm2-full/drivers/usb/core/driver.c.old	2006-07-14 23:29:20.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/usb/core/driver.c	2006-07-14 23:29:51.000000000 +0200
@@ -471,7 +471,7 @@
 }
 EXPORT_SYMBOL_GPL_FUTURE(usb_match_id);
 
-int usb_device_match(struct device *dev, struct device_driver *drv)
+static int usb_device_match(struct device *dev, struct device_driver *drv)
 {
 	/* devices and interfaces are handled separately */
 	if (is_usb_device(dev)) {


