Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTHXM1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTHXM1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:27:05 -0400
Received: from rrba-bras-193-115.telkom-ipnet.co.za ([165.165.193.115]:49025
	"EHLO nosferatu.lan") by vger.kernel.org with ESMTP id S263440AbTHXM1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:27:00 -0400
Subject: Re: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mirko Lindner <mlindner@syskonnect.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061663721.13460.5.camel@nosferatu.lan>
References: <200308121301.43873.gallir@uib.es>
	 <1060689676.13254.172.camel@workshop.saharacpt.lan>
	 <200308121440.50395.gallir@uib.es> <1061663721.13460.5.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CSg2uWE17VJmEDkoMyrA"
Message-Id: <1061728032.13460.28.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 24 Aug 2003 14:27:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CSg2uWE17VJmEDkoMyrA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-08-23 at 20:35, Martin Schlemmer wrote:
> On Tue, 2003-08-12 at 14:40, Ricardo Galli wrote:
> > On Tuesday 12 August 2003 14:01, Martin Schlemmer shaped the electrons =
to=20
> > shout:
> > > On Tue, 2003-08-12 at 13:01, Ricardo Galli wrote:
> > > > I've already reported this problem to syskonnect few weeks ago (wit=
hout
> > > > success as I see).
> > > >
> > > > There is a ASIC bug in several popular motherboards (including ASUS=
 ones)
> > > > related to TX hardware checksum.
> > > >
> > > > For packets smaller that 56 bytes (payload), as UDP dns queries, th=
e asic
> > > > generates a bad checksum making the drivers unusable for "normal"
> > > > Internet usage:
> > >
> > > <snip>
> > >
> > > > The only solution is to comment out
> > > >  #define USE_SK_TX_CHECKSUM
> > > > in skge.c
> > >
> > > Known issue.
> > >
> > > Mirko will have a look as soon as he have time.
> >=20
> > Thanks, I just sent a Kconfig patch as a workaround:
> >=20
> > http://lkml.org/lkml/2003/8/12/83
> >=20
>=20
> Should work fine with version 6.16 of the driver (does so
> here at least with a P4C800):
>=20
> http://www.syskonnect.com/syskonnect/support/driver/zip/linux/sk98lin_2.6=
.0-test3_patch.gz
>=20

Hi Jeff

Any chance that we could get the sk98lin drivers updated ?  Mirko did
not respond as of yet, but the 6.16 version fixes the HW checksum issues
with most (if not all) Asus boards and maybe some others ...


Thanks,

--=20

Martin Schlemmer




--=-CSg2uWE17VJmEDkoMyrA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/SK8gqburzKaJYLYRAtfLAKCKjzk/QVQ9+W46S2NcTV1a3ilOaQCZAQsM
vwrdU7dBoQpZGOU8EoNNyV0=
=TWHO
-----END PGP SIGNATURE-----

--=-CSg2uWE17VJmEDkoMyrA--

