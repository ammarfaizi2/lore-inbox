Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283616AbRLEAuE>; Tue, 4 Dec 2001 19:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283621AbRLEAtz>; Tue, 4 Dec 2001 19:49:55 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:63751 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S283616AbRLEAtq>; Tue, 4 Dec 2001 19:49:46 -0500
Date: Tue, 4 Dec 2001 16:49:41 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
Message-ID: <20011204164941.A29968@one-eyed-alien.net>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de> <3C0D6CB6.7000905@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0D6CB6.7000905@zytor.com>; from hpa@zytor.com on Tue, Dec 04, 2001 at 04:39:18PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is another argument for supporting both endiannesses....

Consider an embedded system which can be run in either endianness.  Sounds
silly?  MIPS processors can run big or little endian, and many people
routinely switch between them.

Matt

On Tue, Dec 04, 2001 at 04:39:18PM -0800, H. Peter Anvin wrote:
> Ingo Oeser wrote:
>=20
> >=20
> > Yes, from a CS point of view.=20
> >=20
> > But practically cramfs is created once to contain some kind of
> > ROM for embedded devices. So if we never modify these data again,
> > why not creating it in the required byte order?=20
> >=20
> > Why wasting kernel cycles for le<->be conversion? Just because
> > it's more general? For writable general purpose file systems it
> > makes sense, but to none of romfs, cramfs etc.
> >=20
>=20
>=20
> Because otherwise you far too easily end up in a situation where every
> system suddenly need to be able to support *BOTH* endianisms, at which
> point you're really screwed; supporting dual endianism is significantly
> more expensive than supporting the "wrong" endianism, and it affects all
> systems.
>=20
> Nip this one in the bud.
>=20
> 	-hpa
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

M:  No, Windows doesn't have any nag screens.
C:  Then what are those blue and white screens I get every day?
					-- Mike and Cobb
User Friendly, 1/4/1999

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8DW8lz64nssGU+ykRAuFAAKDYjdcFn0R/2fSyZfT36yIfN3dhzACeMPRZ
pNWppLlrw8i2BtiO8O2QoPA=
=oqd1
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
