Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbTBCPNP>; Mon, 3 Feb 2003 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBCPNP>; Mon, 3 Feb 2003 10:13:15 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:57583 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266733AbTBCPNN>; Mon, 3 Feb 2003 10:13:13 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044285222.2396.14.camel@gregs>
References: <1044285222.2396.14.camel@gregs>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5JFJ+6QSCaXDKjyKdgbz"
Organization: Red Hat, Inc.
Message-Id: <1044285758.2527.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Feb 2003 16:22:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5JFJ+6QSCaXDKjyKdgbz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-03 at 16:13, Grzegorz Jaskiewicz wrote:
> few days ago i started to port driver for our hardware in company from
> windows to linux. It is simple ISA card, which gives me interrupt each
> 8ms. So i can check it state and latch some sort of watchdog on it -
> saying that i am still running (just for security, if system hangs card
> is blocking all inputs/outputs).=20

forgot to tell you that

    ttimer.expires =3D jiffies+(HZ/150.0);


you CANNOT use floating point in kernel mode! And that for HZ=3D100 this
gives you a timer that expires immediatly.


and that
        printk("<1>%d\n", TimerIntrpt);
you shouldn't use <1> in printk strings ever.


--=-5JFJ+6QSCaXDKjyKdgbz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+Pok+xULwo51rQBIRAqFlAJwINg3WsQeUd/W4lInweWL7+AqxDACbB6PL
GKJGOB9e5eU8MqQapENp140=
=RydD
-----END PGP SIGNATURE-----

--=-5JFJ+6QSCaXDKjyKdgbz--
