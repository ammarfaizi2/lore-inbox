Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279061AbRKGJpD>; Wed, 7 Nov 2001 04:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278639AbRKGJox>; Wed, 7 Nov 2001 04:44:53 -0500
Received: from [194.51.220.145] ([194.51.220.145]:63165 "EHLO emeraude")
	by vger.kernel.org with ESMTP id <S279061AbRKGJon>;
	Wed, 7 Nov 2001 04:44:43 -0500
Date: Wed, 7 Nov 2001 10:44:05 +0100
From: Stephane Jourdois <stephane@tuxfinder.org>
To: Massimo Dal Zotto <dz@cs.unitn.it>
Cc: LKLM <linux-kernel@vger.kernel.org>, "Marcel J. E. Mol" <marcel@mesa.nl>,
        Juri Haberland <juri@koschikode.com>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011107104405.A3168@emeraude.kwisatz.net>
Reply-To: stephane@tuxfinder.org
In-Reply-To: <20011105231759.02B541195E@a.mx.spoiled.org> <200111061645.RAA02115@fandango.cs.unitn.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <200111061645.RAA02115@fandango.cs.unitn.it>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14
X-Send-From: emeraude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2001 at 05:45:13PM +0100, Massimo Dal Zotto wrote:
> I have released version 1.2 of the driver. It contains Stephane's patches
> for the I8100, a new i8kmon and some documentation. You can download from:
>     http://www.debian.org/~dz/i8k/

Hello,

Here is my patch to i8kutils-1.2 :

=3D=3D=3D=3D=3D=3D
diff -u i8kutils-1.2.orig/i8kbuttons.c i8kutils-1.2/i8kbuttons.c
--- i8kutils-1.2.orig/i8kbuttons.c      Tue Nov  6 20:07:27 2001
+++ i8kutils-1.2/i8kbuttons.c   Tue Nov  6 20:11:19 2001
@@ -53,15 +53,7 @@

     DPRINTF("exec_cmd: %s\n", cmd);

-    if ((rc=3Dfork()) < 0) {
-       perror("fork failed");
-       return;
-    }
-
-    if (rc =3D=3D 0) {
-       execl("/bin/sh", "sh", "-c", cmd, NULL);
-       exit(0);
-    }
+    system(cmd);
 }
=20
 static int
=3D=3D=3D=3D=3D=3D

Without that, I get as much zombies processes as I have pressed the
volume buttons :-) I know system() is not great, but as security is not
a problem here...
I use debian/sid, and aumix as the mixer.


Now a fundamental question :
Does the load of the i8k module inhibits the fans start ? I can see my
processor temp increasing (I saw 80=B0C ...) without the fans start. Then
I started i8kmon to avoid an explosion. If the modules inhibits material
protections, then if that can be modified, it would be great ; if not,
i8kmon needs to get included in the kernel as a daemon. The i8kmon
should be a funny tool, not a system critical tool.

Also, I couldn't understand why sometimes the left fan is printed on red
color in i8kmon...


Thank you,

	Stephane


--=20
 ///  Stephane Jourdois        	/"\  ASCII RIBBON CAMPAIGN \\\
(((    Ing=E9nieur d=E9veloppement 	\ /    AGAINST HTML MAIL    )))
 \\\   6, av. de la Belle Image	 X                         ///
  \\\  94440 Marolles en Brie  	/ \    +33 6 8643 3085    ///

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvpAmUACgkQk2dpMN4A2NPeLACeN73+7Ui5EP4GQ7EwkdtSPGvE
TyoAnRTXE3t9GOo43sBDMxswbf20UGir
=QOJJ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
