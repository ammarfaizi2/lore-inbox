Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUITIfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUITIfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 04:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUITIfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 04:35:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266137AbUITIfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 04:35:47 -0400
Subject: Re: 2.6.8 link failure for powerpc-970?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <414E93BC.4080107@kegel.com>
References: <414E93BC.4080107@kegel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EgtjatEo4KtNbHYFeRwI"
Organization: Red Hat UK
Message-Id: <1095669339.2800.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Sep 2004 10:35:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EgtjatEo4KtNbHYFeRwI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-09-20 at 10:24, Dan Kegel wrote:
> I'm trying to verify that I can build toolchains and compile
> and link kernels for a large set of CPU types using simple kernel config =
files.
> I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
> So any problems I run into are a bit hard to pin down to
> compiler, kernel, or user error, since this is mostly new territory for m=
e.

use this patch
--- linux-2.6.8/arch/ppc64/Makefile~    2004-09-03 13:02:48.372244432
+0200
+++ linux-2.6.8/arch/ppc64/Makefile     2004-09-03 13:02:48.372244432
+0200
@@ -28,5 +28,7 @@
 LDFLAGS_vmlinux        :=3D -Bstatic -e $(KERNELLOAD) -Ttext
$(KERNELLOAD)
 CFLAGS         +=3D -msoft-float -pipe -mminimal-toc -mtraceback=3Dnone
+
+CFLAGS +=3D $(call cc-option,-mcall-aixdesc)
                                                                           =
                               =20
 ifeq ($(CONFIG_POWER4_ONLY),y)
        CFLAGS +=3D $(call cc-option,-mcpu=3Dpower4)
                                                                           =
                               =20


--=-EgtjatEo4KtNbHYFeRwI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBTpZaxULwo51rQBIRAuUxAJ9QwsfJniICBBVRc27CHDAWQ9nfjACfT1KA
dZWAGFoEn08tQ71cNNQP0AA=
=FdAP
-----END PGP SIGNATURE-----

--=-EgtjatEo4KtNbHYFeRwI--

