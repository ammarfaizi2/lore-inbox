Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUG1PCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUG1PCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUG1PCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:02:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:16837 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S267190AbUG1PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:01:52 -0400
Date: Wed, 28 Jul 2004 08:01:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728150145.GK10891@smtp.west.cox.net>
References: <20040728112222.GA7670@suse.de> <1091014495.2795.25.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1091014495.2795.25.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 28, 2004 at 01:34:55PM +0200, Arjan van de Ven wrote:

> On Wed, 2004-07-28 at 13:22, Olaf Hering wrote:
> > The ppc bootloader code will not compile with zlib debug enabled.
> > printf was not defined. Tested with vmlinux.coff
> > This patch was sent out earlier. Appearently it is not possible
> > to use the generic zlib copy in linux/lib
>=20
> actually it should be possible. Ok so it needs to be compiled as 32 bit,
> but surely just #include-ing the /linux/lib version, or even better, a
> few Makefile tricks should allow that, right ?

Arjan is correct, it should be very possible to use the copy in
lib/zlib_deflate as mpm had patches at one point to do just this.

Further, I'd rather leave the zlib debug stuff as is in arch/ppc/boot.
Olaf, has having this code work for you ever been useful?  Thanks.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBB7/ZdZngf2G4WwMRAqwuAJ0eSJhBgGmoVK9OSUN8NYS/OzJjcQCfbAT6
rJfnw4iVhhd/Pc3b66RW6Io=
=b5Ff
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
