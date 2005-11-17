Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVKQSEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVKQSEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVKQSEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:4258 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932461AbVKQSEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:01 -0500
Date: Thu, 17 Nov 2005 09:47:53 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Antti.Andreimann@mail.ee
Subject: [patch 18/22] USB: Maxtor OneTouch button support for older drives
Message-ID: <20051117174753.GR11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-maxtor-onetouch-button-support-for-older-drives.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antti Andreimann <Antti.Andreimann@mail.ee>

This small patch adds a device ID used by older Maxtor OneTouch drives
(the ones with blue face-plate instead of the fancy silver one used in
newer models). The button on those drives works well with the current
driver.


From: Antti Andreimann <Antti.Andreimann@mail.ee>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/storage/unusual_devs.h |    5 +++++
 1 file changed, 5 insertions(+)

--- usb-2.6.orig/drivers/usb/storage/unusual_devs.h
+++ usb-2.6/drivers/usb/storage/unusual_devs.h
@@ -1003,6 +1003,11 @@ UNUSUAL_DEV( 0x0c0b, 0xa109, 0x0000, 0xf
  *
  */
 #ifdef CONFIG_USB_STORAGE_ONETOUCH
+	UNUSUAL_DEV(  0x0d49, 0x7000, 0x0000, 0x9999,
+			"Maxtor",
+			"OneTouch External Harddrive",
+			US_SC_DEVICE, US_PR_DEVICE, onetouch_connect_input,
+			0),
 	UNUSUAL_DEV(  0x0d49, 0x7010, 0x0000, 0x9999,
 			"Maxtor",
 			"OneTouch External Harddrive",

--
