Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUHWP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUHWP6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUHWP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:58:45 -0400
Received: from zak.futurequest.net ([69.5.6.152]:3479 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S266069AbUHWP5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:57:14 -0400
Date: Mon, 23 Aug 2004 09:57:12 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Broadcom 4401 problem
Message-ID: <20040823155712.GA21840@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040822205346.GA17895@em.ca> <20040822221734.GA10372@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20040822221734.GA10372@ee.oulu.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2004 at 01:17:34AM +0300, Pekka Pietikainen wrote:
> Could you try the driver from http://www.ee.oulu.fi/~pp/b44-095-2.tgz ,
> which has some fixes that have been submitted but not yet merged.

Thanks.  This source has some problems.  When compiling, I get multiple
errors regarding PCI_DEVICE_ID_BCM4713 being undefined:
/root/b44/b44.c:94: error: `PCI_DEVICE_ID_BCM4713' undeclared here (not in =
a function)
etc  Is this missing a header file or some other update?

In order to try to get it to compile, I removed the PCI table entry for
the BCM4713 and made every conditional that depends on it false (by
removing the appropriate code).  However, when trying to ifconfig the
interface I get:
	SIOCSIFFLAGS: Cannot allocate memory
	SIOCSIFFLAGS: Cannot allocate memory

> If that
> doesn't help, the broadcom driver=20
> ( http://www.broadcom.com/drivers/downloaddrivers.php ) might be
> worth a try.

The Broadcom Linux driver version 3.0.7 also locks up on me, but it
doesn't support "ethtool -A", so I have to stop and start the interface
completely to get it working again.

> Also if you have more than 1Gb of memory, booting with mem=3D1024m=20
> might help

Nope.  512MB RAM.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKhPY6W+y3GmZgOgRAk7hAJ4nh38QSSgk1az28DLLPXIUJsE79QCgnOwZ
y5WyC1VAWlNQEcB4qWU9psw=
=cet3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
