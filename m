Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263189AbVGOEBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbVGOEBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbVGOEBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:01:53 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:29569 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263189AbVGOEBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:01:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Interbench v0.21
Date: Fri, 15 Jul 2005 14:01:47 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4619361.INqqX5YF38";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507151401.49854.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4619361.INqqX5YF38
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Interbech is a an application is designed to benchmark interactivity in Lin=
ux.

Version 0.21 update

http://ck.kolivas.org/apps/interbench/interbench-0.21.tar.bz2


Changes:

Changed the design to run the benchmarked and background loads as separate=
=20
processes that spawn their own threads instead of everything running as a=20
thread of the same process. This was suggested to me originally by Ingo=20
Molnar who noticed significant slowdown due to conflict over ->mm->mmap_sem=
,=20
invalidating the benchmark results when run in real time mode. This makes a=
=20
large difference to the latencies measured under mem_load particularly when=
=20
running real time benchmarks on a RT-PREEMPT kernel.

Accounting changes to max_latency to only measure the largest latency of a=
=20
single scheduling frame - this makes max_latency much smaller (and probably=
=20
more realistic). Often you may see max latency exactly one frame wide now=20
(consistent with one dropped frame) such as 16.7ms on video.

Minor cleanups.

Cheers,
Con

--nextPart4619361.INqqX5YF38
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1zUtZUg7+tp6mRURAnGzAJ4+qzBVkILu7t0dZ8QI4luhjUIFmgCfRDEq
nltEtGdwujn1eNZtFTyR71c=
=Ybep
-----END PGP SIGNATURE-----

--nextPart4619361.INqqX5YF38--
