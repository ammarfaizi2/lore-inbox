Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVHDRtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVHDRtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVHDRtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:49:10 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:32205 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261512AbVHDRtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:49:08 -0400
Date: Thu, 04 Aug 2005 10:48:59 -0700
From: Tom Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: Re: [openib-general] [RFC] Move InfiniBand .h files
In-reply-to: <52iryla9r5.fsf@cisco.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Message-id: <1123177739.29639.1.camel@duffman>
MIME-version: 1.0
X-Mailer: Evolution 2.3.6.1 (2.3.6.1-3)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-Hipu7u23vuNupnIXz9rl"
References: <52iryla9r5.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hipu7u23vuNupnIXz9rl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-04 at 10:32 -0700, Roland Dreier wrote:
> I would like to get people's reactions to moving the InfiniBand .h
> files from their current location in drivers/infiniband/include/ to
> include/linux/rdma/.  If we agree that this is a good idea then I'll
> push this change as soon as 2.6.14 starts.

I think it is a great idea.

> The advantages of doing this are:
>=20
>   - The headers become more easily accessible to other parts of the
>     tree that might want to use IB support.  For example, an NFS/RDMA
>     client probably wants to live under fs/
>   - It makes it easier to build IB modules outside the tree, since
>     include/linux gets put in /lib/modules/<ver>/build.  I realize
>     that we don't really care about out-of-tree modules, but it is
>     convenient to be able to develop and distribute new drivers that
>     build against someone's existing kernels.
>   - We can kill off the ugly
>=20
>         EXTRA_CFLAGS +=3D -Idrivers/infiniband/include
>=20
>     lines in our Makefiles.

One more advantage:

   - It shows our willingness to push past just infiniband.

-tduffy

--=-Hipu7u23vuNupnIXz9rl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC8lULdY502zjzwbwRAhuBAKCcsHOKR29jhrmucEoemeVTdZ/cOACfejfm
Gu69hY+YqeLYxgiPkxBRQlI=
=D//0
-----END PGP SIGNATURE-----

--=-Hipu7u23vuNupnIXz9rl--

