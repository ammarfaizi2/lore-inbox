Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbTHWSfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTHWSfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 14:35:38 -0400
Received: from rrba-bras-193-115.telkom-ipnet.co.za ([165.165.193.115]:28800
	"EHLO nosferatu.lan") by vger.kernel.org with ESMTP id S263474AbTHWSfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 14:35:09 -0400
Subject: Re: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Ricardo Galli <gallir@uib.es>
Cc: Mirko Lindner <mlindner@syskonnect.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308121440.50395.gallir@uib.es>
References: <200308121301.43873.gallir@uib.es>
	 <1060689676.13254.172.camel@workshop.saharacpt.lan>
	 <200308121440.50395.gallir@uib.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xdBk2/YFGioTuLGA3F+t"
Message-Id: <1061663721.13460.5.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 20:35:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xdBk2/YFGioTuLGA3F+t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-12 at 14:40, Ricardo Galli wrote:
> On Tuesday 12 August 2003 14:01, Martin Schlemmer shaped the electrons to=
=20
> shout:
> > On Tue, 2003-08-12 at 13:01, Ricardo Galli wrote:
> > > I've already reported this problem to syskonnect few weeks ago (witho=
ut
> > > success as I see).
> > >
> > > There is a ASIC bug in several popular motherboards (including ASUS o=
nes)
> > > related to TX hardware checksum.
> > >
> > > For packets smaller that 56 bytes (payload), as UDP dns queries, the =
asic
> > > generates a bad checksum making the drivers unusable for "normal"
> > > Internet usage:
> >
> > <snip>
> >
> > > The only solution is to comment out
> > >  #define USE_SK_TX_CHECKSUM
> > > in skge.c
> >
> > Known issue.
> >
> > Mirko will have a look as soon as he have time.
>=20
> Thanks, I just sent a Kconfig patch as a workaround:
>=20
> http://lkml.org/lkml/2003/8/12/83
>=20

Should work fine with version 6.16 of the driver (does so
here at least with a P4C800):

http://www.syskonnect.com/syskonnect/support/driver/zip/linux/sk98lin_2.6.0=
-test3_patch.gz


Cheers,

--=20

Martin Schlemmer




--=-xdBk2/YFGioTuLGA3F+t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/R7PpqburzKaJYLYRAi2AAJ9fmqi6kVR/6FW1BGcvLmPGyO/h2QCcCClL
1LtrGzS3r+C01qZSawa4N2U=
=kwPd
-----END PGP SIGNATURE-----

--=-xdBk2/YFGioTuLGA3F+t--

