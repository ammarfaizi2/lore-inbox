Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTFBNGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFBNGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:06:52 -0400
Received: from host81-136-219-112.in-addr.btopenworld.com ([81.136.219.112]:444
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP id S262294AbTFBNGv
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 2 Jun 2003 09:06:51 -0400
Subject: Re: const from include/asm-i386/byteorder.h
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
In-Reply-To: <16091.14923.815819.792026@laputa.namesys.com>
References: <16088.47088.814881.791196@laputa.namesys.com>
	 <1054406992.4837.0.camel@sherbert> <20030531185709.GK8978@holomorphy.com>
	 <16091.14923.815819.792026@laputa.namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YHIU5A03XObFDSKb967i"
Organization: 
Message-Id: <1054560074.4829.9.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jun 2003 14:21:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YHIU5A03XObFDSKb967i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-02 at 12:51, Nikita Danilov wrote:
> =3D=3D=3D=3D=3D include/linux/compiler.h 1.15 vs edited =3D=3D=3D=3D=3D
> --- 1.15/include/linux/compiler.h	Wed Apr  9 22:15:46 2003
> +++ edited/include/linux/compiler.h	Mon Jun  2 14:44:18 2003
> @@ -56,6 +56,22 @@
>  #define __attribute_used__	__attribute__((__unused__))
>  #endif
> =20
> +/* The attribute `pure' is not implemented in GCC versions earlier than =
2.96. */
> +#if (__GNUC__ > 2) || (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 96)
> +#define __attribute_pure __attribute__ ((__pure__))
> +#else
> +#define __attribute_pure=20
> +#endif
> +
> +/* The attribute `const' is not implemented in GCC versions earlier than=
 2.5. */
> +/* Basically this is just slightly more strict class than the `pure'
> +   attribute */
> +#if (__GNUC__ > 2) || (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 5)
> +#define __attribute_const __attribute__ ((__const__))
> +#else
> +#define __attribute_const
> +#endif
> +

I think __const_fn and __pure_fn would be a bit more descriptive and
more readable, even though that would appear to go against convention.
It's just that the 'attribute' bit is space consuming and doesn't say
much...

Just my opinion anyway.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-YHIU5A03XObFDSKb967i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+209KkbV2aYZGvn0RAm0hAJ92OCQaq5CrxHBDtDS7QJK3GxvBngCfYhA6
53572lQMcE27KYIU3iihqJ4=
=N8Sf
-----END PGP SIGNATURE-----

--=-YHIU5A03XObFDSKb967i--

