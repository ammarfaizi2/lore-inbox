Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTIUHyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 03:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTIUHyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 03:54:46 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:46222 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262347AbTIUHyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 03:54:43 -0400
Date: Sun, 21 Sep 2003 10:54:30 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move some more intilization out of drivers/char/mem.c
Message-ID: <20030921075430.GA4938@actcom.co.il>
References: <20030920132900.GC23153@lst.de> <20030920160645.30c2745d.akpm@osdl.org> <20030921063030.GA1508@lst.de> <20030920234853.7e09f663.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20030920234853.7e09f663.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2003 at 11:48:53PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > > Please compile-test things...
> >=20
> >  Well, I compiled this here.  I see, looks like I lost half of the patch
> >  when sending it to you.  Sorryh for that, here's the full patch:
>=20
> It still generates warnings.  I suggest you build kernels with a script
> which saves up stderr and spits it all out at the end.  That way, these
> things are noticed.

This might be a good time to recommend -Werror. Last time it came up
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D102654562025374&w=3D2),
Alan was dead set against it, and Linus did not apply it, but did
think it had some merit
(http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D102658611213914&w=3D2).=
=20

Compiling 2.6.0-t5-cvs with my .config and -Werror uncovered only two
warnings. Patches sent seperately.=20

diff --exclude-from /home/muli/p/dontdiff -Naur ../linux-2.5/Makefile 2.6.0=
-t5-Werror/Makefile
--- ../linux-2.5/Makefile	Wed Sep 10 16:21:16 2003
+++ 2.6.0-t5-Werror/Makefile	Sun Sep 21 09:59:29 2003
@@ -73,7 +73,7 @@
=20
 HOSTCC  	=3D gcc
 HOSTCXX  	=3D g++
-HOSTCFLAGS	=3D -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	=3D -Wall -Werror -Wstrict-prototypes -O2 -fomit-frame-pointer
 HOSTCXXFLAGS	=3D -O2
=20
=20
@@ -223,8 +223,8 @@
 NOSTDINC_FLAGS  =3D -nostdinc -iwithprefix include
=20
 CPPFLAGS	:=3D -D__KERNEL__ -Iinclude
-CFLAGS 		:=3D -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fno-strict-aliasing -fno-common
+CFLAGS 		:=3D -Wall -Werror -Wstrict-prototypes -Wno-trigraphs \
+		   -O2 -fno-strict-aliasing -fno-common
 AFLAGS		:=3D -D__ASSEMBLY__
=20
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \

-- =20
Muli Ben-Yehuda
http://www.mulix.org


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/bVk2KRs727/VN8sRAsT7AKCSlmC/CAFzy05mJnLI+P0gmXyqogCZASYE
rhnDkvy/NSkVNs8k7ZrG+tc=
=XhAZ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
