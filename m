Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUI0T5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUI0T5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUI0T47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:56:59 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:22506 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267298AbUI0Tzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:55:31 -0400
Date: Mon, 27 Sep 2004 21:53:29 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Antony Suter <suterant@users.sourceforge.net>
Cc: List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [PATCH] __VMALLOC_RESERVE export
Message-ID: <20040927195329.GC17487@thundrix.ch>
References: <1096304623.9430.8.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <1096304623.9430.8.camel@hikaru.lan>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Tue, Sep 28, 2004 at 03:03:43AM +1000, Antony Suter wrote:
> __VMALLOC_RESERVE itself is not exported but is used by something that
> is. This patch is against 2.6.9-rc2-bk11
>=20
> This is required by the nvidia binary driver 1.0.6111
>=20
> (2 long lines are being wrapped by my emailer)

ACK. I did  the same thing at some friend's  computer which is running
with it since the __VMALLOC_RESERVE  patch came out, so it's The Right
Thing[tm].

Signed-off-by: Tonnerre <tonnerre@thundrix.ch>

> diff -u -pruaN linux-orig/arch/i386/mm/init.c
> linux-new/arch/i386/mm/init.c
> --- linux-orig/arch/i386/mm/init.c	2004-09-26 03:43:57.944613000 +1000
> +++ linux-new/arch/i386/mm/init.c	2004-09-28 02:37:21.787922000 +1000
> @@ -41,6 +41,7 @@
>  #include <asm/sections.h>
> =20
>  unsigned int __VMALLOC_RESERVE =3D 128 << 20;
> +EXPORT_SYMBOL(__VMALLOC_RESERVE);
> =20
>  DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
>  unsigned long highstart_pfn, highend_pfn;
>=20
> --=20
> - Antony Suter  (suterant users sourceforge net)  "Bonta"
> - "Facts do not cease to exist because they are ignored." - Aldous Huxley



--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBWG+4/4bL7ovhw40RAqA9AJ915sCZYg/knLt1wbB27JkMEirSJwCgkUEI
WnqPzYruLl24B2mUQUoHSWg=
=cdKI
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
