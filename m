Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269021AbUHZPNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269021AbUHZPNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUHZPNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:13:25 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:37530 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S269020AbUHZPNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:13:17 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040826150434.GF5733@mail.shareable.org>
References: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826001152.GB23423@mail.shareable.org>
	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>
	 <20040826140500.GA29965@fs.tum.de>
	 <1093530313.11694.56.camel@leto.cs.pocnet.net>
	 <20040826150434.GF5733@mail.shareable.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vvWcgnXTlShXGRKtEj4Z"
Date: Thu, 26 Aug 2004 17:12:55 +0200
Message-Id: <1093533175.11694.77.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vvWcgnXTlShXGRKtEj4Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 16:04 +0100 schrieb Jamie Lokier:

> Christophe Saout wrote:
> > What reiser4 can do, but the VFS can't is to insert or remove data in
> > the middle of a file. Adding this above the page cache would probably b=
e
> > almost impossible (truncate seems already complicated enough).
>=20
> That would be one of those "special features" that a
> VFS-plus-userspace implementation of archive views could take
> advantage of on reiser4, while using a slower method (sometimes much
> slower) on all other filesystems.

I'm just thinking about something. While you can't cut bytes out of unix
iles a lot of filesystems can do this (holes). Most of them only on a
block boundary, reiser4 on a byte boundary. If the filesystems could
export this functionality using an enhanced API we could implement a
compression plugin and other things on the VFS level that works with
every filesystem supporting the required mechanisms, not only reiser4.
And those features would take advantage of reiser4's storage mechanisms.
I think Hans made the plugins reiser4-only because only reiser4 has a
similar API at that time (and obviously because he didn't even think
about doing it otherwise).

> By the way, can reiser4 share parts of files between different files?

At the moment a file is exactly one object. But someone could write
another file plugin that spans a file across multiple objects, then yes,
multiple files could share parts.


--=-vvWcgnXTlShXGRKtEj4Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLf33ZCYBcts5dM0RAs0kAJ9ok4vLKWFq4D5anSsnieCbBjX4hACgigL1
hdiCY9AxcmzQ/eVirE/HP5o=
=684B
-----END PGP SIGNATURE-----

--=-vvWcgnXTlShXGRKtEj4Z--

