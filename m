Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTHVNkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbTHVNkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 09:40:21 -0400
Received: from mx02.qsc.de ([213.148.130.14]:22146 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S263154AbTHVNkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 09:40:11 -0400
Date: Fri, 22 Aug 2003 15:41:37 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]O18int
Message-ID: <20030822134136.GA711@gmx.de>
References: <200308222231.25059.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <200308222231.25059.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test3-O18 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2003 at 10:31:20PM +1000, Con Kolivas wrote:
Content-Description: clearsigned data
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Here is a small patchlet.
>=20
> It is possible tasks were getting more sleep_avg credit on requeuing than=
 they=20
> could burn off while running so I've removed the on runqueue bonus to=20
> requeuing task.=20
>=20
> Note this applies onto O16.3 or 2.6.0-test3-mm3 as O17 was dropped.
>=20
> This patch is also available here along with a patch against 2.6.0-test3:
> http://kernel.kolivas.org/2.5
>=20
> Con

this patch still makes my xmms skip on light io load (untar kernel
source, open lkml mailbox folder) while opening mozilla. Even after
mozilla is there xmms is still skipping. Processes take ages to spawn.
And no, I'm not in swap. A 'su -'is taking 10 seconds to procceed.
Same applies when rm -Rf'ing a kernel tree.
Here is some more data for the curious:

15:38:55  cpu %usr %sys %nice %idle pswch/s runq nrproc lavg1 lavg5 avg15 _=
cpu_
15:38:56  all   26    9     0    66    1730    3    115 11.58  7.87 3.44
15:38:57  all    8    4     0    88    1137    1    115 11.58  7.87 3.44
15:38:58  all   10    4     0    86    1204    1    115 11.58  7.87 3.44
15:38:59  all    6    5     0    89    1002    1    115 11.58  7.87 3.44
15:39:00  all    5    4     0    91    1219    1    115 11.58  7.87 3.44
15:39:01  all    9    4     0    87    1748    1    115 11.69  7.95 3.49

kakerlak:/home/wiktor# vmstat 1 100
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu-=
---
r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id =
wa
4  8      0   2520  12644 103924    0    0  2325   665 1358  1803 22 8 11 60
0 10      0   2348  12608 103988    0    0  2208  1390 1436  1672 17 6  0 77
0 13      0   2532  12556 103728    0    0  1548  1153 1292  1138  9 4  0 87
0  6      0   2588  12564 103700    0    0  1516  1861 2039  1593 9  4  0 87
0 11      0   2420  12560 103756    0    0   840   817 1267  1339 5  4  0 91
0 10      0   2036  12608 104012    0    0  1248   941 1330  1879 10  6  0 =
84
0  8      0  17820  12620 103160    0    0    28   744 1260 1609 12  2  0 86
0  7      0   7448  12708 113636    0    0  8264   593 1418 2451 56 14  0 30
2  7      0   2116  12840 118912    0    0  3232   830 1649 3050 20 11  0 70
0 15      0   2364  12832 118380    0    0   452   822 1397 577  4  3  0 93
0  9      0   2564  12840 118176    0    0  1352  1076 1303 812 12  3  0 85
0 12      0   2692  12844 118004    0    0  1924  1252 1553 1200 18  3  0 79

note the load of 11. I can even get it to 30 while doing 3 tar xf
bla.tar simultanously.

I'm going to fetch some fish in the next two weeks in poland, so I will
not be able to do any more testing from sunday on. Happy coding (while I
stick to O10 *g*)

--=20
Regards,

Wiktor Wodecki

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Rh2Q6SNaNRgsl4MRAgrfAKCd2qFNSEGtMRAVCAKQyZMlikxMBwCfQwTi
hokhA9+55X3QuWg/q2DpUR4=
=DYCZ
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
