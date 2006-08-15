Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWHOAk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWHOAk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWHOAk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:40:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932764AbWHOAkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:40:55 -0400
Date: Tue, 15 Aug 2006 02:40:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [-mm patch] make drivers/usb/core/driver.c:usb_device_match() static
Message-ID: <20060815004054.GD3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usb_device_match() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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


