Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTEEUpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTEEUpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:45:15 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:37382 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261336AbTEEUpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:45:11 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Frank Davis <fdavis@si.rr.com>, maxk@qualcomm.com
Subject: Re: [PATCH] 2.5.69 : drivers/bluetooth/hci_usb.c
Date: Mon, 5 May 2003 22:57:07 +0200
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.44.0305051642060.18736-100000@master>
In-Reply-To: <Pine.LNX.4.44.0305051642060.18736-100000@master>
Cc: fdavis@si.rr.com, linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305052257.19652.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 22:47, Frank Davis wrote:
> Hello,
>
> The following patch addresses the compile error below (I haven't seent
> this previously reported.). I suspect there's a cleaner patch. Please
> review. Thanks.
>
> Regards,
> Frank
>
> drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
> drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use in
> this function) drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier
> is reported only once drivers/bluetooth/hci_usb.c:461: for each function it
> appears in.) make[2]: *** [drivers/bluetooth/hci_usb.o] Error 1
> make[1]: *** [drivers/bluetooth] Error 2
> make: *** [drivers] Error 2
>
> --- linux/drivers/bluetooth/hci_usb.c.old	2003-05-05 16:38:58.000000000
> -0400 +++ linux/drivers/bluetooth/hci_usb.c	2003-05-05 16:40:35.000000000
> -0400 @@ -68,6 +68,8 @@
>  #define USB_ZERO_PACKET 0
>  #endif
>
> +#define USB_ZERO_PACKET 0
> +
>  static struct usb_driver hci_usb_driver;
>
>  static struct usb_device_id bluetooth_ids[] = {
>

> [snip] I suspect there's a cleaner patch. [/snip]

And I suspect, this patch is wrong. :)

Maxim Krasnyansky, what has USB_ZERO_PACKET to be set to if
CONFIG_BT_USB_ZERO_PACKET is enabled? I didn't find it out.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 22:52:55 up  5:17,  2 users,  load average: 1.20, 1.25, 1.15
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ttAvoxoigfggmSgRAsZUAJ9d9XZ1FSDr2zj/ssAJOJgbyjJUvACeN43j
RMYAoDK1ZknM0GrNi4lxnwE=
=l6wk
-----END PGP SIGNATURE-----

