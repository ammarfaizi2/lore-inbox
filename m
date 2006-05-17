Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWEQXaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWEQXaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWEQXaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:30:11 -0400
Received: from main.gmane.org ([80.91.229.2]:64653 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750714AbWEQXaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:30:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Eduard Warkentin <eduard.warkentin@gmx.de>
Subject: [PATCH] added support for ASIX 88178 chipset USB Gigabit Ethernet adaptor
Date: Thu, 18 May 2006 01:24:45 +0200
Message-ID: <e4gbbs$d37$1@sea.gmane.org>
Reply-To: eduard.warkentin@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 57-210-103-86.dynamic.dsl.tng.de
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FROM: Eduard Warkentin <eduard.warkentin@gmx.de>

Added support for detetcion an dworking with a ASIX 88178 based USB-Gigabit
adaptor. With the patch, it is detected and handled correctly by the asix
module.

---<snip>---
--- ./drivers/usb/net/asix.c.orig 2006-03-20 06:53:29.000000000 +0100
+++ ./drivers/usb/net/asix.c  2006-05-18 01:18:52.000000000 +0200
@@ -913,6 +913,10 @@ static const struct usb_device_id  produc
         USB_DEVICE (0x0b95, 0x7720),
         .driver_info = (unsigned long) &ax88772_info,
 }, {
+  // ASIX AX88178 10/100/1000
+  USB_DEVICE (0x0b95, 0x1780),
+  .driver_info = (unsigned long) &ax88772_info,
+}, {
  // Linksys USB200M Rev 2
  USB_DEVICE (0x13b1, 0x0018),
  .driver_info = (unsigned long) &ax88772_info,
---<snap>---

Signed-off-by: Eduard Warkentin <eduard.warkentin@gmx.de>

