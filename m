Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSKHVzC>; Fri, 8 Nov 2002 16:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSKHVzC>; Fri, 8 Nov 2002 16:55:02 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:53722 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262452AbSKHVzB>; Fri, 8 Nov 2002 16:55:01 -0500
Subject: recvfrom/recvmsg
From: Paul Larson <plars@linuxtestproject.org>
To: davem@redhat.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ueMAKsOMP4mck2nOhjk0"
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Nov 2002 15:59:24 -0600
Message-Id: <1036792764.17557.24.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ueMAKsOMP4mck2nOhjk0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


I was looking through the ltp test recvfrom01 and saw that test #4 is
failing where it did not used to fail.  I think the test program is
partially at fault here since it was expecting it to pass when you call
recvfrom with fromlen =3D=3D -1.

Right now (2.5.46-bk current) I'm getting -1, errno 22 returned, but in
2.5.46 it was passing without error.  Was this change intentional
(probably) and is that the correct errno to return.  I checked SuS, but
I don't see anything related to that exact condition.

There is another test in the same program that also looks like it should
be failing.  Recvfrom, testcase 3 tries to do a recvfrom with (struct
sockaddr *)-1 passed as the from buffer.  Right now, it is passing
without an error, but that doesn't seem correct.

The same exact situation happens in recvmsg01.

Thanks,
Paul Larson


--=-ueMAKsOMP4mck2nOhjk0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3MM7wACgkQbkpggQiFDqcYpQCgiNxaIbwczWFaXGLpZDKDplQX
U9kAn1huh5tGsLtgI6N4L9437+x5rLdD
=V7SE
-----END PGP SIGNATURE-----

--=-ueMAKsOMP4mck2nOhjk0--

