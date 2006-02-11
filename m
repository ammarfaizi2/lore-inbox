Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWBKBYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWBKBYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWBKBYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:24:09 -0500
Received: from wg.technophil.ch ([213.189.149.230]:55479 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932295AbWBKBYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:24:08 -0500
Date: Sat, 11 Feb 2006 02:23:40 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Arthur Othieno <apgo@patchbomb.org>
Cc: Nico Schottelius <nico-kernel2@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au,
       Gero Kuhlmann <gero@gkminix.han.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>
Subject: [RERESEND] [PATCH] Updated Documentation/nfsroot.txt
Message-ID: <20060211012340.GC25800@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Arthur Othieno <apgo@patchbomb.org>,
	Nico Schottelius <nico-kernel2@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au,
	Gero Kuhlmann <gero@gkminix.han.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>
References: <20060210084508.GB11533@schottelius.org> <20060210151140.GA14516@krypton>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20060210151140.GA14516@krypton>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[I followed the instructions in
 http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and
 Documentation/SubmittingPatches and corrected my patch submission.
 I hope it's ok this time. I copied the original text so you can
 use it for the changelog.] =20


Hello dear developers,

I today booted the first time my embedded device using Linux 2.6.15.2,
which was booted by pxelinux, which then bootet itself from the nfsroot.

This went pretty fine, but when I was reading through
Documentation/nfsroot.txt I saw that there are some more modern versions
available of loading the kernel and passing parameters.

So I added them and the patch for that is attached to this mail.

Sincerly,

Nico


   Signed-off-by: Nico Schottelius <nico-kernel@schottelius.org>


--- linux/Documentation/nfsroot.txt.orig	2006-02-06 16:05:32.000000000 +0100
+++ linux/Documentation/nfsroot.txt	2006-02-06 16:19:37.000000000 +0100
@@ -3,6 +3,7 @@
=20
 Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
 Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
=20
=20
=20
@@ -168,7 +169,6 @@
 	root. If it got a BOOTP answer the directory name in that answer
 	is used.
=20
-
 3.2) Using LILO
 	When using LILO you can specify all necessary command line
 	parameters with the 'append=3D' command in the LILO configuration
@@ -177,7 +177,11 @@
 	LILO and its 'append=3D' command please refer to the LILO
 	documentation.
=20
-3.3) Using loadlin
+3.3) Using GRUB
+	When you use GRUB, you simply append the parameters after the kernel
+	specification: "kernel <kernel> <parameters>" (without the quotes).
+
+3.4) Using loadlin
 	When you want to boot Linux from a DOS command prompt without
 	having a local hard disk to mount as root, you can use loadlin.
 	I was told that it works, but haven't used it myself yet. In
@@ -185,7 +189,7 @@
 	lar to how LILO is doing it. Please refer to the loadlin docu-
 	mentation for further information.
=20
-3.4) Using a boot ROM
+3.5) Using a boot ROM
 	This is probably the most elegant way of booting a diskless
 	client. With a boot ROM the kernel gets loaded using the TFTP
 	protocol. As far as I know, no commercial boot ROMs yet
@@ -194,6 +198,13 @@
 	and its mirrors. They are called 'netboot-nfs' and 'etherboot'.
 	Both contain everything you need to boot a diskless Linux client.
=20
+3.6) Using pxelinux
+	Using pxelinux you specify the kernel you built with
+	"kernel <relative-path-below /tftpboot>". The nfsroot parameters
+	are passed to the kernel by adding them to the "append" line.
+	You may perhaps also want to fine tune the console output,
+	see Documentation/serial-console.txt for serial console help.
+
=20
=20
--=20
Latest release: ccollect-0.3.2 (http://linux.schottelius.org/ccollect/)
Open Source nutures open minds and free, creative developers.

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+08m7OTBMvCUbrlAQKQGQ//R1TQpd7weZoZUUml62zd+8VuGmvkAhni
7wOo8ArhDIaYyM44taQM9wtteGaA4oGVofMnzzbFezka1BOrlPxZNj16LWJzirc9
fxhterGRIFjVLACb/k6P0qntjZakWKRQ7wiZ/dkVoEYqpOtwIsQEQ6YT95Lx4YBF
r68cLPUrggYhMM44GN5Yr2R6xcfH6L3vlnAADEwvkgxoiTAtomkvyy+dY7ZKCvl/
TtDjEhEpxEfzg3HbDmlA0zu/9pu8LifiKGyXW++cY4+EwKEwXtNmqgtOzBHqXRpQ
9DUi9Q47q/LwcVYunmHFDJFxApP8hiOurUGVx2AUzYsQh6JxVmMsfZMX9L1t7B+/
UG1Vq+c17tHUd/j4bq14rXk2xptTftcsikwn7GU/PORUmoEGC4LnuPSEdDkSghcI
C6eubkfpBkCVgxE7Sylu3HGk60ugueVohd6f7QwqwDmYJKrl3LuFfGqDF7CGA/8F
y2k8/mEzrt2ys9Gt6LXu0V3hxTWGJA39c2RX78j0XtCB4QYmHCZNHCXLszPoM1Zl
bsJFe98UobHSG6ObCW8DvVnaGdiulu7SvBgKkI99leptetN7mIPQEY/1FhWZcHdV
SJavuUUmbVCoUeQTgdipOi6ha60o9osca3pqijsvw/ZkZ+9DLiTuOAjz1gmrkm46
DWptrz3xXtw=
=BIO+
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
