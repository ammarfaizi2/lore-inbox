Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVKQSEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVKQSEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVKQSEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:6306 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932464AbVKQSEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:02 -0500
Date: Thu, 17 Nov 2005 09:46:44 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dtor_core@ameritech.net
Subject: [patch 05/22] USB: fix 'unused variable' warning
Message-ID: <20051117174644.GF11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-unused-variable-warning.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor_core@ameritech.net>

USB: fix 'unused variable' warning

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/usb/core/message.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- usb-2.6.orig/drivers/usb/core/message.c
+++ usb-2.6/drivers/usb/core/message.c
@@ -1457,12 +1457,11 @@ free_interfaces:
 		 */
 		for (i = 0; i < nintf; ++i) {
 			struct usb_interface *intf = cp->interface[i];
-			struct usb_host_interface *alt = intf->cur_altsetting;
 
 			dev_dbg (&dev->dev,
 				"adding %s (config #%d, interface %d)\n",
 				intf->dev.bus_id, configuration,
-				alt->desc.bInterfaceNumber);
+				intf->cur_altsetting->desc.bInterfaceNumber);
 			ret = device_add (&intf->dev);
 			if (ret != 0) {
 				dev_err(&dev->dev,

--
