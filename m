Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVDTNbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDTNbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDTNbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 09:31:34 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:56478 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261621AbVDTNb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 09:31:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [Patch] Staircase cpu scheduler v11
Date: Wed, 20 Apr 2005 23:31:36 +1000
User-Agent: KMail/1.8
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1459750.itdGdWmDYm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504202331.38752.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1459750.itdGdWmDYm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The staircase single priority array foreground/background cpu scheduler has=
=20
been updated to version 11.

Numerous minor behavioural issues have been abolished with a much cleaner=20
simple mathematical priority elevation/dropping mechanism and virtually no=
=20
"interactivity estimation" algorithms exist in the design. Behaviour across=
=20
all loads appears to have been improved with this.

Worst case latencies have been much improved with in-kernel work on behalf =
of=20
user processes being debited from the user processes.

Lots of micro-optimisations were added and throughput has improved.

All forms of gaming and audio issues appear to have been abolished.

A rolled up patch for 2.6.11 is here:
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11_to_staircase11.diff

and an incremental from 2.6.11-ck4 to staircase 11 is here:
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck4_to_staircase11.diff

The next -ck release will use this as its base.

Thanks to all the people testing this work and giving feedback.

Cheers,
Con

--nextPart1459750.itdGdWmDYm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCZlm6ZUg7+tp6mRURAlQAAJ9hVLGKzi5qnOdKEIe3ClrMiw858wCeN1oO
+BCM5e8MnwysppEncF85IfI=
=MLJW
-----END PGP SIGNATURE-----

--nextPart1459750.itdGdWmDYm--
