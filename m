Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262431AbSJNUrY>; Mon, 14 Oct 2002 16:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbSJNUrY>; Mon, 14 Oct 2002 16:47:24 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:27631 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262431AbSJNUrX>; Mon, 14 Oct 2002 16:47:23 -0400
Subject: Re: [BUG] Compile failure (gcc 2.96 bug?). 2.5.42 raid0.c
From: Arjan van de Ven <arjanv@redhat.com>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210141622460.2876-100000@admin>
References: <Pine.LNX.4.44.0210141622460.2876-100000@admin>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-kOF0EH5MsPk1NYZ0BQeQ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Oct 2002 22:54:08 +0200
Message-Id: <1034628849.3038.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kOF0EH5MsPk1NYZ0BQeQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-14 at 22:27, David Mansfield wrote:
>
> -               sector_t x =3D block;
> +               volatile sector_t y =3D 0;
> +               sector_t x =3D block - y;
>                 sector_div(x, (unsigned long)conf->smallest->size);
>                 hash =3D conf->hash_table + x;
>         }
this appears to be a bad code bug; do_div() requires the first argument
to be an u64 and we cast it to unsigned long here....


--=-kOF0EH5MsPk1NYZ0BQeQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9qy7wxULwo51rQBIRAub8AJ4qxys/NamfcPfsARKKAFajW/T6aQCeMBAs
KHe/JYaie22QxrrNNfi73ZQ=
=WR1G
-----END PGP SIGNATURE-----

--=-kOF0EH5MsPk1NYZ0BQeQ--

