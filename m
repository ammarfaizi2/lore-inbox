Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUFNNxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUFNNxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 09:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFNNxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 09:53:51 -0400
Received: from adsl-065-082-245-074.sip.clt.bellsouth.net ([65.82.245.74]:29315
	"EHLO nibbler.futurama.net") by vger.kernel.org with ESMTP
	id S263024AbUFNNxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 09:53:32 -0400
Subject: Re: Badness in local_bh_enable with eciadsl driver and kernel 2.6
From: areversat <areversat@tuxfamily.org>
Reply-To: areversat@tuxfamily.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1087146654.2517.1.camel@doobie.pipehead.org>
References: <1087145610.2266.1.camel@hosts>
	 <1087146654.2517.1.camel@doobie.pipehead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kNZ5QshuAnhtWQBAdoBv"
Message-Id: <1087221214.2270.6.camel@hosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 14 Jun 2004 15:53:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kNZ5QshuAnhtWQBAdoBv
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Ok someone tried the patch for me (i don't have the modem here). And it
seems to work just fine : it removes the message i reported. It may need
more extensive tests but it would be nice to think about including it to
the kernel.
Thanks

Antoine
Le dim 13/06/2004 =E0 19:10, Paul Fulghum a =E9crit :
> On Sun, 2004-06-13 at 11:53, areversat wrote:
> > Hi,
> > here is what most users get when running our driver (usb adsl modem
> > driver) with kernel 2.6.x. I'd like to know if it is a kernel bug or if
> > it has something to do with our driver.
> >=20
> > Thanks
> >=20
> > Badness in local_bh_enable at kernel/softirq.c:136
> > [<0212407a>] local_bh_enable+0x39/0x5c
> > [<42f0499e>] ppp_sync_push+0xd2/0x149 [ppp_synctty]
> > [<42f044aa>] ppp_sync_wakeup+0x1d/0x35 [ppp_synctty]
> > [<021d549f>] do_tty_hangup+0x12d/0x34c
> > [<021d652d>] release_dev+0x1c0/0x53f
> > [<0222e096>] usb_unbind_interface+0x41/0x50
> > [<021f4a8d>] device_release_driver+0x3c/0x46
> > [<0222e27e>] usb_driver_release_interface+0x2c/0x40
> > [<02235b32>] releaseintf+0x76/0x8f
> > [<021d6bc6>] tty_release+0x29/0x4e
> > [<02152baf>] __fput+0x3f/0xe3
> > [<0215189c>] filp_close+0x59/0x5f
> > [<02122006>] put_files_struct+0x57/0xaa
> > [<02122b45>] do_exit+0x211/0x390
> > [<02122dc0>] sys_exit_group+0x0/0xd
> > [<0212986b>] get_signal_to_deliver+0x34c/0x372
> > [<02107208>] do_signal+0x4e/0xbb
> > [<02160dc3>] file_ioctl+0x167/0x17b
> > [<02161010>] sys_ioctl+0x239/0x243
> > [<0210729d>] do_notify_resume+0x28/0x37
>=20
> Try the attached patch.
>=20
> --
> Paul Fulghum
paulkf@microgate.com

--=-kNZ5QshuAnhtWQBAdoBv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAza3duGdEvqsgTTURAmpYAJ4x9S7zEa3lpLrAgJFPFmyRNHssTACgnpmt
xb/3fpLCQNDJ/F5Z2EQiFjQ=
=kTqs
-----END PGP SIGNATURE-----

--=-kNZ5QshuAnhtWQBAdoBv--
