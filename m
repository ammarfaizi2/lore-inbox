Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289367AbSAOCyA>; Mon, 14 Jan 2002 21:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289370AbSAOCxu>; Mon, 14 Jan 2002 21:53:50 -0500
Received: from florin.dsl.visi.com ([209.98.146.184]:64593 "HELO
	beaver.iucha.org") by vger.kernel.org with SMTP id <S289367AbSAOCxq>;
	Mon, 14 Jan 2002 21:53:46 -0500
Date: Mon, 14 Jan 2002 20:53:38 -0600
To: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre3-ac2 performance regression(?) vs. 2.4.17
Message-ID: <20020115025337.GC1226@iucha.net>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rik, Alan,

I have downloaded 2.4.18-pre3-ac2 out of curiosity for the VM and IDE
performance.

As a "benchmark" I ran hdparm -Tt /dev/hda. The results were surprising:

2.4.17

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.86 seconds =3D148.84 MB/sec
 Timing buffered disk reads:  64 MB in  3.95 seconds =3D 16.20 MB/sec

 Timing buffer-cache reads:   128 MB in  0.90 seconds =3D142.22 MB/sec
 Timing buffered disk reads:  64 MB in  4.05 seconds =3D 15.80 MB/sec

 Timing buffer-cache reads:   128 MB in  0.88 seconds =3D145.45 MB/sec
 Timing buffered disk reads:  64 MB in  4.00 seconds =3D 16.00 MB/sec

2.4.18-pre3-ac2

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.99 seconds =3D129.29 MB/sec
 Timing buffered disk reads:  64 MB in  3.90 seconds =3D 16.41 MB/sec

 Timing buffer-cache reads:   128 MB in  0.93 seconds =3D137.63 MB/sec
 Timing buffered disk reads:  64 MB in  4.03 seconds =3D 15.88 MB/sec

 Timing buffer-cache reads:   128 MB in  0.92 seconds =3D139.13 MB/sec
 Timing buffered disk reads:  64 MB in  3.90 seconds =3D 16.41 MB/sec

So while I see a slight (un)expected improvement in IDE performance, I
also see a degradation in memory? performance.

The box is a PIII/700MHz laptop with 256 Mb RAM. hdparm is version 4.5

Cheers,
florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Q5mxNLPgdTuQ3+QRAoNzAJ9Konb60zotaSRlPqbznMq+LNQZ3wCfdxWJ
S3cBEZ6va04HfA+I6x13xXE=
=SmVz
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
