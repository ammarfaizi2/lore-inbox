Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVG0LLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVG0LLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVG0LLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:11:33 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:13228 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261999AbVG0LLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:11:32 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.12-ck4
Date: Wed, 27 Jul 2005 21:11:25 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
X-Length: 1470
Content-Type: multipart/signed;
  boundary="nextPart8022134.38GPnJ8k9g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507272111.27757.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8022134.38GPnJ8k9g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.12 (This includes all patches in 2.6.12.3):
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck4/patch-2.6.12-ck4.bz2
or for server version:
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck4/patch-2.6.12-ck4-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.12-ck3:

Added:
+s11.3_s11.4.diff=20
Staircase cpu scheduler update. Change rr intervals to 5ms minimum. With=20
interbench I can confidently say there is objective evidence of interactive=
=20
improvement in the human perceptible range with this change :)

HZ-864.diff=20
+My take on the never ending config HZ debate. Apart from the number not be=
ing=20
pleasing on the eyes, a HZ value that isn't a multiple of 10 is perfectly=20
valid. Setting HZ to 864 gives us very similar low latency performance to a=
=20
1000HZ kernel, decreases overhead ever so slightly, and minimises clock dri=
ft=20
substantially. The -server patch uses HZ=3D82 for similar reasons, with the=
=20
emphasis on throughput rather than low latency. Madness? Probably, but then=
 I=20
can't see any valid argument against using these values.


Changed:
=2Dpatch-2.6.12.2
+patch-2.6.12.3
Latest stable version.

=2D2612ck3-version.diff
+2612ck4-version.diff
Version.


Cheers,
Con

--nextPart8022134.38GPnJ8k9g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC52vfZUg7+tp6mRURAm15AJ9hd89Wq2vOJ/vbO2nEBSXkjtIO9wCffGhb
wRw2KlH8tsoboPKYBPS3UKo=
=j8we
-----END PGP SIGNATURE-----

--nextPart8022134.38GPnJ8k9g--
