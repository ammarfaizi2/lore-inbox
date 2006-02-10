Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWBJIpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWBJIpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWBJIpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:45:35 -0500
Received: from wg.technophil.ch ([213.189.149.230]:7813 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751185AbWBJIpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:45:34 -0500
Date: Fri, 10 Feb 2006 09:45:08 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au
Cc: Gero Kuhlmann <gero@gkminix.han.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>
Subject: [RESEND] [PATCH] nfsroot.txt (against Linux 2.6.15.2)
Message-ID: <20060210084508.GB11533@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au,
	Gero Kuhlmann <gero@gkminix.han.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: multipart/mixed; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[This message was sent to the LKML on Mon, 6 Feb 2006 16:29:46 +0100
 and nobody replied. Perhaps you did not see it in the flood of mails.]

Hello dear developers,

I today booted the first time my embedded device using Linux 2.6.15.2,
which was booted by pxelinux, which then bootet itself from the nfsroot.

This went pretty fine, but when I was reading through
Documentation/nfsroot.txt I saw that there are some more modern versions
available of loading the kernel and passing parameters.

So I added them and the patch for that is attached to this mail.

Sincerly,

Nico

P.S.: Please reply to nico-kernel2 //at// schottelius.org

--=20
Latest release: ccollect-0.3.2 (http://linux.schottelius.org/ccollect/)
Open Source nutures open minds and free, creative developers.

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfsroot-2.6.15.2.diff"
Content-Transfer-Encoding: quoted-printable

--- nfsroot.txt.orig	2006-02-06 16:05:32.000000000 +0100
+++ nfsroot.txt	2006-02-06 16:19:37.000000000 +0100
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
=20

--XWOWbaMNXpFDWE00--

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+xSk7OTBMvCUbrlAQL0NA/9FOJGfWPL0X0jlPGmMVEn0q3B/RPWFka7
DP4ROmhANRn2matt2o9JIxkhstdQKJ/o37DdGfFZs/6iEFH6UTQGvJCoGq/JQRfS
PQROmNTldanJ6GOwsR71jEEON1p26+cikbwbDC5LL2g3qIjnm7CblYFx9SjrkL35
gJ8TuQCyMp1/4KUhvzWEKVmdR29nhm3AwVQ0XL+CoPSXe4NTIRAhs2KfnTh9sKDw
HLrlVHHf0hoE55h1TndL+qDtJ4Ul+hkOHAcGmGRCdgl8+G1nFT2Ubc/WUhwjwq7T
a5Qmmptks3SLvLs2EG2qGMnem+5ynZwoO7zsGqEHKli/k2SVQIU3L6UdF6isBc8y
cAq50vDdJ9EalGSxu7axQ/2uya87ctqpMIdsx4V5JLmo4zAfA4LxmrF3jhwno1FA
UzDwyNcbJE7aB2zeEUUm3fJ/toTrta8IOLN4v1SBFRKc+r5qO9NZSiKHDaMBgfk/
ogCTZM6SSwVl1cOi7tcePrqGxDfijK5DJL0ldBWsBmWTmwSpxJxriaTy5z39a4ry
023bTCIURs8UpRBX4xHFNetODQaxaAfF4DlOOEmWrLCQrAQePQ1v8N9A2UHCHMzA
6i10lMK4kRaJoB9YTwzSswDxLONA8gbumqL2oTBVF0ILaNV7buBB51FLgvIj9n2Q
Q/VC/d7SxEQ=
=2yWO
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
