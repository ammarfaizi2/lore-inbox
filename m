Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262101AbSITKa1>; Fri, 20 Sep 2002 06:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSITKa1>; Fri, 20 Sep 2002 06:30:27 -0400
Received: from ppp-217-133-217-84.dialup.tiscali.it ([217.133.217.84]:52942
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262101AbSITKa0>; Fri, 20 Sep 2002 06:30:26 -0400
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <3D8A6EC1.1010809@redhat.com>
References: <3D8A6EC1.1010809@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1jhhxx3CSYZtRYU8yWDm"
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 12:35:23 +0200
Message-Id: <1032518123.2024.6.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1jhhxx3CSYZtRYU8yWDm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Great, but how about using code similar to the following rather than
hand-coded asm operations?

extern struct pthread __pt_current_struct asm("%gs:0");
#define __pt_current (&__pt_current_struct)

#define THREAD_GETMEM(descr, member) (__pt_current->member)
#define THREAD_SETMEM(descr, member, value) ((__pt_current->member) =3D
value)
#define THREAD_MASKMEM(descr, member, mask) ((__pt_current->member) &=3D
mask)
...

Of course, it doesn't work if you try to take the address of a member.


--=-1jhhxx3CSYZtRYU8yWDm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ivnrdjkty3ft5+cRAmMSAJ9v470NIJzcj+54n1xTht8FSg40mACgx7Lh
Zkzp+pWyB9+bT0S1WbCd00U=
=U7hZ
-----END PGP SIGNATURE-----

--=-1jhhxx3CSYZtRYU8yWDm--
