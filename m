Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUFKPQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUFKPQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUFKPQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:16:21 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:27642 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264045AbUFKPQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:16:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] s390: fix "cpu_online" redefined warnings
Date: Fri, 11 Jun 2004 17:15:35 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_XycyAfjiAtvt4ht";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406111715.35399.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_XycyAfjiAtvt4ht
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

cpumask-5-10-rewrite-cpumaskh-single-bitmap-based from 2.6.7-rc3-mm1
causes include2/asm/smp.h:54:1: warning: "cpu_online" redefined

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

=3D=3D=3D=3D=3D include/asm-s390/smp.h 1.13 vs edited =3D=3D=3D=3D=3D
=2D-- 1.13/include/asm-s390/smp.h	Thu Feb 26 12:21:54 2004
+++ edited/include/asm-s390/smp.h	Fri Jun 11 16:31:47 2004
@@ -31,10 +31,6 @@
=20
 extern int smp_call_function_on(void (*func) (void *info), void *info,
 				int nonatomic, int wait, int cpu);
=2D
=2Dextern cpumask_t cpu_online_map;
=2Dextern cpumask_t cpu_possible_map;
=2D
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
=20
 /*
@@ -50,8 +46,6 @@
 #define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
=20
 #define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
=2D
=2D#define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
=20
 extern __inline__ __u16 hard_smp_processor_id(void)
 {

--Boundary-02=_XycyAfjiAtvt4ht
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAycyX5t5GS2LDRf4RAt81AJ42c1bxJAJnr1u31/9raGtuN+EYzgCfWQ10
GBTdVxAlRiU8kJiU8R6a5VE=
=IpRY
-----END PGP SIGNATURE-----

--Boundary-02=_XycyAfjiAtvt4ht--
