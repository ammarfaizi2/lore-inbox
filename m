Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265244AbUEYWa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUEYWa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUEYWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:30:44 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:47038 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265187AbUEYW3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:29:16 -0400
Subject: Re: [PATCH 3/4] Consolidate sys32_select
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "David S. Miller" <davem@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
In-Reply-To: <20040525151202.58010d51.davem@redhat.com>
References: <200404161800.22367.arnd@arndb.de>
	 <200404161805.55224.arnd@arndb.de> <1085522532.969.91.camel@tux.rsn.bth.se>
	 <20040525151202.58010d51.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NNiuNVIRD2dY0Sx+SIRR"
Message-Id: <1085524153.969.104.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 00:29:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NNiuNVIRD2dY0Sx+SIRR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-26 at 00:12, David S. Miller wrote:
> Just fix the code to use compat_ptr().  That's what we created
> that macro for :-)

You mean in compat_sys_select() ?
compat_ptr() takes an u32 as argument, needs casting, ugly.
But you want it done that way?

I see this problem when compat_sys_select() is called directly from
syscall, not via sunos_select() which uses compat_ptr()

--=20
/Martin

--=-NNiuNVIRD2dY0Sx+SIRR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAs8i5Wm2vlfa207ERAlp3AJ99ELm6RhKWHjFGvSSTozhtSHAstwCfUm6w
3vgsyD+HPNDBecBkFqEWAsw=
=r4Dy
-----END PGP SIGNATURE-----

--=-NNiuNVIRD2dY0Sx+SIRR--
