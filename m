Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315558AbSEGN7e>; Tue, 7 May 2002 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315553AbSEGN7d>; Tue, 7 May 2002 09:59:33 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:1809 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315451AbSEGN7b>;
	Tue, 7 May 2002 09:59:31 -0400
Date: Tue, 7 May 2002 18:04:16 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] missing __init's in smpboot.c (i386)
Message-ID: <20020507140416.GA433@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.14 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch adds missing __init modifiers for wakeup_secondary_via_NMI() and
wakeup_secondary_via_INIT() functions in arch/i386/smpboot.c file.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-smpboot
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/arch/i386/kernel/smpboot.c l=
inux/arch/i386/kernel/smpboot.c
--- linux.vanilla/arch/i386/kernel/smpboot.c	Tue Apr 23 19:05:49 2002
+++ linux/arch/i386/kernel/smpboot.c	Fri May  3 01:11:34 2002
@@ -632,7 +632,7 @@
 }
 #endif
=20
-static int wakeup_secondary_via_NMI(int logical_apicid)
+static int __init wakeup_secondary_via_NMI(int logical_apicid)
 /*=20
  * Poke the other CPU in the eye to wake it up. Remember that the normal
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
@@ -680,7 +680,7 @@
 	return (send_status | accept_status);
 }
=20
-static int wakeup_secondary_via_INIT(int phys_apicid, unsigned long start_=
eip)
+static int __init wakeup_secondary_via_INIT(int phys_apicid, unsigned long=
 start_eip)
 {
 	unsigned long send_status =3D 0, accept_status =3D 0;
 	int maxlvt, timeout, num_starts, j;

--Dxnq1zWXvFF0Q93v--

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8197gBm4rlNOo3YgRAjDtAJ4t2vEgQj/zLlW+IEwtzk1/EdZrTgCdEHA8
FBE3Ha+uBIxuS8SyHWYSLUk=
=ogek
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
