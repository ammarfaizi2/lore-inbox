Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTDGWY6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTDGWY6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:24:58 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:3284 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S263713AbTDGWYz (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:24:55 -0400
Date: Tue, 8 Apr 2003 00:36:25 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] : Linux 2.5.67
Message-Id: <20030408003625.51a788a0.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws3 (GTK+ 1.2.10; Linux 2.4.21-pre7)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.UyxXkU92guAL:?"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.UyxXkU92guAL:?
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2003 10:53:43 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> v2.5.67

Hello,

Below is the backtrace of a USB oops which has has been freezing my system
since around 2.5.65 and which I've only just spotted. I have a monitor with
built-in USB hub. When the monitor is turned off, the USB hub disconnects from
its upstream hub and when the monitor is turned on again, the hub reconnects.
I can't tell if the oops happens on disconnect or reconnect though. I don't
have a serial cable atm, but I hope the information is sufficient. If not,
please let me know. Or you can send me a patch to try out.

Regards,
-Udo.

EIP is at hub_irq + 0xaa/0x120

Trace:
usb_hcd_giveback_urb + 0x25/0x40
uhci_finish_completion + 0x73/0xc0
usb_hcd_irq + 0x2d/0x60
handle_IRQ_event + 0x38/0x60
do_IRQ + 0x97/0x120
common_interrupt + 0x18/0x20

Code: 0b 80 bc 00 00 00 8b 00 c7 04 24 4b 87 3d c0 89 44 24 04 e8

--=.UyxXkU92guAL:?
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+kf1snhRzXSM7nSkRAj+lAJ4pZ2JItT9BIomvnC+Xtj1cLpuhogCeKS62
1pZeZUideO63zuxY6/zMUCQ=
=31Vn
-----END PGP SIGNATURE-----

--=.UyxXkU92guAL:?--
