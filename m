Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265205AbUFMQx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUFMQx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFMQx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 12:53:28 -0400
Received: from rrcs-se-24-123-177-110.biz.rr.com ([24.123.177.110]:7552 "EHLO
	nibbler") by vger.kernel.org with ESMTP id S265205AbUFMQx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 12:53:26 -0400
Subject: Badness in local_bh_enable with eciadsl driver and kernel 2.6
From: areversat <areversat@tuxfamily.org>
Reply-To: areversat@tuxfamily.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z+fRGi0iBI3dB7TBE87f"
Message-Id: <1087145610.2266.1.camel@hosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 13 Jun 2004 18:53:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z+fRGi0iBI3dB7TBE87f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
here is what most users get when running our driver (usb adsl modem
driver) with kernel 2.6.x. I'd like to know if it is a kernel bug or if
it has something to do with our driver.

Thanks

Badness in local_bh_enable at kernel/softirq.c:136
[<0212407a>] local_bh_enable+0x39/0x5c
[<42f0499e>] ppp_sync_push+0xd2/0x149 [ppp_synctty]
[<42f044aa>] ppp_sync_wakeup+0x1d/0x35 [ppp_synctty]
[<021d549f>] do_tty_hangup+0x12d/0x34c
[<021d652d>] release_dev+0x1c0/0x53f
[<0222e096>] usb_unbind_interface+0x41/0x50
[<021f4a8d>] device_release_driver+0x3c/0x46
[<0222e27e>] usb_driver_release_interface+0x2c/0x40
[<02235b32>] releaseintf+0x76/0x8f
[<021d6bc6>] tty_release+0x29/0x4e
[<02152baf>] __fput+0x3f/0xe3
[<0215189c>] filp_close+0x59/0x5f
[<02122006>] put_files_struct+0x57/0xaa
[<02122b45>] do_exit+0x211/0x390
[<02122dc0>] sys_exit_group+0x0/0xd
[<0212986b>] get_signal_to_deliver+0x34c/0x372
[<02107208>] do_signal+0x4e/0xbb
[<02160dc3>] file_ioctl+0x167/0x17b
[<02161010>] sys_ioctl+0x239/0x243
[<0210729d>] do_notify_resume+0x28/0x37
--=20
Pour trouver les limites du possible il faut tenter l'impossible.

--=-Z+fRGi0iBI3dB7TBE87f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzIaJuGdEvqsgTTURAo+zAJ48nJKI0+DJDXtcAeB4pc17pEH60wCghpCi
4/QGvMVavmYTvqw8bAeD44M=
=83Qc
-----END PGP SIGNATURE-----

--=-Z+fRGi0iBI3dB7TBE87f--
