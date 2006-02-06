Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWBFPaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWBFPaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWBFPaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:30:04 -0500
Received: from wg.technophil.ch ([213.189.149.230]:16571 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932087AbWBFPaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:30:02 -0500
Date: Mon, 6 Feb 2006 16:29:46 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au
Cc: Gero Kuhlmann <gero@gkminix.han.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>
Subject: [PATCH] nfsroot.txt (against Linux 2.6.15.2)
Message-ID: <20060206152946.GE13051@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au,
	Gero Kuhlmann <gero@gkminix.han.de>,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: multipart/mixed; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

--EXKGNeO8l0xGFBjy
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

--EXKGNeO8l0xGFBjy--

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+drarOTBMvCUbrlAQIYSQ//RuzIsx4tAxPElZpptkxPNh4MqKhKFBAh
4fEliTtSlFGo2bYeCCRA8QZRyvVFFpzZeDbPjHEflUjEIEpTYqfrF0FN09sblwab
XVoO+dgUVrtEgCNk32CMTTInBQ3mapPIRhExeShNNP6z/1T/eisJOnC/ldgnXcsB
rApUgFhHV2lumAwqtYBUyiZ6F9rqKpxyZoPEghVjzgykF02mqpKQNGiD+Cxy2Drf
sYImJ875QsmoBkapLHkyu/ikht+T/3TIvDL4mmTq/SF6NG82nS3IgDE99phkkjit
aDwTtoEtDwExWZcIHb4C7GORfbPVp99LaYU/IEmPOFd/ilJERw7kOEXPePs1OYyO
dNZ76+Q9kfkHpf3DFVlL5E3xOYOtO8zqU9Eghg9K2clabUJvhF7m/kUvJMjEwft1
6ATdH6gEjuskDLn9rS5/QMBPYJ/+WU2Wos5bkA/vpeHxmb9SzXLlSrrSgr235/fS
TelS/2Mi7aQBngVSdCDtojECn8EXAzZZwlSxk1YjXTZBnIA36GB94HEUZuLN4Hnu
qV8f+I+6UfyPARao4not1i9XIdy83bE6HjV8MTmOmEKiL3jClq4cjxSZO90+Hb3I
Wx/4J1rNle0Eu4qTriw0lzA8S9HvkByqeajsx42ox8/gZT0togmYoQdXx73IErcE
9cBMT5LDmRY=
=Z7WL
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
