Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTK1CXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTK1CWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:22:30 -0500
Received: from dialin-212-144-182-198.arcor-ip.net ([212.144.182.198]:1152
	"EHLO dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261893AbTK1CWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:22:03 -0500
Date: Fri, 28 Nov 2003 02:46:08 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [KBD] Fix dollar key on swiss french USB keyboards
Message-ID: <20031128014608.GF1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On a swiss french keyboard, the dollar key, which worked well in Linux
2.4, now  changes the terminal to the  last used one. This  is not the
purpose of a dollar key. As the "}" character is on the same key, it's
quite a problem for developers to have this bug.

This is  a hack and may screw  up any other keyboard  tables!  I'm not
sure how to implement it cleanly.  I'd be glad to hear of testers with
US-english and other keyboards.

More on this patch can be found at
<URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/swiss_dollar_key.xml>

				Thunder

diff -Nur linux-2.6.0-test9-mm3/drivers/usb/input/hid-input.c linux-2.6.0-test9-mm3-ta1/drivers/usb/input/hid-input.c
--- linux-2.6.0-test9-mm3/drivers/usb/input/hid-input.c	2003-10-08 21:24:04.000000000 +0200
+++ linux-2.6.0-test9-mm3-ta1/drivers/usb/input/hid-input.c	2003-11-24 13:42:35.000000000 +0100
@@ -40,7 +40,7 @@
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
 	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
 	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
-	 27, 43, 84, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
+	 27, 84, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
 	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
 	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
 	 72, 73, 82, 83, 86,127,116,117, 85, 89, 90, 91, 92, 93, 94, 95,

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xqjgygQNIN66kP8RAlRxAJ0eJlhxGzfXcX1cK5QUPjMGtvmPRACghAQl
k6Pr/BpahqoyQumPpdIHOfI=
=WmVN
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
