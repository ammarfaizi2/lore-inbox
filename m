Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVAPSeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVAPSeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVAPSeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:34:09 -0500
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:51374 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S262561AbVAPSeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:34:03 -0500
Date: Sun, 16 Jan 2005 19:33:56 +0100
From: Kristian Eide <kreide@online.no>
Subject: Re: raid5 crash (possible VM problem???)
In-reply-to: <16857.54682.183762.561368@cse.unsw.edu.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <200501161933.59701.kreide@online.no>
MIME-version: 1.0
Content-type: multipart/signed; boundary=nextPart1302866.K5r9HLpeFn;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-transfer-encoding: 7bit
References: <200412222304.36585.kreide@online.no>
 <200412232045.26137.kreide@online.no>
 <16857.54682.183762.561368@cse.unsw.edu.au>
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1302866.K5r9HLpeFn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> You could try this patch.  It might hide the real problem, or it might
> cause it to manifest in some other way.

I've applied the patch, but I now get another error; this might not be rela=
ted=20
to raid5, however, I have tested the individual SATA disks without getting=
=20
any errors. This only happens when combining them into a raid5 array (other=
=20
raid levels not tested).

ReiserFS: md3: journal params: device md3, size 8192, journal first block 1=
8,=20
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md3: checking transaction log (md3)
ReiserFS: md3: Using r5 hash to sort names
attempt to access beyond end of device
md3: rw=3D0, want=3D18446744063991695384, limit=3D1465175040
attempt to access beyond end of device
md3: rw=3D0, want=3D18446744062355374704, limit=3D1465175040
attempt to access beyond end of device
md3: rw=3D0, want=3D4913837584, limit=3D1465175040
attempt to access beyond end of device
md3: rw=3D0, want=3D18446744071656162744, limit=3D1465175040

I have 4 250GB SATA disk combined into one raid5 volume (kernel 2.6.10), an=
d=20
this error happens after copying a few gigabytes of data into the volume an=
d=20
then trying to read them back.

=2D-=20
Kristian

--nextPart1302866.K5r9HLpeFn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB6rOXRBuET7ul/ccRAgSFAJ45ZChXxUGMDpCIi/uww8HaKnxcFwCgr4FI
BDSvZwlgC0/iAGBOIVkRBAk=
=db1K
-----END PGP SIGNATURE-----

--nextPart1302866.K5r9HLpeFn--
