Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSJIKQh>; Wed, 9 Oct 2002 06:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSJIKQh>; Wed, 9 Oct 2002 06:16:37 -0400
Received: from host213-121-105-39.in-addr.btopenworld.com ([213.121.105.39]:38540
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S261531AbSJIKQg>; Wed, 9 Oct 2002 06:16:36 -0400
Subject: RE: 2.4.9/2.4.18 max kernel allocation size
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: "'Ofer Raz'" <oraz@checkpoint.com>, linux-kernel@vger.kernel.org
In-Reply-To: <008b01c26ee0$5ee52380$9d893841@joe>
References: <008b01c26ee0$5ee52380$9d893841@joe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YHiIfvGDYsyMXFbN77sx"
Organization: 
Message-Id: <1034158957.30384.8.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 09 Oct 2002 11:22:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YHiIfvGDYsyMXFbN77sx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-08 at 16:35, Joseph D. Wagner wrote:
> I might be thinking of something totally different than what you're
> talking about, but here it goes:
>=20
> Change line 18 of mmzone.h from:
> 	#define MAX_ORDER 10
> 	to
> 	#define MAX_ORDER 24
>=20
> This allows larger contiguous chunks of memory to be allocated, up to
> 32GB.

He's using vmalloc, so I assume he doesn't need physically contiguous
memory, rather virtually contigous. This code won't change a thing for
his vmalloc() calls AFAICS.

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-YHiIfvGDYsyMXFbN77sx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9pANtkbV2aYZGvn0RArzEAJoCKsyoJp3+GYtfHFIMJxVYycctMwCcCEpH
s61bn3lGGzUoJg7TsPJRgwY=
=sNpK
-----END PGP SIGNATURE-----

--=-YHiIfvGDYsyMXFbN77sx--

