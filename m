Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWERWeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWERWeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWERWeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:34:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:25826 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750764AbWERWeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:34:09 -0400
X-Authenticated: #1424900
Message-ID: <446CF65C.5070501@gmx.de>
Date: Fri, 19 May 2006 00:34:04 +0200
From: Eduard Warkentin <eduard.warkentin@gmx.de>
User-Agent: Thunderbird 1.5 (X11/20060113)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Phil Chang <pchang23@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] added support for ASIX 88178 chipset USB Gigabit Ethernet
 adaptor
References: <e4gbbs$d37$1@sea.gmane.org> <20060517235902.GA8060@kroah.com> <446CEC8B.5070809@gmx.de>
In-Reply-To: <446CEC8B.5070809@gmx.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=32217597
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Hi!

On to a third try ... carefully watched the tabs this time ...

FROM: Eduard Warkentin <eduard.warkentin@gmx.de>

Added support for detetcion an dworking with a ASIX 88178 based
USB-Gigabit adaptor. With the patch, it is detected and handled
correctly by the asix module.

Signed-off-by: Eduard Warkentin <eduard.warkentin@gmx.de>

- --- ./drivers/usb/net/asix.c.orig 2006-03-20 06:53:29.000000000 +0100
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
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbPZb0HvYPTIhdZcRAwmvAKDA3mf8PBDfVEj+Wz+B5sa+q60+wwCgxge9
KQ5NIjhZRo3toc6DSW3R01o=
=WG4A
-----END PGP SIGNATURE-----

