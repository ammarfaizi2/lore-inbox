Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbUJaRSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUJaRSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 12:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUJaRSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 12:18:34 -0500
Received: from mail.murom.net ([213.177.124.17]:7883 "EHLO mail.murom.net")
	by vger.kernel.org with ESMTP id S261393AbUJaRS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 12:18:29 -0500
Date: Sun, 31 Oct 2004 20:18:14 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.28-pre3 tty/ldisc fixes
Message-ID: <20041031171814.GA4013@sirius.home>
References: <20041028183551.GC3253@sirius.home> <Pine.LNX.4.44.0410291426240.13340-200000@dhcp83-105.boston.redhat.com> <20041030191955.GA2310@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20041030191955.GA2310@sirius.home>
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.629,
	required 6, autolearn=not spam, AWL 2.27, BAYES_00 -4.90)
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 30, 2004 at 11:19:55PM +0400, Sergey Vlasov wrote:
> On Fri, Oct 29, 2004 at 02:29:43PM -0400, Jason Baron wrote:
> > Here's an updated 2.4 tty patch. I'm not sure if the updated patch woul=
d=20
> > fix the above issue, but it has a lot of changes so it might be worth a=
=20
> > try.
>=20
> This looks better - at least the system boots without hang or oops ;)

However, this seems to break SieFS 0.2
(http://mirror01.users.i.com.ua/~dmitry_z/siefs/; 0.4 is broken with
Siemens x55 models): even "slink i" does not work:

ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {c_iflags=3D0x5, c_oflags=3D0, c_cf=
lags=3D0xebe, c_lflags=3D0, c_line=3D0, c_cc[VMIN]=3D0, c_cc[VTIME]=3D2, c_=
cc=3D"\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00"}) =3D 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {c_iflags=3D0x5, c_oflags=3D0, c_cflag=
s=3D0x1eb1, c_lflags=3D0, c_line=3D0, c_cc[VMIN]=3D0, c_cc[VTIME]=3D2, c_cc=
=3D"\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00"}) =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {c_iflags=3D0x5, c_oflags=3D0, c_cf=
lags=3D0x1eb1, c_lflags=3D0, c_line=3D0, c_cc[VMIN]=3D0, c_cc[VTIME]=3D2, c=
_cc=3D"\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00"}) =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {c_iflags=3D0x5, c_oflags=3D0, c_cf=
lags=3D0x1eb1, c_lflags=3D0, c_line=3D0, c_cc[VMIN]=3D0, c_cc[VTIME]=3D2, c=
_cc=3D"\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00"}) =3D 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {c_iflags=3D0x5, c_oflags=3D0, c_cflag=
s=3D0x1eb1, c_lflags=3D0, c_line=3D0, c_cc[VMIN]=3D0, c_cc[VTIME]=3D3, c_cc=
=3D"\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00"}) =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {c_iflags=3D0x5, c_oflags=3D0, c_cf=
lags=3D0x1eb1, c_lflags=3D0, c_line=3D0, c_cc[VMIN]=3D0, c_cc[VTIME]=3D3, c=
_cc=3D"\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00"}) =3D 0
write(3, "\2\1\3\24", 4)  =3D 4
read(3, "", 1)            =3D 0

There is no responce to the packet.  Without the tty patch SieFS
works; 2.6.9 (where locking fixes are already applied) also works.

The bug might really be in the pl2303 driver (the 2.4 version is
missing some patches which are in 2.6.x).  Will try to investigate
this further...

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBhR5WW82GfkQfsqIRAg1AAJ0Wm+kPsYhCs8p3c6Oib72K5a9IDwCfTJ4t
FGYwsPGHZnWCgRQlXr3hVQ8=
=fPef
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
