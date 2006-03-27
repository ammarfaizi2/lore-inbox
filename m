Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWC0U2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWC0U2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC0U2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:28:55 -0500
Received: from [62.81.186.15] ([62.81.186.15]:211 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1750751AbWC0U2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:28:55 -0500
Date: Mon, 27 Mar 2006 22:28:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dont build altivec raid on x86
Message-ID: <20060327222833.3bd8f1fd@werewolf.auna.net>
In-Reply-To: <44231179.100@didntduck.org>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
	<20060323221525.52346ef7@werewolf.auna.net>
	<44231179.100@didntduck.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs171 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_RPBMjGaG+SGtqJZvFRYgC4i;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Mon, 27 Mar 2006 22:28:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_RPBMjGaG+SGtqJZvFRYgC4i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Somenthing like this ?

--- linux/drivers/md/Makefile	2005-09-01 19:34:55.000000000 +0200
+++ linux/drivers/md/Makefile.new	2006-03-27 22:15:00.000000000 +0200
@@ -10,10 +10,10 @@
 md-mod-objs     :=3D md.o bitmap.o
 raid6-objs	:=3D raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
-		   raid6int8.o raid6int16.o raid6int32.o \
-		   raid6altivec1.o raid6altivec2.o raid6altivec4.o \
-		   raid6altivec8.o \
-		   raid6mmx.o raid6sse1.o raid6sse2.o
+		   raid6int8.o raid6int16.o raid6int32.o
+raid6-$(CONFIG_ALTIVEC) :=3D	raid6altivec1.o raid6altivec2.o \
+							raid6altivec4.o raid6altivec8.o
+raid6-$(CONFIG_X86)		:=3D	raid6mmx.o raid6sse1.o raid6sse2.o
 hostprogs-y	:=3D mktables
=20
 # Note: link order is important.  All raid personalities


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam1 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1))

--Sig_RPBMjGaG+SGtqJZvFRYgC4i
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKErxRlIHNEGnKMMRAuyAAJ9zbPIt/GAC74TQt7Uaw+ZX5KyfVQCcDf+E
m/lY97G1P7/+fz1cBryWm24=
=q4Iy
-----END PGP SIGNATURE-----

--Sig_RPBMjGaG+SGtqJZvFRYgC4i--
