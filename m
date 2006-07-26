Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWGZKnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWGZKnZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWGZKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:43:25 -0400
Received: from [210.76.114.181] ([210.76.114.181]:19382 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932523AbWGZKnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:43:24 -0400
Message-ID: <44C74742.6020701@ccoss.com.cn>
Date: Wed, 26 Jul 2006 18:43:14 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: [PATCH 3/3] usbhid: Driver for microsoft natural ergonomic keyboard
 4000
Content-Type: multipart/mixed;
 boundary="------------010900090202030804050903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010900090202030804050903
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

    This driver use "HID device simple driver interface", you must install that 
patch first. This new version get some improvements.

    The patch include change in Kconfig of driver.

    I am sorry for sendding patches in the attachment, beacause of my mail client always break TAB into some spaces.

    Good luck

-Liyu

--------------010900090202030804050903
Content-Type: text/x-patch;
 name="msnek4k-keyboard-driver-Kconfig.kernel-2.6.17.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msnek4k-keyboard-driver-Kconfig.kernel-2.6.17.7.patch"


    This patch include change of Kconfig in this driver.

    Signed-off-by:  Yu Li <liyu@ccoss.com.cn>
diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/Kconfig linux-2.6.17.6/drivers/usb/input/Kconfig
--- linux-2.6.17.6/drivers/usb/input.orig/Kconfig	2006-07-16 03:00:43.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/Kconfig	2006-07-24 14:04:56.000000000 +0800
@@ -326,3 +326,11 @@ config USB_APPLETOUCH
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
+
+config HID_MSNEK4K
+	tristate "Microsoft Natural Ergonomic Keyboard 4000 Driver"
+	depends on USB && USB_HID
+	---help---
+	Microsoft Natural Ergonomic Keyboard 4000 driver. These extend keys
+	may not work without change user space configration, e.g, XKB conf-
+	iguration in X. 


--------------010900090202030804050903--
