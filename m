Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312364AbSDCTZe>; Wed, 3 Apr 2002 14:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSDCTZU>; Wed, 3 Apr 2002 14:25:20 -0500
Received: from UX3.SP.CS.CMU.EDU ([128.2.198.103]:61329 "HELO
	ux3.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S312363AbSDCTY6>;
	Wed, 3 Apr 2002 14:24:58 -0500
Subject: Re: error compiling kernel for mips
From: Justin Carlson <justincarlson@cmu.edu>
To: Abdij Bhat <Abdij.Bhat@kshema.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10136FD5@BHISHMA>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+vLRZy0fRPBNM70sOsPX"
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 03 Apr 2002 14:24:05 -0500
Message-Id: <1017861846.1133.285.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+vLRZy0fRPBNM70sOsPX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-04-03 at 14:05, Abdij Bhat wrote:
> Hi,
>  When i try compiling the Kernel for mips i get errors. The kernel is 2.4=
.17
> downloaded from www.kernel.org. I have the mips developments environment
> set. I have (hopefully) the right headers and have modified the makefile =
to
> get the headers from those include directories.
>  My main problem is changing the architecture from arch686 ( mine ) to mi=
ps.
> How to i do this? What do i need to do inorder for the make to get the ri=
ght
> architecture? Or is there some other problem too?
>=20

Check out this line in the base level makefile:

ARCH :=3D $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e
s/arm.*/arm/ -e s/sa110/arm/)

This actually looks broken for cross-compile, but I haven't been
following the changes particularly closely...try using this instead:

ARCH :=3D mips

Really, though if you're compiling for mips you should probably grab the
mips-linux CVS sources here:

 cvs -d :pserver:cvs@oss.sgi.com:/cvs login
   (Only needed the first time you use anonymous CVS, the password is
"cvs")
   cvs -d :pserver:cvs@oss.sgi.com:/cvs co <repository>

There's a 2.4 tagged branch that's probably closer to what you want. You
can ask for mips-specific on linux-mips@oss.sgi.com, and you'll be much
more likely to get a prompt and useful answer.

-Justin


--=-+vLRZy0fRPBNM70sOsPX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8q1bV47Lg4cGgb74RApJ3AJ9PJdbL07wl8a+N4EpLC1B2ZH8TJQCgnl9F
CL232f4BX2cG7u0O5vIV0ro=
=t8ck
-----END PGP SIGNATURE-----

--=-+vLRZy0fRPBNM70sOsPX--

