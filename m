Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbSKLWHt>; Tue, 12 Nov 2002 17:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSKLWHs>; Tue, 12 Nov 2002 17:07:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36016 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266975AbSKLWHm>;
	Tue, 12 Nov 2002 17:07:42 -0500
Subject: LTP - gettimeofday02 FAIL
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Rdp/Zx/T+Qk2cY6A8sMP"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Nov 2002 16:11:14 -0600
Message-Id: <1037139074.10626.37.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rdp/Zx/T+Qk2cY6A8sMP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been getting a somewhat random error in a few of the recent 2.5
kernels with SMP machines.  I noticed this on a 2.5.47 bk pull, but I
was also able to reproduce it on 2.5.46.  I haven't tried any earlier
kernels yet.  The LTP gettimeofday02 test sometimes fails with this
message:
gettimeofday02    0  INFO  :  checking if gettimeofday is monotonous,
takes 30s
gettimeofday02    1  FAIL  :  Time is going backwards (old
1037138184.846333 vs new 1037138184.843346!

I have not been able to reproduce this on a single processor machine
though.

Basically, all the test does is:
gettimeofday(&tv1, NULL);
while(!done) {
	gettimeofday(&tv2, NULL);
	FAIL if tv2 < tv1
	tv1 =3D tv2;
}

Any ideas on what could be causing this?

Thanks,
Paul Larson

--=-Rdp/Zx/T+Qk2cY6A8sMP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3RfIIACgkQbkpggQiFDqfoKACfQuIXZxqa2VbHEoXrMxboHcHM
N3MAn2qie9TzkZ3EUn+8cjNVmOklYT7D
=8CoB
-----END PGP SIGNATURE-----

--=-Rdp/Zx/T+Qk2cY6A8sMP--

