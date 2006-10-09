Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWJIAMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWJIAMb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 20:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWJIAMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 20:12:31 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:30159 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1751559AbWJIAMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 20:12:30 -0400
From: Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To: Paul.Clements@steeleye.com
Subject: [patch] pull in linux/types.h in linux/nbd.h
Date: Sun, 8 Oct 2006 20:12:27 -0400
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rPZKFM8/iRrBWrM"
Message-Id: <200610082012.27879.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rPZKFM8/iRrBWrM
Content-Type: multipart/signed;
  boundary="nextPart3328870.Ap8H21CUEP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3328870.Ap8H21CUEP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the nbd header uses __be32 and such types but doesnt actually include the=20
header that defines these things (linux/types.h); so lets include it
=2Dmike

--nextPart3328870.Ap8H21CUEP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARSmT60FjO5/oN/WBAQLVOA//bERJLzo2QqR4rPkMTUY7VbtHnrfm/Zae
9SbXiM2KvhSOm6rAg4xfpoZoYOji6J5wRf/RdIoRJKCtn+Epwlot4pVebfKMMT33
rL4eDjPsQG/6JuZyavNq9UmVvVLvtmxJvcEc5Dd0U2HGPgOI7wM1fayF5kxvQTOp
Ym/esFl6Lrn3OoD0baw5rw9pxVhXt6ZGcNluKtZ2KRdxRRpUi72A+gOaP1YDRp0p
5UXuCw16BEV9FT2Bg0TcfNR5CnGsJHT/QGAbhZHgl00YInUIAchdKV5G3nHrzW77
OHfPRchy/2dE91xfe8/g9oqAbvAvnd45rUPuUaYoEApVnyq+cTSwTA8i734DbEel
CDi8bHb02NxbHJrPco1gttVfJcNig5e4y59aS7gsCeVNeCR2t515MlY+EAEQbH82
pbbjgetQc4QuXEiJ/5ogDS+yyoig/ZHjF1QgQiQeCQN2skUPvBPXdy1mDjApk3Wl
WSqD9CixX3xu+URoE94S3IBj5ZiTlNk07wN94GUv4zZyhccMdw5ZMQ5BydqbN08G
1y4K95ULfD3dik76NtPUHdWLJUuTJNVQBTFWXQKfnpomc2jRQdt2iU4TvR2kUBtG
LwjTtkZD4pp6Htm5+AwD//xq62LuXnmw37Js4ApckFVK1TZXhaUT5gNjKjenMekj
5fBPSEsYvgw=
=7MG0
-----END PGP SIGNATURE-----

--nextPart3328870.Ap8H21CUEP--

--Boundary-00=_rPZKFM8/iRrBWrM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="nbd-needs-linux-types.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="nbd-needs-linux-types.patch"

the nbd header uses __be32 and such types but doesnt actually include the
header that defines these things (linux/types.h); so lets include it

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

diff --git a/include/linux/nbd.h b/include/linux/nbd.h
index e712e7d..d6b6dc0 100644
--- a/include/linux/nbd.h
+++ b/include/linux/nbd.h
@@ -15,6 +15,8 @@
 #ifndef LINUX_NBD_H
 #define LINUX_NBD_H
 
+#include <linux/types.h>
+
 #define NBD_SET_SOCK	_IO( 0xab, 0 )
 #define NBD_SET_BLKSIZE	_IO( 0xab, 1 )
 #define NBD_SET_SIZE	_IO( 0xab, 2 )

--Boundary-00=_rPZKFM8/iRrBWrM--
