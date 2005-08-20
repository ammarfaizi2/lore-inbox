Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbVHTBMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbVHTBMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbVHTBMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:12:32 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:62658 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932773AbVHTBMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:12:32 -0400
Date: Sat, 20 Aug 2005 11:12:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@suse.cz>
Cc: paulus@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.6.13] iSeries build with newer assemblers and
 compilers
Message-Id: <20050820111227.4bc14c64.sfr@canb.auug.org.au>
In-Reply-To: <20050819130056.GC2089@elf.ucw.cz>
References: <17154.43166.351018.356055@cargo.ozlabs.ibm.com>
	<20050819130056.GC2089@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__20_Aug_2005_11_12_27_+1000_GARs6wCjPJ7+vLyC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__20_Aug_2005_11_12_27_+1000_GARs6wCjPJ7+vLyC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Fri, 19 Aug 2005 15:00:56 +0200 Pavel Machek <pavel@suse.cz> wrote:
>
> >  	.xSize =3D sizeof(struct HvReleaseData),
> >  	.xVpdAreasPtrOffset =3D offsetof(struct naca_struct, xItVpdAreas),
> >  	.xSlicNacaAddr =3D &naca,		/* 64-bit Naca address */
> > -	.xMsNucDataOffset =3D (u32)((unsigned long)&xLparMap - KERNELBASE),
> > +	.xMsNucDataOffset =3D LPARMAP_PHYS,
> >  	.xFlags =3D HVREL_TAGSINACTIVE	/* tags inactive       */
> >  					/* 64 bit              */
> >  					/* shared processors   */
>=20
> These are extremely ugly cases of hungarian notation...

We know, and we are in the process of cleaning up all the StuDlyCaps etc,
but we would like this patch to go into 2.6.13.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__20_Aug_2005_11_12_27_+1000_GARs6wCjPJ7+vLyC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBoOAFdBgD/zoJvwRAtHGAJ9jEbAiWRBSYSNFNSH3SPcDnXH99gCfR1wH
UgtfGBD5CbngSY4c0dPIGeI=
=82yd
-----END PGP SIGNATURE-----

--Signature=_Sat__20_Aug_2005_11_12_27_+1000_GARs6wCjPJ7+vLyC--
