Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTBNU3s>; Fri, 14 Feb 2003 15:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbTBNU3s>; Fri, 14 Feb 2003 15:29:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21635 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267429AbTBNU3q>; Fri, 14 Feb 2003 15:29:46 -0500
Message-Id: <200302142039.h1EKdYwZ029474@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.60 - drivers/char/esp.c vs include/linux/serialP.h
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1185923764P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Feb 2003 15:39:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1185923764P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <29463.1045255174.1@turing-police.cc.vt.edu>

compiling drivers/char/esp.c with -Wundef triggers a warning:

In file included from drivers/char/esp.c:51:
include/linux/serialP.h:27:6: warning: "LINUX_VERSION_CODE" is not defined

The code that trips it up:

#if (LINUX_VERSION_CODE < 0x020300)
/* Unfortunate, but Linux 2.2 needs async_icount defined here and
 * it got moved in 2.3 */
#include <linux/serial.h>
#endif

It's unclear if this should be fixed by adding a #include <linux/version.h>
to esp.c, or if this code should summarily be lopped out of serialP.h.


--==_Exmh_-1185923764P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TVQGcC3lWbTT17ARApSYAJ9WYk2pHfQ3609Ok1+pAy90/8+KpACfd7dO
4EawuCsDRI6dAbRiXxwmci8=
=egn3
-----END PGP SIGNATURE-----

--==_Exmh_-1185923764P--
