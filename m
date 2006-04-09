Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWDIM5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDIM5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 08:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWDIM5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 08:57:06 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:46797 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750743AbWDIM5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 08:57:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: [PATCH] Staircase cpu scheduler v15 for 2.6.17-rc1*
Date: Sun, 9 Apr 2006 22:56:52 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1261907.opEz6yhXuD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604092256.56437.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1261907.opEz6yhXuD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Patches for the current staircase cpu scheduler (v15) for 2.6.17-rc1 are he=
re:

http://www.kernel.org/pub/linux/kernel/people/ck/patches/staircase/2.6.17-r=
c1/2.6.17-rc1-staircase-15.patch

and for mm2 here:

http://www.kernel.org/pub/linux/kernel/people/ck/patches/staircase/2.6.17-r=
c1/2.6.17-rc1-mm2/2.6.17-rc1-mm2-staircase-15.patch

Martin Bligh was kind enough to put the current version of staircase on=20
2.6.17-rc1 for testing on http://test.kernel.org/

Performance more or less parallels mainline 2.6.17-rc1 (apart from=20
interactivity as shown here previously where staircase mostly trumps=20
mainline).

Jens Axboe was also kind enough to do a kernbench run on 4xIA64 which also=
=20
showed no performance difference. See=20
http://article.gmane.org/gmane.linux.kernel.ck/5472 (the 2nd run is stairca=
se=20
and the attachments seem to be listed twice by gmane)

Just as a reminder of how much less code than the ever increasing complexit=
y=20
mainline scheduler staircase is, here is a diffstat of the patch for=20
2.6.17-rc1-mm2:

 fs/proc/array.c       |    4=20
 include/linux/sched.h |   20 -
 kernel/exit.c         |    1=20
 kernel/sched.c        |  987=20
++++++++++++++++----------------------------------
 4 files changed, 327 insertions(+), 685 deletions(-)

=2D-=20
=2Dck

--nextPart1261907.opEz6yhXuD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEOQSYZUg7+tp6mRURAiReAJ9VJ/VfU74VPP6OipKPa1z8r30WNACcCzPi
i99L7R7uIiwXwsEg8k6b1Ns=
=XXdF
-----END PGP SIGNATURE-----

--nextPart1261907.opEz6yhXuD--
