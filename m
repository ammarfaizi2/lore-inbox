Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbSLDUK4>; Wed, 4 Dec 2002 15:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSLDUK4>; Wed, 4 Dec 2002 15:10:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21226 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267057AbSLDUKz>;
	Wed, 4 Dec 2002 15:10:55 -0500
Subject: recvfrom01, recvmsg01 LTP failures on 2.5
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-TY/Fx3VWYBm5XDYW6cHX"
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Dec 2002 14:10:10 -0600
Message-Id: <1039032611.3497.91.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TY/Fx3VWYBm5XDYW6cHX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

At some point between 2.5.46 and 2.5.47, the LTP tests for recvfrom01
and recvmsg01 began to fail.  The test common to both that is failing is
passing fromlen =3D=3D -1.  Calling recvfrom or recvmsg like this passes on
2.4 and 2.5.46, but returns -EINVAL on 2.5.47 and later.  If this was
intentional, I could understand it since that is certainly an invalid
argument for fromlen, but I would like to have that confirmed, and know
what the plans are for backporting that to 2.4.  I'll probably be
changing the test before the next ltp release (should be on Dec. 10),
but it will just flipflop from the test failing on 2.5 all the time to
failing on 2.4 all the time.

Thanks,
Paul Larson

--=-TY/Fx3VWYBm5XDYW6cHX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3uYSIACgkQbkpggQiFDqfvUACfcTSLrjDPXre3OhSBRQN83b+h
1zoAnAjqTWN3rTyRXe5XUJ5bDd1VhlZ7
=anPe
-----END PGP SIGNATURE-----

--=-TY/Fx3VWYBm5XDYW6cHX--

