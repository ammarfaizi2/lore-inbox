Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTDGSjm (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTDGSjm (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:39:42 -0400
Received: from ro138.isis.de ([195.158.152.138]:36337 "EHLO localhost")
	by vger.kernel.org with ESMTP id S263592AbTDGSjd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:39:33 -0400
Date: Mon, 7 Apr 2003 20:51:01 +0200
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Subject: ac97_codec patch for 2.4.20 - 2.4.21-preX
Message-ID: <20030407185101.GA12831@erdbeere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello,

this is a short patch to correct the ac97_codec.h in kernel 2.4.20 up to
2.4.21-pre7. It was extracted from the patch-2.4.21-pre5-ac3. Now the
kernel compiles fine :)

cu
Patrick

ps. i'm sorry for my terrible english


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-ac97_codec.h"
Content-Transfer-Encoding: quoted-printable

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.21pre5=
/include/linux/ac97_codec.h linux.21pre5-ac3/include/linux/ac97_codec.h
--- linux/include/linux/ac97_codec.h	2003-02-27 18:39:41.000000000 +0000
+++ linux/include/linux/ac97_codec.h	2003-03-01 19:23:29.000000000 +0000
@@ -222,6 +222,8 @@
 	int dev_mixer;=20
 	int type;
=20
+	int modem:1;
+=09
 	struct ac97_ops *codec_ops;
=20
 	/* controller specific lower leverl ac97 accessing routines */
@@ -237,6 +239,9 @@
 	int stereo_mixers;
 	int record_sources;
=20
+	/* Property flags */
+	int flags;
+
 	int bit_resolution;
=20
 	/* OSS mixer interface */
@@ -265,6 +270,8 @@
 	int (*amplifier)(struct ac97_codec *codec, int on);
 	/* Digital mode control */
 	int (*digital)(struct ac97_codec *codec, int format);
+#define AC97_DELUDED_MODEM	1	/* Audio codec reports its a modem */
+#define AC97_NO_PCM_VOLUME	2	/* Volume control is missing 	   */
 };

--zx4FCpZtqtKETZ7O--

--rQ2U398070+RC21q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kciUuPariA13z2wRAh3LAJ0cxgbMVvO3klRjeCGyzbNFwdz3wwCfdAG7
WImaGXNXVgZmheBdz4jAwsg=
=xkOe
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
