Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWAFTec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWAFTec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWAFTeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:34:31 -0500
Received: from zlynx.org ([199.45.143.209]:19473 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S932492AbWAFTea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:34:30 -0500
Subject: Re: [PATCH] bio: gcc warning fix.
From: Zan Lynx <zlynx@acm.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Khushil Dep <khushil.dep@help.basilica.co.uk>,
       Al Viro <viro@ftp.linux.org.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106184810.GR3389@suse.de>
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
	 <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
	 <20060106184810.GR3389@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-olVH06QZZE/RHwogogzT"
Date: Fri, 06 Jan 2006 12:33:56 -0700
Message-Id: <1136576037.10342.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-olVH06QZZE/RHwogogzT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-06 at 19:48 +0100, Jens Axboe wrote:
> On Fri, Jan 06 2006, Jesper Juhl wrote:
> > gcc is right to warn in the sense that it doesn't know if
> > bvec_alloc_bs() will read or write into idx when its address is passed
>=20
> The function is right there, on top of bio_alloc_bioset(). It's even
> inlined. gcc has absolutely no reason to complain.

GCC complains because it is possible for that function to return without
ever setting a value into idx.  It's the "default" case in the switch.
Of course, if that happens, idx will not be used and so it is not
actually a problem.
--=20
Zan Lynx <zlynx@acm.org>

--=-olVH06QZZE/RHwogogzT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDvsYkG8fHaOLTWwgRAkVcAKCl9dosYiOuOVm2kdpmfNs8jDWR8QCcDa1f
TeFu4YuYMVYmCtB3/rdUqow=
=AqrY
-----END PGP SIGNATURE-----

--=-olVH06QZZE/RHwogogzT--

