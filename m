Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUJQSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUJQSgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUJQSgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:36:18 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:12543 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S268042AbUJQSgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:36:01 -0400
Subject: Re: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while
	atomic [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       luc@saillard.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041017093018.GY5607@holomorphy.com>
References: <20041017073614.GC7395@gamma.logic.tuwien.ac.at>
	 <20041017093018.GY5607@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AAKmvm/RhtCxeCAZYtki"
Date: Sun, 17 Oct 2004 20:35:31 +0200
Message-Id: <1098038131.15115.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AAKmvm/RhtCxeCAZYtki
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 02:30 -0700, William Lee Irwin III wrote:
> On Sun, Oct 17, 2004 at 09:36:14AM +0200, Norbert Preining wrote:
> > @@ -1618,7 +1618,7 @@
> >         pos =3D (unsigned long)pdev->image_data;
> >         while (size > 0) {
> >                 page =3D kvirt_to_pa(pos);
> > -               if (remap_page_range(vma, start, page, PAGE_SIZE,
> >                 PAGE_SHARED))
> > +               if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_S=
HARED))
> >                         return -EAGAIN;
> > =20
> >                 start +=3D PAGE_SIZE;
> > the module compiled and loaded without problem, but when starting
> > gnomemeeting I get the following kernel BUG and scheduling while atomic=
:
>=20
> You need to right shift the argument by PAGE_SHIFT.
>=20

I am trying to get vesafb-tng to work with rc4-mm1, but are not sure
when to shift the argument by PAGE_SHIFT, and when not to.  The patches
from you in rc4-mm1 sometimes shifts the second arg, other times the
third, and other times not at all.  Is there a easy way for a mostly
clueless person to figure out when to shift what argument and when not?


Thanks,

--=20
Martin Schlemmer


--=-AAKmvm/RhtCxeCAZYtki
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcrtyqburzKaJYLYRAmm8AJ9RLjl3rz7XgTexWen2g57ghDmqwgCgnCS0
5y/8YcDoU8F7FhmVh8f6LkU=
=i2c7
-----END PGP SIGNATURE-----

--=-AAKmvm/RhtCxeCAZYtki--

