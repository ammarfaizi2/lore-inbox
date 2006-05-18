Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWERVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWERVwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWERVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:52:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:18607 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932156AbWERVwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:52:16 -0400
X-Authenticated: #1424900
Message-ID: <446CEC8B.5070809@gmx.de>
Date: Thu, 18 May 2006 23:52:11 +0200
From: Eduard Warkentin <eduard.warkentin@gmx.de>
User-Agent: Thunderbird 1.5 (X11/20060113)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Phil Chang <pchang23@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] added support for ASIX 88178 chipset USB Gigabit Ethernet
 adaptor
References: <e4gbbs$d37$1@sea.gmane.org> <20060517235902.GA8060@kroah.com>
In-Reply-To: <20060517235902.GA8060@kroah.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=32217597
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Hi Greg!

First of all, i hope you arent angry about having me sent this reply
as CC to the current maintainer and to the mailing list. If so, I
apologize, and it wont happen in future.

> Hm, your tabs and spaces are messed up :(
I reviewed the original file again, and the lines just above mine
indeed have spare leading whitespaces. Shall  I include changing them
in my patch? I really dont know wether it just will ok, or will make
it harder to identify what i actually did in patch.  I have to excuse
myself for asking about those details, but this is my very first
kernel patch ever. (For now, I left the whitespaces as I found them in
the source file. Please, clue me on how to deal with those, wehen i
encounter them again.)

So, here's my corrected patch again:

FROM: Eduard Warkentin <eduard.warkentin@gmx.de>

Added support for detetcion an dworking with a ASIX 88178 based
USB-Gigabit
adaptor. With the patch, it is detected and handled correctly by the asix
module.

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

iD8DBQFEbOyK0HvYPTIhdZcRA+rAAKCAChGPNe3lCaPcZUNkJujYJmmUZgCgq6tc
bTotPl6JBMbch/DpS9O0DEQ=
=1BCn
-----END PGP SIGNATURE-----

