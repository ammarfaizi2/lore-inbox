Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWCRLCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWCRLCg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 06:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbWCRLCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 06:02:36 -0500
Received: from wg.technophil.ch ([213.189.149.230]:50915 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751109AbWCRLCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 06:02:35 -0500
Date: Sat, 18 Mar 2006 12:02:32 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       Arthur Othieno <apgo@patchbomb.org>
Subject: [PATCH] doc: Updated Documentation/nfsroot.txt
Message-ID: <20060318110232.GB4336@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
	Arthur Othieno <apgo@patchbomb.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.15.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello LKML!

What am I doing terrible wrong that I do not get any comment on this
patch?


----- Forwarded message from Arthur Othieno <apgo@patchbomb.org> -----

Date: Tue, 14 Feb 2006 11:05:53 -0500
To: akpm@osdl.org
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
	Arthur Othieno <apgo@patchbomb.org>
Subject: [PATCH] doc: Updated Documentation/nfsroot.txt
=46rom: Arthur Othieno <apgo@patchbomb.org>

=46rom: Nico Schottelius <nico-kernel@schottelius.org>

I today booted the first time my embedded device using Linux 2.6.15.2,
which was booted by pxelinux, which then bootet itself from the nfsroot.

This went pretty fine, but when I was reading through
Documentation/nfsroot.txt I saw that there are some more modern versions
available of loading the kernel and passing parameters.

So I added them and the patch for that is attached to this mail.

Signed-off-by: Nico Schottelius <nico-kernel@schottelius.org>
Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 Documentation/nfsroot.txt |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

bb5fd479f34c5c53f3e3316052656c7795c02f90
diff --git a/Documentation/nfsroot.txt b/Documentation/nfsroot.txt
index a87d4af..d56dc71 100644
--- a/Documentation/nfsroot.txt
+++ b/Documentation/nfsroot.txt
@@ -3,6 +3,7 @@ Mounting the root filesystem via NFS (nf
=20
 Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
 Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
=20
=20
=20
@@ -168,7 +169,6 @@ depend on what facilities are available:
 	root. If it got a BOOTP answer the directory name in that answer
 	is used.
=20
-
 3.2) Using LILO
 	When using LILO you can specify all necessary command line
 	parameters with the 'append=3D' command in the LILO configuration
@@ -177,7 +177,11 @@ depend on what facilities are available:
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
@@ -185,7 +189,7 @@ depend on what facilities are available:
 	lar to how LILO is doing it. Please refer to the loadlin docu-
 	mentation for further information.
=20
-3.4) Using a boot ROM
+3.5) Using a boot ROM
 	This is probably the most elegant way of booting a diskless
 	client. With a boot ROM the kernel gets loaded using the TFTP
 	protocol. As far as I know, no commercial boot ROMs yet
@@ -194,6 +198,13 @@ depend on what facilities are available:
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
--=20
1.1.5


----- End forwarded message -----

--=20
Please reply to nico-kernel2 (same domain as sending address).
Replying to this address needs a confirmation, but works, too.

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRBvoyLOTBMvCUbrlAQIsMA//dMHGBrUI+TGvJ920RkWndcMEi8I4frb3
VWJ/xgKJ3t3H+73XtcwtpUErOchn+oeCgV489Yctr+5vuLK+8091ACqsBaw1xe0d
B/ZwqeiErx5kOn4yD/oUWuVkg+fc/r/QlssgEC782cgQT9vOQwW/2tmWgnA3+NtK
6T6WAKVgtOotoH5xHHBpQyq7/wNsr9b94sF9h9AC9yHGNa0m8oT0QqrCMHwqlvt3
Kl572av24+ROfL1t0T9xcVtozUinsfqnxJbFyCrv5/bMupbYCFapJTjiZSYZMxJh
U0OgFWW83dlGowam4mlZWSjxFQE0a5tjc0opCiFPVmeVowYEpw35ze/wbkd3xe3l
EHhdl/4iKe5lP6WKVgGeHpYqli7kpC2R38P4bTJe54n7JaxpzrEd6EQQaYCIJjSe
UjcfnawoNG957Q1TQ7LKUP/HFDOyJ/n8S8dIl+HQIDw1DhoNc8JLEAE9vOHL6BaL
MJdM/JVJQe+F3QWdUVece6bmYeKen1GhVnghe33GLNH9Rr5G/mjjglzzsjUpisVQ
6aDRxFq7zgNQGNh3H93W44wzmwcY+7EWHGRLluc7jMifnRX9S/51kx0S8SIuvWaR
MFhdH6loWOZL4tLjQcgo+ljbrTasCOr4O1Smrubc7AQ+tS34JVHa54dAml49g9+n
Lsn14BJKB0k=
=7wag
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
