Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290939AbSAaF3S>; Thu, 31 Jan 2002 00:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290940AbSAaF3J>; Thu, 31 Jan 2002 00:29:09 -0500
Received: from dracula.gtri.gatech.edu ([130.207.193.70]:27910 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP
	id <S290939AbSAaF3D>; Thu, 31 Jan 2002 00:29:03 -0500
Date: Thu, 31 Jan 2002 00:28:55 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org
Subject: BUG:  broken I830MP AGP support in 2.4.17 and 2.4.18pre7
Message-ID: <20020131002855.A10415@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm blessed with a new Dell Inspiron 4100, which is in turn blessed with
the i830MP AGP chipset.  It's identical to the i830M except it doesn't
have the on-chip graphics controller.

When trying to load up the agpgart module under 2.4.17, I get:

>Linux agpgart interface v0.99 (c) Jeff Hartmann
>agpgart: Maximum main memory to use for agp memory: 262M
>agpgart: Detected an Intel 830M, but could not find the secondary device.

Fine, I see that 2.4.18pre supposedly has fixes for the I830MP.  So I
compile it, slap it in place.. and get:  (with 2.4.17pre7)

>Linux agpgart interface v0.99 (c) Jeff Hartmann
>agpgart: Maximum main memory to use for agp memory: 262M
>agpgart: unsupported bridge
>agpgart: no supported devices found.

lspci yields:
>00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
>        Flags: bus master, fast devsel, latency 0
>        Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
>        Capabilities: [40] #09 [0105]
>        Capabilities: [a0] AGP version 2.0

So it appears not all is well with the I830MP patch.
(Yes, I have tried the 'agp_unsupported' option in both cases)

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8WNYXysXuytMhc5ERAl5nAJ4hQc0/smcwHSbEREngASzWqXtfWQCdGne+
/JcZ7G45+fcbRBuSUbEdkHw=
=3DuJ
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
