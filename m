Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWCFCAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWCFCAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWCFCAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 21:00:31 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:36227 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S932160AbWCFCA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 21:00:29 -0500
Date: Mon, 6 Mar 2006 03:00:24 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] s390 - fix match in ccw modalias
Message-ID: <20060306020024.GA25620@wavehammer.waldi.eu.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

The attached patch fixes matching of devmodel in modaliases.

Martin: can you please push them through for 2.6.16? It breaks automatic
loading of any dasd module.

Bastian

--=20
The sight of death frightens them [Earthers].
		-- Kras the Klingon, "Friday's Child", stardate 3497.2

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=diff1

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index be97caf..c164b23 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -246,7 +246,7 @@ static int do_ccw_entry(const char *file
 	    id->cu_model);
 	ADD(alias, "dt", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
 	    id->dev_type);
-	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_TYPE,
+	ADD(alias, "dm", id->match_flags&CCW_DEVICE_ID_MATCH_DEVICE_MODEL,
 	    id->dev_model);
 	return 1;
 }

--xHFwDpU9dbj6ez1V--

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkQLl7cACgkQnw66O/MvCNEokwCfYGEaaoOfKwy2HyX9tQ/dnbq4
yfQAnjBbE8AUwe9g/jAPFY7yxid9IGSQ
=EirE
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
