Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTJJIUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTJJIUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:20:14 -0400
Received: from [64.5.56.18] ([64.5.56.18]:426 "EHLO pico.surpasshosting.com")
	by vger.kernel.org with ESMTP id S262633AbTJJIUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:20:04 -0400
Date: Fri, 10 Oct 2003 03:20:02 -0500
From: Chris Cheney <ccheney@cheney.cx>
To: linux-kernel@vger.kernel.org
Subject: hpt366 driver still has very poor performance
Message-ID: <20031010082002.GB2394@cheney.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - conr-adsl-cheney.txucom.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am following up to my post on August 27. This bug is also filed at

http://bugme.osdl.org/show_bug.cgi?id=3D1217


I did some more tests and the bug still exists in 2.6.0-test7-bk1. I found=
=20
that running the hpt372 with a 40pin cable ATA33 is roughly twice as fast f=
or=20
writes as using the 80pin cable ATA133, there is something definitely wrong=
=20
here. Both modes are significantly slower than when using the same 80pin ca=
ble=20
ATA100 on the Intel ICH5 controller.=20
=20
BTW - I think the ICH5 driver has a problem as well. When I tried to use th=
e=20
same 40pin cable I used for the hpt372, to test ATA33 mode, the kernel spit=
=20
out a lot of messages about CRC errors.=20

=20
Chris Cheney



hpt372 bios 2.35 40pin cable=20
----------------------------=20
Version  1.03       ------Sequential Output------ --Sequential Input- --Ran=
dom-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --See=
ks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec=
 %CP
calc             2G 18668  66 19857   7 10159   3 19851  59 30713   3 186.5=
   0
                    ------Sequential Create------ --------Random Create----=
----
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Dele=
te--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec=
 %CP
                 16  3182  98 +++++ +++ +++++ +++  3098  94 +++++ +++  8743=
  99
calc,2G,18668,66,19857,7,10159,3,19851,59,30713,3,186.5,0,16,3182,98,+++++,=
+++,+++++,+++,3098,94,+++++,+++,8743,99



hpt372 bios 2.35 80pin cable=20
----------------------------
Version  1.03       ------Sequential Output------ --Sequential Input- --Ran=
dom-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --See=
ks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec=
 %CP
calc             2G  9689  34  9252   3  7228   2 20321  61 43606   4 189.8=
   0
                    ------Sequential Create------ --------Random Create----=
----
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Dele=
te--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec=
 %CP
                 16  3113  95 +++++ +++ +++++ +++  3107  94 +++++ +++  7596=
  85
calc,2G,9689,34,9252,3,7228,2,20321,61,43606,4,189.8,0,16,3113,95,+++++,+++=
,+++++,+++,3107,94,+++++,+++,7596,85



ich5 80pin cable=20
----------------
Version  1.03       ------Sequential Output------ --Sequential Input- --Ran=
dom-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --See=
ks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec=
 %CP
calc             2G 27586  98 48814  19 21368   6 24561  74 51393   4 185.2=
   0
                    ------Sequential Create------ --------Random Create----=
----
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Dele=
te--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec=
 %CP
                 16  3211  99 +++++ +++ +++++ +++  3241  99 +++++ +++  8650=
 100
calc,2G,27586,98,48814,19,21368,6,24561,74,51393,4,185.2,0,16,3211,99,+++++=
,+++,+++++,+++,3241,99,+++++,+++,8650,100


--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hmuy0QZas444SvIRAiS/AKCln/2VIe/QvN/djsd4F2JZGM4EJACgnuKm
q8cB7MT6EO9aBTOgklMjLS8=
=ZNd0
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
