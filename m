Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUGPMBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUGPMBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUGPMBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 08:01:14 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:12189 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266345AbUGPMBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 08:01:11 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Fri, 16 Jul 2004 08:01:10 -0400
To: linux-kernel@vger.kernel.org
Subject: observations of swsusp and s3
Message-ID: <20040716120110.GA26122@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1. using kernel 2.6.7 on my dell inspiron 3800, i've noticed that the=20
clock that assigns start times to processes is running behind, and i=20
suspect it could have something to do with having suspended (s4) the=20
machine:

john@density:~$ date
Fri Jul 16 07:42:29 EDT 2004
john@density:~$ ps u | grep ps
john      4194  0.0  0.2  2528  848 pts/11   R+   Jul15   0:00 ps u
john      4195  0.0  0.1  1576  460 pts/11   S+   Jul15   0:00 grep ps

2. swsusp will fail to get free enough space if laptop_mode is
enabled.  disabling laptop_mode (in /proc/sys) before s4
suspending allows it to work.  i was pretty sure it should have
worked, since i only have 384M ram and i saw 600M swap free.

3. when swsusp was broken, i found that s3 actually worked for
the most part.  my script switches from my x session on vt7 to
vt12, suspends, and when it resumes, i have it chvt back to 12.
this enabled the display again nicely.  if i try to switch to a
console login (vt1-6), they're completely black.  closing the
lcd lid and reopening it turns it back on, so it's _really_
close to functioning nicely.

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA98OGCGPRljI8080RAvHhAJ9DVzy5qQPni+N0PZu83WWracYqfgCfYaMJ
sQs2ota+PxVHXxbNrxSO/6k=
=rxlu
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
