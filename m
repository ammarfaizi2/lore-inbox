Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTL2XMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbTL2XMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:12:31 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:31167 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265441AbTL2XMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:12:19 -0500
Subject: Re: 2.6.0 performance problems
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
	 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
	 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DSAwnr8e8ub0EzGPFivv"
Message-Id: <1072739685.25741.65.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 01:14:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DSAwnr8e8ub0EzGPFivv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-30 at 00:58, Thomas Molina wrote:
> On Mon, 29 Dec 2003, Linus Torvalds wrote:
>=20
> >=20
> >=20
> > On Mon, 29 Dec 2003, Thomas Molina wrote:
> > >
> > > I just finished a couple of comparisons between 2.4 and 2.6 which see=
m to=20
> > > confirm my impressions.  I understand that the comparison may not be=20
> > > apples to apples and my methods of testing may not be rigorous, but h=
ere=20
> > > it is.  In contrast to some recent discussions on this list, this tes=
t is=20
> > > a "real world" test at which 2.6 comes off much worse than 2.4. =20
> >=20
> > Are you sure you have DMA enabled on your laptop disk? Your 2.6.x syste=
m=20
> > times are very high - much bigger than the user times. That sounds like=
=20
> > PIO to me.
>=20
> It certainly looks like DMA is enabled.  Under 2.4 I get:
>=20
> [root@lap root]# hdparm /dev/hda
>=20
> /dev/hda:
>  multcount    =3D 16 (on)
>  IO_support   =3D  1 (32-bit)
>  unmaskirq    =3D  1 (on)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D  8 (on)
>  geometry     =3D 2584/240/63, sectors =3D 39070080, start =3D 0
>=20
>=20
> Under 2.6  I get:
>=20
> [root@lap root]# hdparm /dev/hda
>=20
> /dev/hda:
>  multcount    =3D 16 (on)
>  IO_support   =3D  1 (32-bit)
>  unmaskirq    =3D  1 (on)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D 256 (on)
>  geometry     =3D 38760/16/63, sectors =3D 39070080, start =3D 0
>=20

Increase your readahead:

 # hdparm -a 8192 /dev/hda


BTW:  As we really do get this question a _lot_ of times, why
      don't the ide layer automatically set a higher readahead
      if there is enough cache on the drive or something?


Thanks,

--=20
Martin Schlemmer

--=-DSAwnr8e8ub0EzGPFivv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/8LVlqburzKaJYLYRAg8ZAKCGUDzhBsAAw74qZk8XqEktV6++AACfdSc3
ZX/ynbzaQxQ5ew32pPS8adE=
=oFNQ
-----END PGP SIGNATURE-----

--=-DSAwnr8e8ub0EzGPFivv--

