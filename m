Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272425AbTGZGBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 02:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272427AbTGZGBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 02:01:19 -0400
Received: from dialin-212-144-078-069.arcor-ip.net ([212.144.78.69]:5505 "EHLO
	dd8ne.ampr.org") by vger.kernel.org with ESMTP id S272425AbTGZGBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 02:01:16 -0400
Message-ID: <3F221B53.7000504@privacy.net>
Date: Sat, 26 Jul 2003 08:10:27 +0200
From: Hans-Joachim Hetscher <me@privacy.net>
Reply-To: hajohe@imail.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-hams@vger.kernel.org
Subject: [PATCH] 2.5.75 6PACK
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050408050701050602000903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050408050701050602000903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

the Hamradio 6pack driver wasn't modified to work with the 1000 HZ
internal kernel timebase.

So here the patch to solve this little problem

vy 73 de Hans-Joachim

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/IhtT3VQwVx4wircRAk2FAJ99nrAIqEQUrHCZk1DPRLcKRulvlwCfbtbH
UOa/Qp704Ac6UXudrfoOEl8=
=eL+I
-----END PGP SIGNATURE-----

--------------050408050701050602000903
Content-Type: text/plain;
 name="6pack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="6pack.diff"

--- linux/drivers/net/hamradio/6pack.c.ori	2003-07-19 08:00:05.000000000 +0200
+++ linux/drivers/net/hamradio/6pack.c	2003-07-25 07:35:27.000000000 +0200
@@ -67,11 +67,11 @@
 #define SIXP_DAMA_OFF		0
 
 /* default level 2 parameters */
-#define SIXP_TXDELAY			25	/* in 10 ms */
+#define SIXP_TXDELAY			0.25*HZ	/* in 1 s */
 #define SIXP_PERSIST			50	/* in 256ths */
-#define SIXP_SLOTTIME			10	/* in 10 ms */
-#define SIXP_INIT_RESYNC_TIMEOUT	150	/* in 10 ms */
-#define SIXP_RESYNC_TIMEOUT		500	/* in 10 ms */
+#define SIXP_SLOTTIME			0.1*HZ	/* in 1 s */
+#define SIXP_INIT_RESYNC_TIMEOUT	1.5*HZ	/* in 1 s */
+#define SIXP_RESYNC_TIMEOUT		5*HZ	/* in 1 s */
 
 /* 6pack configuration. */
 #define SIXP_NRUNIT			31      /* MAX number of 6pack channels */

--------------050408050701050602000903--

