Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263799AbTCVUJG>; Sat, 22 Mar 2003 15:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263803AbTCVUJG>; Sat, 22 Mar 2003 15:09:06 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:19953 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263799AbTCVUJE>; Sat, 22 Mar 2003 15:09:04 -0500
Subject: Re: [PATCH] reduce stack in cdrom/optcd.c
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, leo@netlabs.net
In-Reply-To: <1048365798.9221.35.camel@irongate.swansea.linux.org.uk>
References: <3E7C0808.75B95FB7@verizon.net>
	 <1048365798.9221.35.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6pXsQ5vvky84vyDB+miA"
Organization: Red Hat, Inc.
Message-Id: <1048364399.1708.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Mar 2003 21:19:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6pXsQ5vvky84vyDB+miA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-03-22 at 21:43, Alan Cox wrote:
> On Sat, 2003-03-22 at 06:51, Randy.Dunlap wrote:
> > Hi,
> >=20
> > This reduces stack usage in drivers/cdrom/optcd.c by
> > dynamically allocating a large (> 2 KB) buffer.
> >=20
> > Patch is to 2.5.65.  Please apply.
>=20
> This loosk broken. You are using GFP_KERNEL memory allocations on the
> read path of a block device. What happens if the allocation fails=20
> because we need memory

it's unlikely that you have your swap on the cdrom ;)

--=-6pXsQ5vvky84vyDB+miA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fMVuxULwo51rQBIRAvsDAJ0TKftjOjsSlEYtS0yRc6Gtpn4d0ACffVRW
o/CvqmvN+0ZGZWeoNnHS034=
=06Zi
-----END PGP SIGNATURE-----

--=-6pXsQ5vvky84vyDB+miA--
