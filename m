Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUFKNLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUFKNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUFKNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:11:25 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:18316 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263893AbUFKNLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:11:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH] x86_64: remove duplicate COMPATIBLE_IOCTL lines
Date: Fri, 11 Jun 2004 15:10:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_N9ayAwHjnmPJFst";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111510.37981.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_N9ayAwHjnmPJFst
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Some of the ioctl numbers in ia32_ioctl are already defined in
include/linux/compat_ioctl.h, so they can be removed here.
Maybe we should have a runtime check for duplicate numbers?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D arch/x86_64/ia32/ia32_ioctl.c 1.41 vs edited =3D=3D=3D=3D=3D
=2D-- 1.41/arch/x86_64/ia32/ia32_ioctl.c	Sun May 30 21:49:35 2004
+++ edited/arch/x86_64/ia32/ia32_ioctl.c	Sat Jun  5 12:14:36 2004
@@ -171,23 +171,8 @@
 COMPATIBLE_IOCTL(HDIO_SET_KEEPSETTINGS)
 COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
 COMPATIBLE_IOCTL(BLKRASET)
=2DCOMPATIBLE_IOCTL(BLKFRASET)
 COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't comp=
lain */
 COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't comp=
lain */
=2DCOMPATIBLE_IOCTL(RTC_AIE_ON)
=2DCOMPATIBLE_IOCTL(RTC_AIE_OFF)
=2DCOMPATIBLE_IOCTL(RTC_UIE_ON)
=2DCOMPATIBLE_IOCTL(RTC_UIE_OFF)
=2DCOMPATIBLE_IOCTL(RTC_PIE_ON)
=2DCOMPATIBLE_IOCTL(RTC_PIE_OFF)
=2DCOMPATIBLE_IOCTL(RTC_WIE_ON)
=2DCOMPATIBLE_IOCTL(RTC_WIE_OFF)
=2DCOMPATIBLE_IOCTL(RTC_ALM_SET)
=2DCOMPATIBLE_IOCTL(RTC_ALM_READ)
=2DCOMPATIBLE_IOCTL(RTC_RD_TIME)
=2DCOMPATIBLE_IOCTL(RTC_SET_TIME)
=2DCOMPATIBLE_IOCTL(RTC_WKALM_SET)
=2DCOMPATIBLE_IOCTL(RTC_WKALM_RD)
 COMPATIBLE_IOCTL(FIOQSIZE)
=20
 /* And these ioctls need translation */

--Boundary-02=_N9ayAwHjnmPJFst
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAya9N5t5GS2LDRf4RAjlEAJsGzKJtH4iPd6IbqL3nY0rynccQYwCgpKRM
mlUZLvi686LhzXxUizkCz5w=
=Bmy4
-----END PGP SIGNATURE-----

--Boundary-02=_N9ayAwHjnmPJFst--
