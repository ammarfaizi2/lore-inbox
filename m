Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWHVTup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWHVTup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWHVTuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:50:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14093 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750953AbWHVTuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:50:44 -0400
Date: Tue, 22 Aug 2006 21:50:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [-mm patch] make drivers/usb/core/driver.c:usb_device_match() static
Message-ID: <20060822195042.GB19896@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usb_device_match() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
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


