Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTJIK3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJIK3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:29:31 -0400
Received: from M947P005.adsl.highway.telekom.at ([62.47.150.69]:59008 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S261966AbTJIK3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:29:30 -0400
Date: Thu, 9 Oct 2003 12:29:29 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Tim Waugh <twaugh@redhat.com>, SamRavnborg <sam@ravnborg.org>
Subject: [patch 2.6] add warning DocBook/Makefile
Message-ID: <20031009102929.GA1138@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixes the following error message,
when transfig - utilities for converting XFig figure files -
is not installed:

/bin/sh: fig2dev: command not found
make[1]: *** [Documentation/DocBook/parport-share.eps] Error 127
make: *** [pdfdocs] Error 2


please apply
ma(ks|x(imilian)?)


--- linux-2.6.0-test7/Documentation/DocBook/Makefile	2003-10-08 21:24:05.00=
0000000 +0200
+++ linux/Documentation/DocBook/Makefile	2003-10-09 11:41:27.000000000 +0200
@@ -149,12 +149,18 @@
       cmd_fig2eps =3D fig2dev -Leps $< $@
=20
 %.eps: %.fig
+	@(which fig2dev > /dev/null 2>&1) || \
+	 (echo "*** You need to install transfig ***"; \
+	  exit 1)
 	$(call cmd,fig2eps)
=20
 quiet_cmd_fig2png =3D FIG2PNG $@
       cmd_fig2png =3D fig2dev -Lpng $< $@
=20
 %.png: %.fig
+	@(which fig2dev > /dev/null 2>&1) || \
+	 (echo "*** You need to install transfig ***"; \
+	  exit 1)
 	$(call cmd,fig2png)
=20
 ###

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hTiJ6//kSTNjoX0RAldkAJ0UsLK1INSd8rOVzNoyQxfg2+5MzACdEY47
gFMqGCrIlRT5kd/WeeUrFVo=
=OEZo
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
