Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310583AbSCMNnd>; Wed, 13 Mar 2002 08:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310587AbSCMNnZ>; Wed, 13 Mar 2002 08:43:25 -0500
Received: from pop.gmx.net ([213.165.64.20]:49095 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310583AbSCMNnG>;
	Wed, 13 Mar 2002 08:43:06 -0500
Date: Wed, 13 Mar 2002 14:47:11 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [2.5.7-pre1] rtctimer.c compile fix
Message-Id: <20020313144711.239a50b8.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.XBe9Bg/Ij.s207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.XBe9Bg/Ij.s207
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
here is a simple compile fix for the alsa rtctimer
The variable err in rtctimer_open was missing
Maybe this was posted before (I use this fix since 2.5.5 or so) but I don't know

Bye

--- linux-2.5.6/sound/core/rtctimer.c.old       Wed Mar 13 14:43:31 2002
+++ linux-2.5.6/sound/core/rtctimer.c   Wed Mar 13 14:43:56 2002
@@ -76,6 +76,7 @@
 static int
 rtctimer_open(snd_timer_t *t)
 {
+       int err;        
        err = rtc_register(&rtc_task);
        if (err < 0)
                return err;
--=.XBe9Bg/Ij.s207
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8j1hye9FFpVVDScsRAg+nAKDaQhi0thhIQaK6Gb+wjsc8GExwtQCg93xF
Hm3XscFbwy7z1vB2RHyXPjE=
=GLPB
-----END PGP SIGNATURE-----

--=.XBe9Bg/Ij.s207--

