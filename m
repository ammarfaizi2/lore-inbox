Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSLQMpe>; Tue, 17 Dec 2002 07:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265019AbSLQMpe>; Tue, 17 Dec 2002 07:45:34 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:31426
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265008AbSLQMpd>; Tue, 17 Dec 2002 07:45:33 -0500
Subject: Re: 2.4.20 copy_from/to_user
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20021217112614.00b55eb0@pop.t-online.de>
References: <4.3.2.7.2.20021217112614.00b55eb0@pop.t-online.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sjR02yAnPyL18LZRpY+g"
Organization: 
Message-Id: <1040129576.1768.14.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 17 Dec 2002 12:52:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sjR02yAnPyL18LZRpY+g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-12-17 at 10:42, Margit Schubert-While wrote:
> Maybe talking through the top of my hat , however -
> copy_from_user and copy_to_user are used all over the place and the
> return tested to see if an EFAULT should be generated.
> Looking at include/asm-i386/uaccess.h and arch/i386/lib/usercopy.c
> I don't see how these return anything but the 3rd (length) param.

Kernel glibly copies data until a exception occurs, when that happens it
looks at the address of the faulting instruction and jumps to some fixup
code, which somehow makes the function returns the truncated value.

grep for ".section .fixup" and ".section .__ex_table." in those files.

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-sjR02yAnPyL18LZRpY+g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9/x4okbV2aYZGvn0RAoQWAJsHMAfntBtpPRzlhQAgRIWpRyMoRQCbBl39
FzuW35irxezjkywnMN5nwKs=
=fYa3
-----END PGP SIGNATURE-----

--=-sjR02yAnPyL18LZRpY+g--

