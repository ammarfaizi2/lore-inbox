Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTIPB4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 21:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbTIPB4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 21:56:43 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:6005 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261748AbTIPB4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 21:56:42 -0400
Subject: Unable to build tgafb.c in 2.6.0-test5 due to undefined color_table
From: Stephen Torri <storri@sbcglobal.net>
To: richard henderson <rth@twiddle.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RHhEiA5mysY9eYHvgbQU"
Message-Id: <1063677399.20190.130.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Sep 2003 20:56:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RHhEiA5mysY9eYHvgbQU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was trying to compile the tga framebuffer driver but there was a
compiler error saying that color_table was not defined. I grepped
through the drivers/video and include/video directories and did not find
a declaration. Was there a header file not included or code missing from
the driver?=20

The result of doing 'make vmlinux':

alpha:/usr/src/linux-2.6.0-test5# make vmlinux
make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      drivers/video/tgafb.o
drivers/video/tgafb.c: In function `tgafb_set_par':
drivers/video/tgafb.c:233: `color_table' undeclared (first use in this
function)drivers/video/tgafb.c:233: (Each undeclared identifier is
reported only once
drivers/video/tgafb.c:233: for each function it appears in.)
drivers/video/tgafb.c:234: `default_red' undeclared (first use in this
function)drivers/video/tgafb.c:236: `default_grn' undeclared (first use
in this function)drivers/video/tgafb.c:238: `default_blu' undeclared
(first use in this function)make[2]: *** [drivers/video/tgafb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

Stephen
--=20
Stephen Torri
GPG Key: http://www.cs.wustl.edu/~storri/storri.asc

--=-RHhEiA5mysY9eYHvgbQU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Zm3XmXRzpT81NcgRAtklAKCN2QgCj67zqWvyH6G/2h3zkXxNpgCgls0r
hndEa4OJLaO6ja9odFqZM8k=
=yPVr
-----END PGP SIGNATURE-----

--=-RHhEiA5mysY9eYHvgbQU--

