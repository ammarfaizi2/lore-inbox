Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263534AbTC3KgD>; Sun, 30 Mar 2003 05:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263535AbTC3KgC>; Sun, 30 Mar 2003 05:36:02 -0500
Received: from ns2.arlut.utexas.edu ([129.116.174.1]:43016 "EHLO
	ns2.arlut.utexas.edu") by vger.kernel.org with ESMTP
	id <S263534AbTC3KgB>; Sun, 30 Mar 2003 05:36:01 -0500
Date: Sun, 30 Mar 2003 04:47:21 -0600
From: Jonathan Abbey <jonabbey@arlut.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre6: mmx_memcpy not properly exposed to modules with Athlon
Message-ID: <20030330104720.GA27518@arlut.utexas.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've had a good deal of trouble this evening trying to compile
2.4.21-pre6 for the Athlon processor.  It appears that when the
kernel's bzImage is built all is well, but building modules (for USB)
results in unresolved references to _mmx_memcpy in the modules.

=46rom looking at the System.map file and nm vmlinux, it appears that
the _mmx_memcpy symbol is present and presumably thereby linkable.
I'm not certain why that symbol is not being resolved when I try to
depmod or insmod the USB modules.

I was able to work around the problem by building the bzImage for
Athlon, then doing a make config to switch the processor type to
PIII/Coppermine before building the modules, so that memcpy is not
#define'd to refer to _mmx_memcpy, but this is not a terribly
satisfying workaround.
=20
--=20
---------------------------------------------------------------------------=
----
Jonathan Abbey 				              jonabbey@arlut.utexas.edu
Applied Research Laboratories                 The University of Texas at Au=
stin
Ganymede, a GPL'ed metadirectory for UNIX     http://www.arlut.utexas.edu/g=
ash2

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (SunOS)

iD8DBQE+hss4GI9EwHF2dYYRArEmAKCLYkNrR4XgL40zs07DK7DCd0l3rwCg3Gy8
WCmXJ6bkmIhEcPqMwSIMuUY=
=Tqie
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
