Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVHWLRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVHWLRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVHWLRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:17:45 -0400
Received: from sipsolutions.net ([66.160.135.76]:16398 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932129AbVHWLRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:17:44 -0400
Subject: patch for compiling ppc without pmu
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yphagxoxKGO8lZ1cqsBv"
Date: Tue, 23 Aug 2005 13:17:24 +0200
Message-Id: <1124795844.9162.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yphagxoxKGO8lZ1cqsBv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This patch seems to be required to compile 2.6.13-rc6 for ppc configured
without PMU.

Apologies if it is already known, I haven't found anything like this
quickly.

Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.13-rc6.orig/arch/ppc/platforms/pmac_time.c	2005-08-23 12:14:3=
7.689485664 +0200
+++ linux-2.6.13-rc6/arch/ppc/platforms/pmac_time.c	2005-08-23 12:14:37.689=
485664 +0200
@@ -251,7 +251,7 @@
 	struct device_node *cpu;
 	unsigned int freq, *fp;
=20
-#ifdef CONFIG_PM && CONFIG_ADB_PMU
+#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
 	pmu_register_sleep_notifier(&time_sleep_notifier);
 #endif /* CONFIG_PM */
=20


--=-yphagxoxKGO8lZ1cqsBv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQwsFwaVg1VMiehFYAQJ56g/+O5YvuDWgzGZl06mAyyBL7NrOi4aT90mU
htwj+MVz0mRucFGwSTMIDTmuG2AQOpHktmwbHbdyPqGU9c+l+S6f4e9ggLYwje0q
6aN81q9LRPcZ3xA733Z2VfY0Dyo5zCk+8Kb2zK9N1dPZV69AMIi2q71Mxur/KMTX
k4dlEnfGIibaxqAOkfpGd2NsVw3ynOAzJjGZ6fFN2iju/sLAP4PZdrTM1hdv9ryJ
Nitx+IZZ/4qj5aWOwsAslNpcdH7HrBV8sggaKbczhlEVPbbt3qRX4ueoAkY+fUnD
3U0j2zSYZKg42PHWXODM/4aIIkU6kjqOTDxKH7Lty5yU2rRb+LTBNzar7ZAw5dJc
TvT6Z7KXhPz3fJMrjI6uw65+7K9HupnxSzBhwkKwUxmdXUPfBzmdACNaaiIRH+g2
uOnWejhXkJ/z40scpxNKbvLocmZwaONmQbewlcwDSvIj9U67bT7gJWt21Wj61TZe
3ZxChEE4tS9A2fxFpMXprxpQ6cdSKD1//Rir8VOmAdmOoUAJbbFF1vHc2+5aGMU9
hy7rLukaM5a1IFZuk+A2fB0BTE9wVF17rFfvP4BsjryYpeGG+9fFi+L6+N0+e1L+
+A7V4Ebnq3wPwtymqlElcJ7XyH9XG+fzTkcKpJwHMNyJgwV7PRYE95y6lccVtdB9
u7XZrfFos6k=
=28DI
-----END PGP SIGNATURE-----

--=-yphagxoxKGO8lZ1cqsBv--

