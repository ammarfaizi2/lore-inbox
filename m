Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbUK1AC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUK1AC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbUK1AC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:02:28 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:2791 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261370AbUK1ACR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:02:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 28 Nov 2004 00:56:20 +0100
User-Agent: KMail/1.6.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, dhowells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <41A90D66.4020204@osdl.org> <1101598348.5278.8.camel@localhost.localdomain>
In-Reply-To: <1101598348.5278.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_kQRqBs/RWwxHAsG";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411280056.20757.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_kQRqBs/RWwxHAsG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 28 November 2004 00:32, David Woodhouse wrote:
> On Sat, 2004-11-27 at 15:27 -0800, Randy.Dunlap wrote:
> > That's addressing a different problem.  I agree with
> > David W. that we need to clean the kernel headers up.
> > Let libc or libxyz provide the missing functionality.
> > The borken programs were stealing something that wasn't
> > promised to them AFAIK.
>=20
> Not only wasn't it promised; it wasn't even working on some
> architectures anyway.
>=20
Well, at least on s390 some effort was spent on making it work
(see e.g. asm-s390/spinlock.h). I don't really mind removing
that functionality, but I'd prefer still installing some files
into /usr/include/asm/spinlock.h et.al that contain an #error
and a pointer to an explanation, so users can complain to the
right people (i.e. not me ;-).

	Arnd <><

--Boundary-02=_kQRqBs/RWwxHAsG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqRQk5t5GS2LDRf4RAqj7AKCkDP26WIql0prgx/h2XJ6Awbz4gQCfaYs3
VrTljigvQmDLxKIlUvFCHkA=
=kK5w
-----END PGP SIGNATURE-----

--Boundary-02=_kQRqBs/RWwxHAsG--
