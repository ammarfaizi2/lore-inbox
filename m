Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbSJLIiz>; Sat, 12 Oct 2002 04:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262405AbSJLIiz>; Sat, 12 Oct 2002 04:38:55 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:46344 "EHLO debian")
	by vger.kernel.org with ESMTP id <S262400AbSJLIix>;
	Sat, 12 Oct 2002 04:38:53 -0400
Date: Sat, 12 Oct 2002 10:43:36 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20-pre10-ac2 -- cpufreq
Message-ID: <20021012084336.GA7027@debian>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

cpufreq.c: In function `cpufreq_notify_transition':
cpufreq.c:941: `i' undeclared (first use in this function)
cpufreq.c:941: (Each undeclared identifier is reported only once
cpufreq.c:941: for each function it appears in.)
cpufreq.c: In function `cpufreq_restore':
cpufreq.c:1068: warning: statement with no effect
make[2]: *** [cpufreq.o] Error 1
make[2]: Leaving directory `/root/linux-2.4.19/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/root/linux-2.4.19/kernel'
make: *** [_dir_kernel] Error 2

you can add a   'int i'

stargate kernel # diff -urH cpufreq.c.old cpufreq.c
--- cpufreq.c.old       2002-10-07 21:17:09.000000000 +0200
+++ cpufreq.c   2002-10-07 21:17:27.000000000 +0200
@@ -927,6 +927,7 @@
  */
   void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned
   int state)
    {
	+       int i;
	        down(&cpufreq_notifier_sem);
			        switch (state) {
					        case CPUFREQ_PRECHANGE:
							stargate kernel #=20
						=09

Best Regards=20

Stephane Wirtel



--=20
Stephane Wirtel <stephane.wirtel@belgacom.net>
LinuxMons : www.linux-mons.be
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="cpufreq.patch"

--- cpufreq.c.old	2002-10-07 21:17:09.000000000 +0200
+++ cpufreq.c	2002-10-07 21:17:27.000000000 +0200
@@ -927,6 +927,7 @@
  */
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 {
+	int i;
 	down(&cpufreq_notifier_sem);
 	switch (state) {
 	case CPUFREQ_PRECHANGE:

--gBBFr7Ir9EOA20Yy--

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE9p+C4PRHlvMnBbacRAtpWAKCfWdJmG2gZCi7RSRCFSLWf7joy6gCeIrbq
KCS0Mf/PX1GQ12sQH4kVL0Y=
=fuEK
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
