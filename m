Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVEBVQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVEBVQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVEBVQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:16:49 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:64628 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261349AbVEBVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:16:45 -0400
Message-ID: <427698AE.6070605@gentoo.org>
Date: Mon, 02 May 2005 17:16:30 -0400
From: Omkhar Arasaratnam <omkhar@gentoo.org>
Organization: ppc64.gentoo.org
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix ppc64 compile problems with autofs in 2.4.30
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=38769475
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD619E97094EA2701995A613"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD619E97094EA2701995A613
Content-Type: multipart/mixed;
 boundary="------------010605010205070904030104"

This is a multi-part message in MIME format.
--------------010605010205070904030104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Trivial fix for a missing header file in arch/ppc64/kernel/ioctl32.c so
autofs will compile.

Please merge

--
Omkhar Arasaratnam - Gentoo PPC64 Developer
omkhar@gentoo.org - http://dev.gentoo.org/~omkhar
Gentoo Linux / PPC64 Linux: http://ppc64.gentoo.org


--------------010605010205070904030104
Content-Type: text/plain;
 name="2.4.30-ppc64-ioctl32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.30-ppc64-ioctl32.patch"

diff -Naur linux-2.4.30/arch/ppc64/kernel/ioctl32.c linux-2.4.30-new/arch/ppc64/kernel/ioctl32.c
--- linux-2.4.30/arch/ppc64/kernel/ioctl32.c	2005-01-19 09:09:36.000000000 -0500
+++ linux-2.4.30-new/arch/ppc64/kernel/ioctl32.c	2005-05-02 11:57:22.000000000 -0400
@@ -49,6 +49,7 @@
 #include <linux/cdrom.h>
 #include <linux/loop.h>
 #include <linux/auto_fs.h>
+#include <linux/auto_fs4.h>
 #include <linux/devfs_fs.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>

--------------010605010205070904030104--

--------------enigBD619E97094EA2701995A613
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCdpiw9msUWjh2lHURAij2AKCytoBlNmstLMx3OvNIzpIawFhFqACgqo4i
WlddFtwjrnMMYf2Soawzn/E=
=Nl0E
-----END PGP SIGNATURE-----

--------------enigBD619E97094EA2701995A613--

