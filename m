Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVG2DLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVG2DLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVG2DLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:11:33 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:60134 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262324AbVG2DKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:10:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Interbench v0.24
Date: Fri, 29 Jul 2005 13:10:39 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2847266.mMtGltg7qz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507291310.42203.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2847266.mMtGltg7qz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Interbench is a Linux Kernel Interactivity Benchmark.

Direct download:
http://ck.kolivas.org/apps/interbench/interbench-0.24.tar.bz2
Web:
http://interbench.kolivas.org

Changes:
3 new loads were added:

Gaming benchmark:
This simulates an unlocked frame rate cpu intensive 3d gaming environment. =
It=20
measures the latencies mean/sd/max and desired cpu percentage only. These=20
should give a marker of frame rate stability (latencies), and maximum frame=
=20
rates under different loads (desired cpu percentage). As this simulates an=
=20
unlocked frame rate the deadlines met is meaningless. This does not=20
accurately emulate a 3d game which is gpu bound, only a cpu bound one.

Hackbench:
Taken from Rusty's hackbench code as suggested by Ingo Molnar, this will ru=
n=20
'hackbench 50' repeatedly in the background when benchmarking real time=20
performance.

Custom:
Based on the periodic scheduling used for audio/video, custom will allow yo=
u=20
to specify a cpu percentage and frame rate of a custom workload, and this c=
an=20
be used to benchmark this workload's performance under normal scheduling,=20
real time scheduling or it can be used as a background load.


Bugfixes:
Numerous floating point and overflow errors were tracked down and fixed. Th=
ese=20
are responsible for results like 'nan' and 4294... which is basically 2^32.=
=20
Unfortunately the standard deviation reported in previous versions appears =
to=20
have been bogus, but fortunately little value was placed on this result.

Error handling was made _much_ more robust - for example it was found that=
=20
contrary to 'man sem_wait' but consistent with SUSv3, sem_wait can return -=
1=20
with -EINTR.

Lots of little tweaks.


Cheers,
Con

--nextPart2847266.mMtGltg7qz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC6Z4yZUg7+tp6mRURAsVEAJ9JMFbqbyJMiUl6Y4xp0fiOLsfemgCfUaB+
b8sWjg8AM8iJUHN3Ol7mOkE=
=IZkx
-----END PGP SIGNATURE-----

--nextPart2847266.mMtGltg7qz--
