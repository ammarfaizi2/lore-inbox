Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUJQQWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUJQQWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUJQQSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:18:21 -0400
Received: from admingilde.org ([213.95.21.5]:39386 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S269213AbUJQQQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:16:09 -0400
Date: Sun, 17 Oct 2004 18:15:54 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: initramfs build fix
Message-ID: <20041017161554.GD10532@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:041017:akpm@osdl.org:6c531e96a1bb0a83
X-Hashcash: 0:041017:linux-kernel@vger.kernel.org:7cdc28d98a4e989a
X-Spam-Score: -11.3 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

CONFIG_INITRAMFS_SOURCE may be empty which confuses 'test'.
So we have to quote it properly.

Signed-off-by: Martin Waitz <tali@admingilde.org>

Index: linux-2.6/usr/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/usr/Makefile	2004-10-17 16:06:58.430886734 +0200
+++ linux-2.6/usr/Makefile	2004-10-17 16:07:56.185444167 +0200
@@ -25,14 +25,14 @@
=20
 quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
       cmd_gen_list =3D $(shell \
-        if test -f $(CONFIG_INITRAMFS_SOURCE); then \
-	  if [ $(CONFIG_INITRAMFS_SOURCE) !=3D $@ ]; then \
-	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
+        if test -f "$(CONFIG_INITRAMFS_SOURCE)"; then \
+	  if [ "$(CONFIG_INITRAMFS_SOURCE)" !=3D $@ ]; then \
+	    echo 'cp -f "$(CONFIG_INITRAMFS_SOURCE)" $@'; \
 	  else \
 	    echo 'echo Using shipped $@'; \
 	  fi; \
-	elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
-	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
+	elif test -d "$(CONFIG_INITRAMFS_SOURCE)"; then \
+	  echo 'scripts/gen_initramfs_list.sh "$(CONFIG_INITRAMFS_SOURCE)" > $@';=
 \
 	else \
 	  echo 'echo Using shipped $@'; \
 	fi)

--=20
Martin Waitz

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcpq6j/Eaxd/oD7IRAnbjAJ4oeDmpeMmQoy7SbYsf0M4Fgin/ZgCfV/KA
q4D+9+LkDjZHWO3dCaJq+1I=
=HZ2c
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--

