Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSJNVFL>; Mon, 14 Oct 2002 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSJNVFL>; Mon, 14 Oct 2002 17:05:11 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:27631 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262296AbSJNVFK>; Mon, 14 Oct 2002 17:05:10 -0400
Subject: Re: [BUG] Compile failure (gcc 2.96 bug?). 2.5.42 raid0.c
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: David Mansfield <lkml@dm.cobite.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1034628849.3038.23.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0210141622460.2876-100000@admin> 
	<1034628849.3038.23.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-jNyoDj4GFF5/0Z6jQegI"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Oct 2002 23:11:55 +0200
Message-Id: <1034629916.2937.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jNyoDj4GFF5/0Z6jQegI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-14 at 22:54, Arjan van de Ven wrote:
> On Mon, 2002-10-14 at 22:27, David Mansfield wrote:
> >
> > -               sector_t x =3D block;
> > +               volatile sector_t y =3D 0;
> > +               sector_t x =3D block - y;
> >                 sector_div(x, (unsigned long)conf->smallest->size);
> >                 hash =3D conf->hash_table + x;
> >         }
> this appears to be a bad code bug; do_div() requires the first argument
> to be an u64 and we cast it to unsigned long here....

ehm ignore me I'm blind

--=-jNyoDj4GFF5/0Z6jQegI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9qzMbxULwo51rQBIRAt6bAKCLME3E/5/Ufo/+nHlmqOFwVQLjxACfe9w1
RTNyOKsbzzpK+eX4w0SwlME=
=IWYb
-----END PGP SIGNATURE-----

--=-jNyoDj4GFF5/0Z6jQegI--

