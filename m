Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbTCTQVK>; Thu, 20 Mar 2003 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCTQVJ>; Thu, 20 Mar 2003 11:21:09 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:60176 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261607AbTCTQVH>;
	Thu, 20 Mar 2003 11:21:07 -0500
Date: Thu, 20 Mar 2003 17:32:07 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320163207.GH28454@lug-owl.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <3E78D0DE.307@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r21wuLfwIlf/vvzy"
Content-Disposition: inline
In-Reply-To: <3E78D0DE.307@zytor.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r21wuLfwIlf/vvzy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-19 12:19:42 -0800, H. Peter Anvin <hpa@zytor.com>
wrote in message <3E78D0DE.307@zytor.com>:
> Hello everyone,
>=20
> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.

However, please keep in mind that it's a *PITA* if you're working on a
machine with not > 500MHz and > 128MB RAM:

jbglaw@schnarchnase:/tmp$ ls -l linux-2.5.65.tar.*
-rw-r--r--    1 jbglaw   jbglaw   31889910 Mar 20 11:37
linux-2.5.65.tar.bz2
-rw-r--r--    1 jbglaw   jbglaw   39711645 Mar 20 11:44
linux-2.5.65.tar.gz
jbglaw@schnarchnase:/tmp$ time tar xjf linux-2.5.65.tar.bz2

real    194m21.665s
user    172m55.026s
sys     14m19.018s
jbglaw@schnarchnase:/tmp$ mv linux-2.5.65 linux-2.5.65xx
jbglaw@schnarchnase:/tmp$ time tar xzf linux-2.5.65.tar.gz

real    39m39.294s
user    22m32.306s
sys     13m56.524s
jbglaw@schnarchnase:/tmp$ free
             total       used       free     shared    buffers     cached
Mem:         10100       9792        308          0        952       5232
-/+ buffers/cache:       3608       6492
Swap:       292816       1484     291332
jbglaw@schnarchnase:/tmp$ cat /proc/cpuinfo=20
processor       : 0
vendor_id       : UMC UMC UMC=20
cpu family      : 4
model           : 2
model name      : ff/02
stepping        : 3
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : no
fpu_exception   : no
cpuid level     : 1
wp              : yes
flags           :
bogomips        : 15.10

jbglaw@schnarchnase:/tmp$ uname -a
Linux schnarchnase 2.5.65 #1 Thu Mar 20 07:39:11 CET 2003 i486 unknown unkn=
own GNU/Linux


MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--r21wuLfwIlf/vvzy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ee0GHb1edYOZ4bsRAqhHAKCTZESGMa5OdN8u69epAXn1Io4wIACZARHG
LBbibkJeGc7tLrOXu31glJ8=
=ZJ1C
-----END PGP SIGNATURE-----

--r21wuLfwIlf/vvzy--
