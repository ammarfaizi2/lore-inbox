Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbTIGP3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTIGP3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:29:13 -0400
Received: from iucha.net ([209.98.146.184]:50517 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263308AbTIGP3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:29:11 -0400
Date: Sun, 7 Sep 2003 10:29:10 -0500
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: PCMCIA link failed with test4-bk9
Message-ID: <20030907152910.GA15474@iucha.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I was trying to build a 2.6.0-test4-bk9 kernel for my laptop and the
link failed with:
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x911bc): In function `CardServices':
: undefined reference to `pcmcia_deregister_client'
drivers/built-in.o(.text+0x928c5): In function `pcmcia_bus_remove_socket':
: undefined reference to `pcmcia_deregister_client'
drivers/built-in.o(__ksymtab+0x1268): undefined reference to `pcmcia_deregi=
ster_client'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/local/src/linux-2.6.0-test4'
make: *** [stamp-build] Error 2

My relevant portion of the .config is:
#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dy
# CONFIG_YENTA is not set
# CONFIG_I82092 is not set
CONFIG_I82365=3Dy
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=3Dy

The kernel that I am using now is 2.6.0-test4-mm4.

florin

--=20

Don't question authority: they don't know either!

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/W07GNLPgdTuQ3+QRAotdAJ40TCYUp1g4wjBDSBLBE3JvBBBi3gCgm8cn
W/O/BpcV/9u0Lpg0NGnO/28=
=qYvt
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
