Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTHZM2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTHZM0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:26:53 -0400
Received: from mail.donpac.ru ([217.107.128.190]:32195 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263782AbTHZM0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:26:36 -0400
Date: Tue, 26 Aug 2003 16:26:34 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] visws: fix 2.6.0-test4 breakage
Message-ID: <20030826122634.GB3913@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: multipart/mixed; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

attached trivial patch fixes visws subarch kernel build.
It was broken by 2.6.0-test4 cpumask_t changes.

Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-visws-2.6.0-test4"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.6.0-test4.vanilla/arch/i386/mach-v=
isws/mpparse.c linux-2.6.0-test4/arch/i386/mach-visws/mpparse.c
--- linux-2.6.0-test4.vanilla/arch/i386/mach-visws/mpparse.c	Tue Aug 26 23:=
33:35 2003
+++ linux-2.6.0-test4/arch/i386/mach-visws/mpparse.c	Tue Aug 26 22:27:21 20=
03
@@ -38,7 +38,7 @@
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, logical_apicid;
-	cpumask_t apic_cpus;
+	physid_mask_t apic_cpus;
  =09
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;

--gr/z0/N6AeWAPJVB--

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/S1H6by9O0+A2ZecRAmEiAKDYyD7l04fIPJBkSWIGTvsVoBJi5QCguyY9
6uyEyW2KKn3zGaigwVAazJY=
=6JG8
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
