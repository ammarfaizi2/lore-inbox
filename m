Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUIRHSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUIRHSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUIRHSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:18:36 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:7069 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269142AbUIRHSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:18:18 -0400
Date: Sat, 18 Sep 2004 00:18:17 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] hotplug: Don't build cpqphp_proc.o if !PROC_FS
Message-ID: <20040918071817.GA4864@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This simple patch to drivers/hotplug/Makefile eliminates a build failure
for cpqphp if CONFIG_PROC_FS is disabled. Herbert Xu originally wrote
this patch.

Marcelo, please apply.

(Note: does not apply to 2.6 because stuff seems to have switched to
sysfs there.)

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

# origin: Debian (herbert)
# cset: n/a
# inclusion: not submitted
# description: don't build cpqphp_proc.o if !PROC_FS
# revision date: 2004-09-05

diff -urN kernel-source-2.4.26/drivers/hotplug/Makefile kernel-source-2.4.2=
6-1/drivers/hotplug/Makefile
--- kernel-source-2.4.26/drivers/hotplug/Makefile	2003-08-25 21:44:41.00000=
0000 +1000
+++ kernel-source-2.4.26-1/drivers/hotplug/Makefile	2004-04-17 08:17:42.000=
000000 +1000
@@ -18,7 +18,6 @@
=20
 cpqphp-objs		:=3D	cpqphp_core.o	\
 				cpqphp_ctrl.o	\
-				cpqphp_proc.o	\
 				cpqphp_pci.o
=20
 ibmphp-objs		:=3D	ibmphp_core.o	\
@@ -36,5 +35,9 @@
 	cpqphp-objs +=3D cpqphp_nvram.o
 endif
=20
+ifeq ($(CONFIG_PROC_FS),y)
+	cpqphp-objs +=3D cpqphp_proc.o
+endif
+
 include $(TOPDIR)/Rules.make
=20

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUvhOaOILr94RG8mAQLSQhAA432PI53sV7fVdtGXvhzxkr3pOnL3FBSH
Ofh0newd/n/XVC8GC0VVZb3eRslZ2pEGfUqiGQht9ADfncHNsWw6xON+Uel5n9d5
0i4cNBu1Z8cgeIjD9Qs9+YI2WVgyNorgRvpup+mQJIMTA6rkXbsBrC06niSZz0cx
eoaYpYDHy8t5b80+RoXdH9C3eqGcXPiX8K1P5RL4aGF+gzPd/E11jcbIeOeR9psD
vtbdqmLPkTcW/6/2D57xg2LSGVmxgl30wXnO/w1MK+Ryk1z/PuQvESCRJGs7BdWf
EtRqHFgAnJUvHsf3/BROpkecx2Sgt8UMgbiBAK3ms+HKo6FDYScMadmCfvmqNONX
/qHaBXdrby2UWY0uJBslzSII/SlQVg+hdu61GBw16bWupUhjzSFmIPDa8g/n6yW+
TOLv0I4xWq3yEz8nAR+1WlV0oI0orzna9AWf4Rz+3Ayg0SDfPTRMD3sL5xEoGM6O
KMQ68oX/as4eNGI3b6Rg229FGRpPNjVWrNo3s2RVWzms+8gZAOKSnmOlxlVZfbc7
OIl2ZiEtWt4ebTpk6E2yaiQsvlSrudpaG36lk+H46hBkFuRoaK09maysks2gLm4i
3pinq+fPCZ6rYTuY61qi/MCJJw1jgLjggTrApPRxt7xAziy/l+vaBg9JGcVNtro8
ZCfhvdVy/sc=
=D+OR
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
