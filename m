Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUAPRdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUAPRdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:33:23 -0500
Received: from smtp05.web.de ([217.72.192.209]:15910 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265597AbUAPRc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:32:56 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm4
Date: Fri, 16 Jan 2004 18:32:39 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040115225948.6b994a48.akpm@osdl.org> <200401160845.17199.edt@aei.ca>
In-Reply-To: <200401160845.17199.edt@aei.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_8ACCAO9FeVQhvlw";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401161832.44967.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_8ACCAO9FeVQhvlw
Content-Type: multipart/mixed;
  boundary="Boundary-01=_3ACCAVvUjSfIUnn"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_3ACCAVvUjSfIUnn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

Am Freitag, 16. Januar 2004 14:45 schrieb Ed Tomlinson:
> Hi Andrew,
>
> Doing a modules install with mm4 gets a nfsd.ko needs unknown symbol
> dnotify_parent
>
> Ideas?
> Ed Tomlinson

This came with the "nfsd-04-add-dnotify-events" patch. The patch attached t=
o=20
this mail exports the symbol 'dnotify_parent' and fixes the problem for me.=
=2E.

Best regards
   Thomas Schlichter

--Boundary-01=_3ACCAVvUjSfIUnn
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="export-dnotify_parent.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="export-dnotify_parent.diff"

=2D-- linux-2.6.1-mm4/fs/dnotify.c.orig	2004-01-16 17:46:40.844370408 +0100
+++ linux-2.6.1-mm4/fs/dnotify.c	2004-01-16 17:48:46.045336968 +0100
@@ -166,6 +166,8 @@
 	}
 }
=20
+EXPORT_SYMBOL(dnotify_parent);
+
 static int __init dnotify_init(void)
 {
 	dn_cache =3D kmem_cache_create("dnotify_cache",

--Boundary-01=_3ACCAVvUjSfIUnn--

--Boundary-03=_8ACCAO9FeVQhvlw
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBACCA8YAiN+WRIZzQRAjQYAJ0YbFLy1wpWxTiuTx1Ed9SYeFZEDwCeI2Yr
XX0ujnEfjDRE5tEZgD36hUU=
=0bzx
-----END PGP SIGNATURE-----

--Boundary-03=_8ACCAO9FeVQhvlw--

