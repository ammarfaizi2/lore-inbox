Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263118AbUJ2AMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbUJ2AMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbUJ2AJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:09:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263158AbUJ2AE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:04:56 -0400
Date: Fri, 29 Oct 2004 02:04:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/adfs: remove an unused function
Message-ID: <20041029000424.GC28204@stusta.de>
References: <20041028220511.GF3207@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20041028220511.GF3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ this time without the problems due to the inline signature... ]

The patch below removes an unsed fubnction from fs/adfs/dir_f.c


diffstat output:
 fs/adfs/dir_f.c |   17 -----------------
 1 files changed, 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/fs/adfs/dir_f.c.old	2004-10-28 22:40:09.00000=
0000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/adfs/dir_f.c	2004-10-28 22:40:20.000000000=
 +0200
@@ -65,23 +65,6 @@
 	return buf - old_buf;
 }
=20
-static inline void adfs_writename(char *to, char *from, int maxlen)
-{
-	int i;
-
-	for (i =3D 0; i < maxlen; i++) {
-		if (from[i] =3D=3D '\0')
-			break;
-		if (from[i] =3D=3D '.')
-			to[i] =3D '/';
-		else
-			to[i] =3D from[i];
-	}
-
-	for (; i < maxlen; i++)
-		to[i] =3D '\0';
-}
-
 #define ror13(v) ((v >> 13) | (v << 19))
=20
 #define dir_u8(idx)				\


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgYkImfzqmE8StAARAujgAJkB+0QuzFQxBHBrjmtJ36BFyoseHQCbBMM+
jlsb4aYKibhNpvpeQo7uxDc=
=S3Lm
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
