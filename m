Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284953AbRLZWBM>; Wed, 26 Dec 2001 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284940AbRLZWBC>; Wed, 26 Dec 2001 17:01:02 -0500
Received: from think.faceprint.com ([166.90.149.11]:55480 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S284950AbRLZWAx>; Wed, 26 Dec 2001 17:00:53 -0500
Date: Wed, 26 Dec 2001 17:00:31 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1
Message-ID: <20011226220031.GA10089@faceprint.com>
In-Reply-To: <Pine.LNX.4.21.0112261510230.9875-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112261510230.9875-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.24i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> - radeonfb update 				(Ani Joshi)

This seems to break the compile for radeonfb for me:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tr=
igraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mp=
referred-stack-boundary=3D2 -march=3Di686 -malign-functions=3D4     -c -o r=
adeonfb.o radeonfb.c
radeonfb.c: In function `radeon_save_state':
radeonfb.c:2283: `TMDS_TRANSMITTER_CNTL' undeclared (first use in this func=
tion)
radeonfb.c:2283: (Each undeclared identifier is reported only once
radeonfb.c:2283: for each function it appears in.)
radeonfb.c: In function `radeon_load_video_mode':
radeonfb.c:2560: `TMDS_RAN_PAT_RST' undeclared (first use in this function)
radeonfb.c:2561: `ICHCSEL' undeclared (first use in this function)
radeonfb.c:2561: `TMDS_PLLRST' undeclared (first use in this function)
radeonfb.c: In function `radeon_write_mode':
radeonfb.c:2650: `TMDS_TRANSMITTER_CNTL' undeclared (first use in this func=
tion)
radeonfb.c:2655: `LVDS_STATE_MASK' undeclared (first use in this function)
radeonfb.c: At top level:
radeonfb.c:2957: warning: `fbcon_radeon8' defined but not used
make[3]: *** [radeonfb.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

More info upon reuqest, but I wasn't able to find any reference to these
symbols anywhere outisde of radeonfb.c, so I don't think it's specific
to my setup.

Nathan


--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Kkh/PkYs3Ekt234RAoa3AKDXN8OElNmH2tfsbkpBo3yDfWjjmwCgwTyx
5PRrVSJgGCnsULnO4w0c1SY=
=b1vB
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
