Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWESVcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWESVcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWESVcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 17:32:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:56001 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964851AbWESVcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 17:32:06 -0400
Date: Fri, 19 May 2006 23:32:05 +0200 (MEST)
From: eduard.warkentin@gmx.de
To: linux-kernel@vger.kernel.org
Cc: pchang23@sbcglobal.net
MIME-Version: 1.0
Subject: [PATCH] added support for ASIX 88178 chipset USB Gigabit Ethernet adaptor
X-Priority: 3 (Normal)
X-Authenticated: #1424900
Message-ID: <23747.1148074325@www018.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FROM: Eduard Warkentin <eduard.warkentin@gmx.de>

Added support for detetcion an dworking with a ASIX 88178 based
USB-Gigabit
adaptor. With the patch, it is detected and handled correctly by the asix
module.

Signed-off-by: Eduard Warkentin <eduard.warkentin@gmx.de>

--- drivers/usb/net/asix.c.orig 2006-03-20 06:53:29.000000000 +0100
+++ drivers/usb/net/asix.c      2006-05-19 23:23:00.000000000 +0200
@@ -913,6 +913,10 @@ static const struct usb_device_id  produc
         USB_DEVICE (0x0b95, 0x7720),
         .driver_info = (unsigned long) &ax88772_info,
 }, {
+        // ASIX AX88178 10/100/1000
+        USB_DEVICE (0x0b95, 0x1780),
+        .driver_info = (unsigned long) &ax88772_info,
+}, {
        // Linksys USB200M Rev 2
        USB_DEVICE (0x13b1, 0x0018),
        .driver_info = (unsigned long) &ax88772_info,

-- 
Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
