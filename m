Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVCKX04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVCKX04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVCKXZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:25:21 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:58093 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261726AbVCKXVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:21:01 -0500
Subject: Re: AGP bogosities
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110583058l.5650l.0l@werewolf.able.es>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <1110579068l.8904l.0l@werewolf.able.es> <20050311221838.GG4185@redhat.com>
	 <1110581163l.5796l.0l@werewolf.able.es>
	 <1110582991.8513.13.camel@nosferatu.lan>
	 <1110583058l.5650l.0l@werewolf.able.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nGYrzWzMdmuk9rnOLOlA"
Date: Sat, 12 Mar 2005 01:23:48 +0200
Message-Id: <1110583429.8513.18.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nGYrzWzMdmuk9rnOLOlA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-11 at 23:17 +0000, J.A. Magallon wrote:
> On 03.12, Martin Schlemmer wrote:
> > On Fri, 2005-03-11 at 22:46 +0000, J.A. Magallon wrote:
> > > On 03.11, Dave Jones wrote:
> > > > On Fri, Mar 11, 2005 at 10:11:08PM +0000, J.A. Magallon wrote:
> > > >  >=20
> > > >  > On 03.11, Paul Mackerras wrote:
> > > >  > > Linus,
> > > >  > >=20
> > > >  > ...
> > > >  > >=20
> > > >  > > Oh, and by the way, I have 3D working relatively well on my G5=
 with a
> > > >  > > 64-bit kernel (and 32-bit X server and clients), which is why =
I care
> > > >  > > about AGP 3.0 support. :)
> > > >  > >=20
> > > >  >=20
> > > >  > I think it is not a G5 only problem. I have a x8 card, a x8 slot=
, but
> > > >  > agpgart keeps saying this:
> > > >  >=20
> > > >  > Mar 11 23:00:28 werewolf dm: Display manager startup succeeded
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compl=
iant device at 0000:00:00.0.
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in m=
ode 0xa. Fixed.
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 f=
lags (2) in AGP3 mode. Fixed.
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device =
at 0000:00:00.0 into 4x mode
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device =
at 0000:01:00.0 into 4x mode
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Found an AGP 3.0 compl=
iant device at 0000:00:00.0.
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: reserved bits set in m=
ode 0xa. Fixed.
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: X passes broken AGP2 f=
lags (2) in AGP3 mode. Fixed.
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device =
at 0000:00:00.0 into 4x mode
> > > >  > Mar 11 23:00:29 werewolf kernel: agpgart: Putting AGP V3 device =
at 0000:01:00.0 into 4x mode
> > > >  >=20
> > > >  > The nvidia driver (brand new 1.0-7167, now works with stock -mm)=
 tells me
> > > >  > it is in x8 mode, but i suspect it lies....
> > > >  >=20
> > > >  > Will try your patch right now.
> > > >=20
> > >=20
> > > Looks fine, now I got:
> > >=20
> > > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > >=20
> > > werewolf:~> lspci
> > > 00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller=
 Hub (rev 02)
> > > 00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Control=
ler (rev 02)
> > > ...
> > > 01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce F=
X 5200] (rev a1)
> > >=20
> > > BTW, I had to patch the nVidia driver. It just tries up to x4 AGP...
> > >=20
> >=20
> > New and old one works fine with Paul's patch:
> >=20
> > --old--
> > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > agpgart: X tried to set rate=3Dx12. Setting to AGP3 x8 mode.
> > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > -------
> >=20
> > (ok, so old driver is a bit dodgy)
> >=20
> > --new--
> > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > -------
> >=20
>=20
> Just curiosity, what says your /proc/driver/nvidia/agp/status ?
>=20

-----
# cat /proc/driver/nvidia/agp/status
Status:          Enabled
Driver:          AGPGART
AGP Rate:        8x
Fast Writes:     Enabled
SBA:             Enabled
-----


--=20
Martin Schlemmer


--=-nGYrzWzMdmuk9rnOLOlA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCMiiEqburzKaJYLYRAlZbAJ9H2HdDzQvuy6UFhBMFBUSObBIJBACfXlWv
Zsm0CEjLhDVW6JH88LUfKok=
=WsSb
-----END PGP SIGNATURE-----

--=-nGYrzWzMdmuk9rnOLOlA--

