Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268039AbTBSInC>; Wed, 19 Feb 2003 03:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268079AbTBSInC>; Wed, 19 Feb 2003 03:43:02 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:7688 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S268039AbTBSInB>;
	Wed, 19 Feb 2003 03:43:01 -0500
Date: Wed, 19 Feb 2003 09:53:03 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: alpha: Hangcheck timer doesn't compile
Message-ID: <20030219085303.GJ351@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DGxvIoidHXI3RiT5"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DGxvIoidHXI3RiT5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

The hangcheck timer seems cannot be compiled on Alphas:

  gcc -Wp,-MD,drivers/char/.hangcheck-timer.o.d -D__KERNEL__ -Iinclude -Wal=
l -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -=
pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=3Dev4 -Wa,-mev6 -fomit-frame=
-pointer -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=3Dhangch=
eck_timer -DKBUILD_MODNAME=3Dhangcheck_timer -c -o drivers/char/hangcheck-t=
imer.o drivers/char/hangcheck-timer.c
drivers/char/hangcheck-timer.c: In function `hangcheck_init':
drivers/char/hangcheck-timer.c:112: `current_cpu_data' undeclared (first us=
e in this function)
drivers/char/hangcheck-timer.c:112: (Each undeclared identifier is reported=
 only once
drivers/char/hangcheck-timer.c:112: for each function it appears in.)
make[3]: *** [drivers/char/hangcheck-timer.o] Error 1
make[2]: *** [drivers/char] Error 2
make[1]: *** [drivers] Error 2
make: *** [modules] Error 2

This is because current_cpu_data doesn't (currently) exist on alpha.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--DGxvIoidHXI3RiT5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+U0XvHb1edYOZ4bsRAqzFAJ9ySAUes7/Z5X0hegkpjs1gwAIMFQCeNbCb
0tW+MB6qakbEZZbBXq7mC18=
=ZQ6r
-----END PGP SIGNATURE-----

--DGxvIoidHXI3RiT5--
