Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSE0Gfb>; Mon, 27 May 2002 02:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314420AbSE0Gfa>; Mon, 27 May 2002 02:35:30 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:29710 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S314413AbSE0Gfa>;
	Mon, 27 May 2002 02:35:30 -0400
Date: Mon, 27 May 2002 10:40:26 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] neofb.c
Message-ID: <20020527064026.GB314@pazke.ipt>
Mail-Followup-To: Thomas 'Dent' Mirlacher <dent@cosy.sbg.ac.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205251400470.7328-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2002 at 02:02:16PM +0200, Thomas 'Dent' Mirlacher wrote:
> gcc 3.1 seems to be unhappy:
> neofb.c:2321: initialized causes a section type conflict
>=20
> the simple patch for this would be:
> =3D=3D=3D=3D=3D neofb.c 1.8 vs edited =3D=3D=3D=3D=3D
> --- 1.8/drivers/video/neofb.c   Thu May  2 00:56:02 2002
> +++ edited/neofb.c      Sat May 25 18:50:14 2002
> @@ -2318,10 +2318,10 @@
>    return 0;
>  }
> =20
> -static int __init initialized =3D 0;
> -
>  int __init neofb_init(void)
>  {
> +  static int initialized =3D 0;
> +
>    DBG("neofb_init");
> =20
>    if (disabled)

correct solution is to change __init to __initdata.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE88dTaBm4rlNOo3YgRArQ/AJwNfZfLgSwl9fRweXRiBoBcg1khfQCdHmZ4
//5ulWHllQ9clvRRskPDCEU=
=0D9E
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
