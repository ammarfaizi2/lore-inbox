Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbTAFO04>; Mon, 6 Jan 2003 09:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAFO04>; Mon, 6 Jan 2003 09:26:56 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:24506
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265564AbTAFO0z>; Mon, 6 Jan 2003 09:26:55 -0500
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Thomas Ogrisegg <tom@rhadamanthys.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041559195.24901.119.camel@irongate.swansea.linux.org.uk>
References: <20021230012937.GC5156@work.bitmover.com>
	<1041489421.3703.6.camel@rth.ninka.net>
	<20030102221210.GA7704@window.dhis.org>
	<20030102.151346.113640740.davem@redhat.com>
	<20030103004543.GA12399@window.dhis.org> 
	<20030103010107.GB6416@work.bitmover.com> 
	<1041559195.24901.119.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-mcYo6AitVNWKQggVT6eO"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 14:36:19 +0000
Message-Id: <1041863779.13078.3.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mcYo6AitVNWKQggVT6eO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-01-03 at 01:59, Alan Cox wrote:
> You may not be doing an mmap a send, its more likely to look like
>=20
> 	page =3D hash(url);
> 	memcpy(current_time, page->clock, TIMESIZE);
> 	write(sock, page->data, page->len);

If your web data rarely changes, it could also be all the files stored
in a hashfile database covered by one large mmap, eliminating filesystem
overhead (and vma overhead).

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-mcYo6AitVNWKQggVT6eO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+GZRjkbV2aYZGvn0RAvBWAJ951cMC9dOxoDWI0w6UuWEpMmoFbACeJCNI
2jgq8MgfTWnzSkj9RNadQOs=
=PCDm
-----END PGP SIGNATURE-----

--=-mcYo6AitVNWKQggVT6eO--

