Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTDVA2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbTDVA2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 20:28:08 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:3901 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262690AbTDVA2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 20:28:07 -0400
Date: Mon, 21 Apr 2003 20:40:08 -0400
From: Mace Moneta <mmoneta@optonline.net>
Subject: 2.4.21.rc1 - make xconfig
To: linux-kernel@vger.kernel.org
Reply-to: mmoneta@optonline.net
Message-id: <1050972007.7851.36.camel@optonline.net>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: multipart/signed; boundary="=-hLZsFO3kF6LzP7RsYkt7";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hLZsFO3kF6LzP7RsYkt7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ran a 'make oldconfig' which completed without error, then ran:

---

# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.21-rc1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate
condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc1/scripts'
make: *** [xconfig] Error 2

---

The line 46 in 'drivers/ide/Config.in' the complaint is about:

   dep_tristate '    Pacific Digital ADMA-100 basic support'
CONFIG_BLK_DEV_ADMA100

---

'make config' and 'make menuconfig' work correctly.


--=-hLZsFO3kF6LzP7RsYkt7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+pI9neRnU1Q3hpXYRAtixAJ9ONl+p18JjN1fiF8FI/z6snQrcggCgzAv+
zL/lO01LlocrpatFVtwWY3o=
=HJN7
-----END PGP SIGNATURE-----

--=-hLZsFO3kF6LzP7RsYkt7--

