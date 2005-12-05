Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVLEPNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVLEPNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVLEPNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:13:22 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:58708 "EHLO dipsaus.vs19.net")
	by vger.kernel.org with ESMTP id S932434AbVLEPNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:13:21 -0500
Date: Mon, 5 Dec 2005 16:13:02 +0100
From: Jasper Spaans <jasper@vs19.net>
To: dtor_core@ameritech.net, vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch] patchlet for logips2pp.c
Message-ID: <20051205151302.GB25577@spaans.vs19.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When booting, my kernel spits out:

[4294670.033000] logips2pp: Detected unknown logitech mouse model 85
[4294670.106000] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2

This is a simple wheel mouse, so the following patch should be OK for this
model:

diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2p=
p.c
index 31a59f7..9a0bbe8 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -226,6 +226,7 @@ static struct ps2pp_info *get_model_info
 		{ 80,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
 		{ 81,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
+		{ 85,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 86,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 96,	0,			0 },


Cheers,
--=20
Jasper Spaans                                       http://jsp.vs19.net/
 16:10:59 up 10519 days,  7:57, 0 users, load average: 7.10 7.28 5.99

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlFj+N+t4ZIsVDPgRAmITAJ94UrnUF4ttE091dsy3j1E7psAIOQCfS9qd
PE6oxZxydiMLWEhlffryduw=
=IXt/
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
