Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVAaUd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVAaUd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAaUd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:33:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8417 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261355AbVAaUdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:33:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
Date: Mon, 31 Jan 2005 21:23:10 +0100
User-Agent: KMail/1.6.2
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
References: <20050129131134.75dacb41.akpm@osdl.org> <200501301645.14069.arnd@arndb.de> <20050130165839.GB27703@linux-mips.org>
In-Reply-To: <20050130165839.GB27703@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_vOp/BUum3sMGFd6";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501312123.11451.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_vOp/BUum3sMGFd6
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 30 Januar 2005 17:58, Ralf Baechle wrote:
> Hmm... =A0Atushi sent me this new-style serial driver when I asked him for
> replacements for the old style drivers in drivers/char/ so my undertanding
> was it was a full replacement for all of them. =A0I'll check on the tx3912
> and will try to send an update later today.

I just found that the version in -mm2 does not add the Makefile change, so
you need this patchlet on top. If you haven't redone the patch yet, it might
be better still to rename the file to txx9.o, as serial/serial_* is a bit
redundant.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=2D-- linux-mm.orig/drivers/serial/Makefile	2005-01-28 07:21:24.000000000 -=
0500
+++ linux-mm/drivers/serial/Makefile	2005-01-31 15:34:55.198987872 -0500
@@ -48,3 +48,4 @@
 obj-$(CONFIG_SERIAL_M32R_SIO) +=3D m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) +=3D mpsc.o
 obj-$(CONFIG_ETRAX_SERIAL) +=3D crisv10.o
+obj-$(CONFIG_SERIAL_TXX9) +=3D serial_txx9.o

--Boundary-02=_vOp/BUum3sMGFd6
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/pOv5t5GS2LDRf4RAoTfAJ9jzWqXXNiX7OchHi9odbFfnFRW0ACeJH5d
JzWlGgjFD+Tkxy8v32ghaKY=
=+hkS
-----END PGP SIGNATURE-----

--Boundary-02=_vOp/BUum3sMGFd6--
