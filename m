Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUFZXVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUFZXVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFZXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:21:14 -0400
Received: from ftp.nuit.ca ([66.11.160.83]:54666 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S266443AbUFZXVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:21:09 -0400
Date: Sat, 26 Jun 2004 23:21:06 +0000
From: simon@nuit.ca
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot access '/dev/pts/292': Value too large for defined data type
Message-ID: <20040626232104.GA32365@nuit.ca>
References: <20040626151108.GA8778@nuit.ca> <20040626135948.7b4396e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20040626135948.7b4396e9.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040523i
X-Scan-Signature: smtp.nuit.ca 1BeMTq-0008SP-Mj 6d155ee43afc8b798cf6b81b3511493e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ce jour Sat, 26 Jun 2004, Andrew Morton a dit:

> simon@nuit.ca wrote:
> >
> > whenever i try open a new pseudo-pty, i get a similar message to=20
> >  the one in the subject, and one like "fstat: Value too large for defin=
ed data
> >  type" if i open an xterm.
>=20
> It appears that you're using some variant of the 2.6.7 kernel, yes?

yup, just pure mainline, no patches.

> That kernel (and many preceding ones) will create large pty indexes and o=
ld
> (and/or buggy) userspace fails to handle it correctly.

ok, i suspected the user space stuff would puke on that, thanks.

> Post-2.6.7, the allocation of pty indexes was switched to first-fit and
> things should now work OK.

oh good news - thank you very much :).

> Please test a current kernel and send a report.
>=20
> 2.6.7 plus
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.7-bk9.gz
> would be suitable.

ok. as soon as i can. move it up on my mental TODO list =3D).

BTW, thanks go to all the kernel hackers and patch submitters (and
anyone else that works on or for the kernel :), for doing
such a good job, it's appreciated.



--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQGVAwUBQN4E3mqIeuJxHfCXAQKtUQv+OzE+4SlyJuwHEWZbnphiitaIe8jngsC8
rkFQYTNw9m20JfLwDrLhy4gdELy1CUPtHIALBEfMRjrrnHjT3Vnxe55EIoh7u/oz
BwWjwcO7EAPv/C02Ih81PKdoztafUiA0qhlrZ1yQJSD9OxxadIPdeqfICAdQiOAK
qJnoTUNYx29fpXXZtmWTxdER5oe6NIgNHqKpmqENDmAmJ2w8J8RL0gn6VfoRmwjH
g9Wz0iYXIUXav5skSVXE6Hs0A1rfJf5DmyAPh8skJSCVzkzp4r3GWZwB//CL38hi
DQpKyWxzLgTEfj/mYB+eGJlx5VOJUYqUa5q/R+pwlejq3PO8cJjmoAcEn5/sjGck
hcpoexS2hrWCE9MqDImapV3OVnIhFJHeMKr/FBincEeNW+roRHUNvnoE3W4U+rma
c757/u3nPcBme+uqlAG6LcCoitcGveuGbMYP3oWr7x31a8TFIYkAwWx/eW/Apfh3
gpfrMgzZCNBMbtYdymp/oxBC/agis1/e
=iIBD
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
