Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUI2GzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUI2GzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUI2GyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:54:25 -0400
Received: from ns.schottelius.org ([213.146.113.242]:16515 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S268236AbUI2GuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:50:12 -0400
Date: Wed, 29 Sep 2004 08:54:01 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>,
       Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices - try 2.
Message-ID: <20040929065401.GA3473@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Martin Waitz <tali@admingilde.org>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost> <1096306153.1729.2.camel@localhost.localdomain> <Pine.LNX.4.61.0409281316191.22088@jjulnx.backbone.dif.dk> <Pine.LNX.4.61.0409282118340.2729@dragon.hygekrogen.localhost> <20040928205444.GB1496@schottelius.org> <1096410283.21799.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1096410283.21799.43.camel@localhost.localdomain>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for enlightening [1] me!

Nico

P.S.: [1] enlightenment.org is still alive, just wanted to note that..

Stephen Hemminger [Tue, Sep 28, 2004 at 03:24:43PM -0700]:
> On Tue, 2004-09-28 at 22:54 +0200, Nico Schottelius wrote:
> > Hello!
> >=20
> > I am just a bit tired and a bit confused, but
> >=20
> > Jesper Juhl [Tue, Sep 28, 2004 at 09:23:25PM +0200]:
> > > > > Using snprintf in this way is kind of silly. since buffer is PAGE=
SIZE.
> > > > > The most concise format of this would be:
> > > > > 	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));
> >=20
> > wouldn't this potentially open a security hole / buffer overflow?
>=20
> buf comes from fs/sysfs/file.c:fill_read_buf and is PAGESIZE.
> Since netif_carrier_ok() returns 0 or 1, don't see how that could ever
> turn into a security hole.
> =09
>=20
> > I am currently not really seeing where buf is passed from and what
> > dec_fmt is, but am I totally wrong?
>=20
> dec_fmt is in net-sysfs.c and is defined as "%d\n" to avoid
> repetition of same string literal.
>=20
>=20

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQVpcBrOTBMvCUbrlAQIM6xAAhVYHBAZbrDjA7FqrGBoKJ+PiXCpun/uc
bzoa+SAvE6cuXBnto0ItVmSG402RoYrmxV08GvTbwGvU1tkpa6Sw6uEQDAu2+vM6
U2TzszPI5JiIZ6CmzrK6QldP0V27eafq0rZiIOnSf3B94+ti+PtMHqXLtkuaAb3J
p9iiHEGjjVO5apCAgR3/kIP2vackMYeBi0LGol4Fc3hC7xvjdH2bmph9EpxiUr20
n7YWmZ2nFu7aBHCpFuq/8aBR4S0Y1326xM2eEqS5UXmQfB6l/MPHq0WSfUfPB08O
oubHw2Gu7xskFDgtUy4fSLAypMKdXMl+VKA6lI8hkjG0ZZAMqBGqQ2/3q+PCsDQg
gh92NxHYSvlll6D052W7uKfwmtfDBXQK/hpjGrLYtMQURI+xC9nuiAK7ESDD70DG
BK6pqjKwfW3qrCFDnDBlPQ4reqSKPfDzg9u4ffo7HGAq65wjmLTALZq0JNmTJVCk
07WUFLsz87OnchrzScKALHgUOuYkvnEN3GBPmWzP8EkeyqRgb2gUFox5ZR4gWFOc
7EM4WAOsVrd+WPSJPm/uw45txrkPq2ikFpRPO1eDWxSrjHYDGWBW7jSYeYwN8Q6c
Q65DxqntMXSm0rqpZzYe51s1LHk6q8Pz+5fWxLy6Ms11NT1y38zQS1n/mqYl1I6w
nYQ9VfPoLtw=
=WdD1
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
