Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVCKXYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVCKXYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCKXXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:23:15 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:35561 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261803AbVCKXN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:13:58 -0500
Subject: Re: AGP bogosities
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1110581163l.5796l.0l@werewolf.able.es>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <1110579068l.8904l.0l@werewolf.able.es> <20050311221838.GG4185@redhat.com>
	 <1110581163l.5796l.0l@werewolf.able.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yOiaFbdp9iqXhV6TflAT"
Date: Sat, 12 Mar 2005 01:16:31 +0200
Message-Id: <1110582991.8513.13.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yOiaFbdp9iqXhV6TflAT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-11 at 22:46 +0000, J.A. Magallon wrote:
> On 03.11, Dave Jones wrote:
> > On Fri, Mar 11, 2005 at 10:11:08PM +0000, J.A. Magallon wrote:
> >  >=20
> >  > On 03.11, Paul Mackerras wrote:
> >  > > Linus,
> >  > >=20
> >  > ...
> >  > >=20
> >  > > Oh, and by the way, I have 3D working relatively well on my G5 wit=
h a
> >  > > 64-bit kernel (and 32-bit X server and clients), which is why I ca=
re
> >  > > about AGP 3.0 support. :)
> >  > >=20
> >  >=20
> >  > I think it is not a G5 only problem. I have a x8 card, a x8 slot, bu=
t
> >  > agpgart keeps saying this:
> >  >=20
> >  > Mar 11 23:00:28 werewolf dm: Display manager startup succeeded
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant=
 device at 0000:00:00.0.
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode =
0xa. Fixed.
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags=
 (2) in AGP3 mode. Fixed.
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0=
000:00:00.0 into 4x mode
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0=
000:01:00.0 into 4x mode
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compliant=
 device at 0000:00:00.0.
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in mode =
0xa. Fixed.
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 flags=
 (2) in AGP3 mode. Fixed.
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0=
000:00:00.0 into 4x mode
> >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device at 0=
000:01:00.0 into 4x mode
> >  >=20
> >  > The nvidia driver (brand new 1.0-7167, now works with stock -mm) tel=
ls me
> >  > it is in x8 mode, but i suspect it lies....
> >  >=20
> >  > Will try your patch right now.
> >=20
>=20
> Looks fine, now I got:
>=20
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
>=20
> werewolf:~> lspci
> 00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub=
 (rev 02)
> 00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller =
(rev 02)
> ...
> 01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 52=
00] (rev a1)
>=20
> BTW, I had to patch the nVidia driver. It just tries up to x4 AGP...
>=20

New and old one works fine with Paul's patch:

--old--
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: X tried to set rate=3Dx12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
-------

(ok, so old driver is a bit dodgy)

--new--
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
-------


--=20
Martin Schlemmer


--=-yOiaFbdp9iqXhV6TflAT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCMibPqburzKaJYLYRAqgfAJ4xImhDkNAgeJgND/xRF+lkMHDDiwCfaXtQ
MRY+D8315YYXgB0+c8A3Css=
=eOvC
-----END PGP SIGNATURE-----

--=-yOiaFbdp9iqXhV6TflAT--

