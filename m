Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVIWMFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVIWMFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 08:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVIWMFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 08:05:06 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:236 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750898AbVIWMFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 08:05:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck6
Date: Fri, 23 Sep 2005 22:04:49 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2502051.V4JnRGGhtg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509232204.52910.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2502051.V4JnRGGhtg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


THIS INCLUDES ALL THE PATCHES IN 2.6.13.2 SO YOU SHOULD START WITH 2.6.13 T=
O=20
USE THESE PATCHES

Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck6/patch-2.6.13-ck6.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck6/patch-2.6.13-ck6-server=
=2Ebz2

*prefetching should still be considered experimental*
I appreciate the extensive testing it is receiving!

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
+sched-iso_tunables.patch
Add a tunable in /proc/sys/kernel/iso_cpu to allow you to set the amount of=
=20
cpu that SCHED_ISO tasks run realtime. It is 70% by default on -ck and 0% b=
y=20
default on -ckserver.

+ck5_sp11.patch
Massive update to the swap prefetching code to version 11. This makes the=20
decision when to prefetch far more intelligent, the cost of the code much=20
cheaper on SMP/preempt, fixes bugs, and substantially decreases the risk of=
=20
the code causing out-of-memory conditions. The code is very safe and stable=
=20
and quite effective. The incidence of regressions has dropped dramatically=
=20
now but it still does need more testing.


Removed:
=2Dper-task-predictive-write-throttling-1.patch
This patch is causing as yet not well understood problems with I/O pauses s=
o=20
it has been removed till it is developed and tested further in -mm.


Modified:
=2D2613ck5-version.diff
+2613ck6-version.diff
Version update


Cheers,
Con

--nextPart2502051.V4JnRGGhtg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDM+9kZUg7+tp6mRURAjEBAJ9OPZblvS9qgrwmn1bknjdtraSDxQCfWENr
z61wUK3VILHRiHScp+W+qfs=
=LAd3
-----END PGP SIGNATURE-----

--nextPart2502051.V4JnRGGhtg--
