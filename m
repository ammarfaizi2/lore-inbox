Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbVINLIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbVINLIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVINLIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:08:37 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:17543 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932720AbVINLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:08:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck4
Date: Wed, 14 Sep 2005 21:08:27 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10850559.afAUAQAYxh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509142108.29424.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10850559.afAUAQAYxh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck4/patch-2.6.13-ck4.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck4/patch-2.6.13-ck4-server=
=2Ebz2


web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.

Changes:

Added:

+hz-no250.patch
Setting HZ to 250 gives you the worst of both 100 and 1000 without any=20
advantage from either. Furthermore there are performance issues with dvd=20
burning (it seems) and unresolved issues with -ck, so this patch removes th=
e=20
option entirely to force 100 or 1000.

+vm-fix_background_scan.patch
A bug in the background scanning patch meant that if you had no highmem=20
enabled it would keep intermittently scanning indefinitely even if all memo=
ry=20
is balanced, slowly trashing cached ram.

+vm-sp5_sp6.patch
Swap prefetch code was deciding to do prefetching based on overall free=20
memory. This update makes it check every memory zone to ensure they all hav=
e=20
free memory before doing any prefetching.


Cheers,
Con

--nextPart10850559.afAUAQAYxh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKAStZUg7+tp6mRURAsMXAJ9Jgmr5QS2fUqy25XCf1phYaUkpugCfUyW7
yWQAqjAiolW0FTV9+lQhdRg=
=YXUQ
-----END PGP SIGNATURE-----

--nextPart10850559.afAUAQAYxh--
