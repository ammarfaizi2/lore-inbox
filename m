Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTJEHgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 03:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTJEHgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 03:36:23 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:17579 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262993AbTJEHgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 03:36:20 -0400
Date: Sun, 5 Oct 2003 09:36:13 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Scott West <swest3@cogeco.ca>, linux-kernel@vger.kernel.org
Subject: Re: cs4281 driver missing from 2.6.0-test6-bk6?
Message-ID: <20031005073613.GB29140@actcom.co.il>
References: <20031005012438.GG4274@digitasaru.net> <20031004224102.64ff35c6.swest3@cogeco.ca> <20031005031754.GA8483@digitasaru.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20031005031754.GA8483@digitasaru.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2003 at 10:17:55PM -0500, Joseph Pingenot wrote:

> Aaaah.  Close.  It was "Gameport Support" that dunnit.  This laptop doesn=
't
>   have such on it, so I thought I'd give it a whirl sans, especially since
>   I'm trying to figure out why stuff is locking up on it.
> Seems like an odd dependency.  You know why that is set up so?

You can look in the archives for the exact details
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106479206731633&w=3D2),
but the bottom line is that it's a bug and already fixed in Alsa CVS
(equivalent patch also attached). Now we just need to wait until Linus
pulls it in...=20

diff -Naur --exclude-from /home/muli/p/dontdiff linux-2.5/sound/pci/Kconfig=
 revert-alsa-gameport-2.6.0-t6/sound/pci/Kconfig
--- linux-2.5/sound/pci/Kconfig	Mon Sep 29 16:46:37 2003
+++ revert-alsa-gameport-2.6.0-t6/sound/pci/Kconfig	Mon Sep 29 17:14:36 2003
@@ -17,7 +17,7 @@
=20
 config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4610 / CS4612 /
 	  CS4614 / CS4615 / CS4622 / CS4624 / CS4630 / CS4280 chips.
@@ -30,7 +30,7 @@
=20
 config SND_CS4281
 	tristate "Cirrus Logic (Sound Fusion) CS4281"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Cirrus Logic CS4281.
=20
@@ -83,7 +83,7 @@
=20
 config SND_TRIDENT
 	tristate "Trident 4D-Wave DX/NX; SiS 7018"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Trident 4D-Wave DX/NX and
 	  SiS 7018 soundcards.
@@ -110,20 +110,20 @@
=20
 config SND_ENS1370
 	tristate "(Creative) Ensoniq AudioPCI 1370"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1370.
=20
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for Ensoniq AudioPCI ES1371 and
 	  Sound Blaster PCI 64 or 128 soundcards.
=20
 config SND_ES1938
 	tristate "ESS ES1938/1946/1969 (Solo-1)"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for ESS Solo-1 (ES1938, ES1946, ES196=
9)
 	  soundcard.
@@ -173,7 +173,7 @@
=20
 config SND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SND && GAMEPORT
+	depends on SND
 	help
 	  Say 'Y' or 'M' to include support for S3 SonicVibes based soundcards.

--=20
Muli Ben-Yehuda
http://www.mulix.org


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/f8ntKRs727/VN8sRAgvCAJ9sdOw8/yZW6F5W9lLDuNSHUuuDGwCfekF3
uHCCfVF5n9OlSsx8oZ1lm90=
=+GtG
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
