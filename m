Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271247AbRIDDSx>; Mon, 3 Sep 2001 23:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271880AbRIDDSn>; Mon, 3 Sep 2001 23:18:43 -0400
Received: from sephiroth.nwc.alaska.net ([209.112.130.27]:2672 "EHLO
	alaska.net") by vger.kernel.org with ESMTP id <S271247AbRIDDSf>;
	Mon, 3 Sep 2001 23:18:35 -0400
Date: Mon, 3 Sep 2001 19:18:49 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linux-kernel@vger.kernel.org
Subject: nfs client serious problems under 2.2.20pre8/9
Message-ID: <20010903191849.D14519@plato.local.lan>
Mail-Followup-To: Ethan Benson <erbenson@alaska.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Debian GNU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I have encountered a serious problem with nfs under 2.2.20pre8 and
pre9.

after some ammount of time (2 weeks under pre8, only a few hours under
pre9) most/all processes accessing an nfs filesystem go into
unkillable disk sleep, and the kernel starts spewing:

kernel: nfs: task 22509 can't get a request slot

over and over again endlessly.  since processes using the filesystem
are unkillable i am unable to even forcabily umount the problematic
filesystem, seemingly the only way restore order is shutdown -r now :(

the server is an x86 running 2.2.19, knfs, with userland utils
version 0.3.1.  the client is a powerpc running 2.2.20pre8 or pre9,
both exhibit this behavior.  2.2.19 on the client does NOT exhibit
this problem.

note that this seems to mostly get triggered on my daily cronjobs,
which simply tar up /etc to a tarball on the nfs filesystem, its
really not that intensive (/etc is only about 2.6MB or so). i have
other machines doing the same thing without incident (they are
currently running 2.4.9).

the server displays no unusal symtoms or any log entries that would
indicate trouble.

both client and server are using NFSv3.

please CC me any replies as i am not subscribed to l-k.  thanks.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuUSBkACgkQJKx7GixEevz9igCeIXXFNkNxZB1ieLXCRvMPfHi0
zBEAnjYi9Y+JpF2iC3B1REEpi/ImWwiX
=yWJu
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
