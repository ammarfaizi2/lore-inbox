Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTLDSPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTLDSPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:15:19 -0500
Received: from [68.114.43.143] ([68.114.43.143]:11732 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S263325AbTLDSPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:15:09 -0500
Date: Thu, 4 Dec 2003 13:15:04 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Andre Tomt <lkml@tomt.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lilo and system maps?
Message-ID: <20031204181504.GG16568@rdlg.net>
Mail-Followup-To: Andre Tomt <lkml@tomt.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20031204175311.GF16568@rdlg.net> <1070561388.15415.233.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <1070561388.15415.233.camel@slurv.pasop.tomt.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thus spake Andre Tomt (lkml@tomt.net):

> On Thu, 2003-12-04 at 18:53, Robert L. Harris wrote:
> > I'm messing around on one of my dev machines which has 4 possible
> > kernels installed.  2.4, 2.4-stable, 2.6, 2.6-stable (stable is the last
> > known good kernel).  I currently have my System.map files laid out as:
> >=20
> > /boot/System.map-2.6.0-test11-bk2
> > /boot/System.map-2.6.0-test10-bk4
> > etc.
> ^^^
>=20
> > This way when I install a new kernel I can copy the System.map to
> > /boot/System.map-2.6 instead of keeping up with all the version numbers?
> > lilo doesn't seem to like the map=3D arguements.  Does the kernel need =
the
> > System.map in a single place, can it figure out where it's at for a
> > multiple config?
>=20
> Just stick with the System.map-$(uname -r) variant and it will just work
> automaticly. map=3D in lilo is not for System.map's.
>=20

Upon reading the man page on lilo.conf again I realized that was the
wrong map, but was hoping there was some notation that'd allow for maps
other than "/boot/System.map" for the multiple kernels.

Ok, I've tried rdev and file, is there a "cleaner" way of getting a
kernel version other than:

{0}:/usr/share/doc/lire>strings /boot/vmlinuz-2.6 | grep -i 2.[46] | head
2.6.0-test11-bk2 (root@wally) #3 SMP Thu Dec 4 12:41:42 EST 2003
M2#6gbQ+
{2 6B
=2E2'4]
AG2{6
b2)42
2y6&LD
2U6;
214<|7
2"6:

Yes it's functional, I can live with it, just wondering if theres a
"better" way for when I'm updating servers at work and have no idea what
kernels are in /boot on the machine (some have been up longer than the
year+ I've been here).




:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z3mo8+1vMONE2jsRAlhXAJ4ndR2k3J/qpJzZVS1uqLZxiWquTgCfYzuH
E1zdIdEh1ciqfUAQEANHmDQ=
=BvaB
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
