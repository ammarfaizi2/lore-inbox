Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292300AbSBBPWE>; Sat, 2 Feb 2002 10:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292301AbSBBPVo>; Sat, 2 Feb 2002 10:21:44 -0500
Received: from fysh.org ([212.47.68.126]:19474 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S292300AbSBBPVg>;
	Sat, 2 Feb 2002 10:21:36 -0500
Date: Sat, 2 Feb 2002 15:21:35 +0000
From: Athanasius <Athanasius@gurus.tf>
To: Jim <jimd@starshine.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Jiffies from userspace
Message-ID: <20020202152134.GB19785@gurus.tf>
Mail-Followup-To: Athanasius <Athanasius@gurus.tf>,
	Jim <jimd@starshine.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020201123321.A799@mars.starshine.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20020201123321.A799@mars.starshine.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2002 at 12:33:21PM -0800, Jim wrote:
>  reasonable way to get an estimate of the "current" value of the=20
>  kernel's jiffies:
>=20
>  	set -- `cat /proc/self/stat`; echo ${22}
>=20
>  The cat will start a new process, field 22? of its "stat" node=20
>  under proc should have the jiffies value at the time the process
>  was started; so the echo command execute "shortly" thereafter.
>=20
>  But am I right about the struct of stat:  Is that really in ${22}?

   Assuming so try:

	awk '{print $22}' /proc/self/stat

for a 'single process' version.

-Ath
--=20
- Athanasius =3D Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjxcA/4ACgkQzbc+I5XfxKe6/ACfR4QJiDyFWw9yj6b7BX4lMPv7
7HwAniLBhg1DQ+BkV3kT2VcwjEHDE41N
=t9uT
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
