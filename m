Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280620AbRKBJYr>; Fri, 2 Nov 2001 04:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280621AbRKBJYh>; Fri, 2 Nov 2001 04:24:37 -0500
Received: from hq.alert.sk ([147.175.66.131]:9732 "HELO hq.alert.sk")
	by vger.kernel.org with SMTP id <S280620AbRKBJYX>;
	Fri, 2 Nov 2001 04:24:23 -0500
Date: Fri, 2 Nov 2001 10:24:21 +0100
From: Robert Varga <nite@hq.alert.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
Message-ID: <20011102102421.A25221@hq.alert.sk>
In-Reply-To: <3BE1C07D.5080205@antefacto.com> <Pine.LNX.4.30.0111012242060.3245-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0111012242060.3245-100000@mustard.heime.net>; from roy@karlsbakk.net on Thu, Nov 01, 2001 at 10:43:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2001 at 10:43:37PM +0100, Roy Sigurd Karlsbakk wrote:
> > Note this transparent ext2 compression patch is only available for 2.2
>=20
> Would it be hard to port to 2.4?

AFAIK kinda yes. It relies on IO going through block buffer cache:
Buffer cache contains the compressed data, while the page cache has it all =
decompressed.
This avoids excessive (de)compression (you need to compress data only when =
commiting page
to disk).

With 2.4 Ext2 moved (almost?) entirely out of buffer cache, you'll need to
create your own IO buffers. This is the only solution I came up with. Is th=
ere some
other approach how to cope with this problem ?

--=20
Kind regards,
Robert Varga
---------------------------------------------------------------------------=
---
n@hq.sk                                          http://hq.sk/~nite/gpgkey.=
txt
=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE74mZF9aKR2/T45h8RAtS2AKCTvTFTKpGHgcz8Jy/FYGUe8N5rAQCcDO9X
cSvgFvl9msTtBT/5XfVHriM=
=3AwM
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
