Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUK0XBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUK0XBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUK0XAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:00:51 -0500
Received: from natmwynyy.rzone.de ([81.169.145.169]:1752 "EHLO
	natmwynyy.rzone.de") by vger.kernel.org with ESMTP id S261361AbUK0XAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:00:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sat, 27 Nov 2004 23:53:49 +0100
User-Agent: KMail/1.6.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org> <1101575782.21273.5347.camel@baythorne.infradead.org>
In-Reply-To: <1101575782.21273.5347.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_BWQqB6g36CvIFi9";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411272353.54056.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_BWQqB6g36CvIFi9
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 27 November 2004 18:16, you wrote:
> On Sat, 2004-11-27 at 08:47 -0800, Randy.Dunlap wrote:
> > Speaking of more explicit, there are various asm-ARCH header
> > files that do or do not hide (via __KERNEL__) interfaces
> > such as:=A0=A0=A0=A0=A0=A0get_unaligned()
> > and the atomic operations.
> >=20
> > So are these Linux kernel exported APIs, or do they belong
> > in some library?
>=20
> Both of those are kernel-private and should not be visible.

The problem with these (atomic.h, bitops.h, byteorder.h, div64.h,
list.h, spinlock.h, unaligned.h and xor.h) is that they provide
functionality that is needed by many user application but not
provided by the compiler or libc.=20

While I agree that it is an absolutely evil concept to include
them from the kernel headers, we have to face that by not installing
them, lots of this existing evil user code will be broken even
more and someone has to pick up the pieces.

	Arnd <><

--Boundary-02=_BWQqB6g36CvIFi9
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBqQWB5t5GS2LDRf4RAmROAJ4r1SA0KQNOR1RmccJk44d3QGEj3QCeNaFz
AkTUn5kS3vz4DYchBobhwRo=
=JRSe
-----END PGP SIGNATURE-----

--Boundary-02=_BWQqB6g36CvIFi9--
