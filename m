Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUAPRiB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUAPRiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:38:01 -0500
Received: from smtp04.web.de ([217.72.192.208]:2318 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265500AbUAPRh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:37:58 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1-mm4
Date: Fri, 16 Jan 2004 18:37:49 +0100
User-Agent: KMail/1.5.4
References: <20040115225948.6b994a48.akpm@osdl.org>
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_tFCCASc+11IE48h";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401161837.49588.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_tFCCASc+11IE48h
Content-Type: multipart/mixed;
  boundary="Boundary-01=_tFCCAI4XgdaVBCn"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_tFCCAI4XgdaVBCn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

the patch "PP4-bwqcam-RC1" includes a small typo which leads to the undefin=
ed=20
symbol 'strcnmp'. The attaches patch corrects this typo.

Best regards
   Thomas Schlichter

--Boundary-01=_tFCCAI4XgdaVBCn
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-bw-qcam-typo.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix-bw-qcam-typo.diff"

=2D-- linux-2.6.1-mm4/drivers/media/video/bw-qcam.c.orig	2004-01-16 16:42:2=
7.178216712 +0100
+++ linux-2.6.1-mm4/drivers/media/video/bw-qcam.c	2004-01-16 16:42:51.53451=
3992 +0100
@@ -963,7 +963,7 @@
 #ifdef MODULE
 	int n;
=20
=2D	if (parport[0] && strcnmp(parport[0], "auto", 4) !=3D 0) {
+	if (parport[0] && strncmp(parport[0], "auto", 4) !=3D 0) {
 		/* user gave parport parameters */
 		for(n=3D0; parport[n] && n<MAX_CAMS; n++){
 			char *ep;

--Boundary-01=_tFCCAI4XgdaVBCn--

--Boundary-03=_tFCCASc+11IE48h
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBACCFtYAiN+WRIZzQRAhlMAKDCYVnvjiIUUB+yCZ8fb/8WCLtO+QCfUt/z
YtH7AzN494z3jyQxA9mbDYM=
=OdBD
-----END PGP SIGNATURE-----

--Boundary-03=_tFCCASc+11IE48h--

