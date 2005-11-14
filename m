Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVKNUUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVKNUUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKNUTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:19:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:46534 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932088AbVKNUTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:19 -0500
Date: Mon, 14 Nov 2005 12:05:36 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       dtor@mail.ru
Subject: [patch 05/12] USB: fix 'unused variable' warning
Message-ID: <20051114200536.GF2319@kroah.com>
References: <20051114200100.984523000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-unused-variable-warning.patch"
In-Reply-To: <20051114200456.GA2319@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor_core@ameritech.net>

USB: fix 'unused variable' warning

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/usb/core/message.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/message.c	2005-11-02 09:25:03.000000000 -0800
+++ gregkh-2.6/drivers/usb/core/message.c	2005-11-02 10:28:05.000000000 -0800
@@ -1457,12 +1457,11 @@
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
