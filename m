Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267220AbSK3HBm>; Sat, 30 Nov 2002 02:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbSK3HBm>; Sat, 30 Nov 2002 02:01:42 -0500
Received: from [216.38.156.94] ([216.38.156.94]:55556 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S267220AbSK3HBl>; Sat, 30 Nov 2002 02:01:41 -0500
Subject: Re: Exaggerated swap usage
From: Dmitri <dmitri@users.sourceforge.net>
To: Javier Marcet <jmarcet@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021130064910.GD15426@jerry.marcet.dyndns.org>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org>
	<Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com>
	<3DE82A4C.B8332D8E@digeo.com>
	<Pine.LNX.4.50.0211292306000.2495-100000@montezuma.mastecende.com>
	<20021130064807.GA20277@lnuxlab.ath.cx> 
	<20021130064910.GD15426@jerry.marcet.dyndns.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-S89iEKNHbwLYpER5oM1L"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Nov 2002 23:08:53 -0800
Message-Id: <1038640133.1590.69.camel@usb.networkfab.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S89iEKNHbwLYpER5oM1L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-11-29 at 22:49, Javier Marcet wrote:
> * khromy <khromy@lnuxlab.ath.cx> [021130 07:33]:
>=20
> >BTW, I'm running 2.4.20-rc4-ac1+preempt and it seems to run good but
> >whenever I leave for a few hours or wake up in the morning mozilla is
> >swaped out.. Any idea when/how this might be fixed?
>=20
> I have the problem without leaving it a few hours, but when I do it gets
> definitely worse. Last vmstat output I quoted here showed around 256MB
> swapped. A few hours later - the computer had been sitting idle, only
> the mail server for three users was running which poses no overhead at
> all -, the entire 512MB SWAP space was used. Why, I don't know.

As I saw the thread today, I started looking at it myself, on RH's
 2.4.18-18.8.0. By now I have:

 1  0  0 432892  23828  44648 407208   0   0     0    24  780   879  95   5=
   0
         =3D=3D=3D=3D=3D=3D

However, top says:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1450 dmitri    15   0  546M 178M 16212 S     1.1 23.6  21:50 pan

I close pan, and what a change!

 3  0  0 432664  20720  44748 410260  88   0   392    20  710   925  95   4=
   1
 1  0  0  46316 197172  44760 409684  40   0    40   160  782  1177  88  12=
   0

So you probably still have some process which is eating your memory. And
once you find it, restart it:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 3994 dmitri    15   0 15044  14M  6152 S     0.9  1.9   0:00 pan

Dmitri


--=-S89iEKNHbwLYpER5oM1L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA96GQFiqqasvm69/IRArlCAJ9NFQ9Z7IsJP8UNUCkU96M4Yx3V4wCfX799
7YTZQurM78gB4XD23YGHSfA=
=Fn7m
-----END PGP SIGNATURE-----

--=-S89iEKNHbwLYpER5oM1L--

