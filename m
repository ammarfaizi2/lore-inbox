Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268827AbTGTWvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268909AbTGTWvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:51:21 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:55174 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S268898AbTGTWun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:50:43 -0400
Date: Mon, 21 Jul 2003 01:05:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dbrownell@users.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Support sharp zaurus C-750
Message-ID: <20030720230530.GA2075@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for another handheld from sharp to 2.6.0-test1,
please apply:

--- clean/drivers/usb/net/usbnet.c	2003-07-14 22:12:19.000000000 +0200
+++ linux/drivers/usb/net/usbnet.c	2003-07-21 01:02:54.000000000 +0200
@@ -2769,6 +2769,15 @@
 	.bInterfaceSubClass = 0x0a,
 	.bInterfaceProtocol = 0x00,
 	.driver_info =  (unsigned long) &zaurus_slc700_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+		 | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor               = 0x04DD,
+	.idProduct              = 0x9031,
+	.bInterfaceClass        = 0x02,
+	.bInterfaceSubClass     = 0x0a,
+	.bInterfaceProtocol     = 0x00,
+	.driver_info =  (unsigned long) &zaurus_sla300_info,
 },
 #endif
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
