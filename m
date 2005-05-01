Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVEAQWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVEAQWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEAQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 12:22:53 -0400
Received: from mx1.mail.ru ([194.67.23.121]:2370 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261674AbVEAQV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 12:21:59 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: init 1 kill khubd on 2.6.11
Date: Sun, 1 May 2005 20:21:56 +0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4170178.klHvLrPGtH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505012021.56649.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4170178.klHvLrPGtH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hub driver is using SIGKILL to terminate khubd. Unfortunately on a number o=
f=20
distributions switching init levels implicitly does "killall -9", killing=20
khubd. The only way to restart it is to reload USB subsystem.

Is signal usage in this case really needed? What about replacing it with=20
simple flag (i.e. will patch be accepted)?

TIA

=2Dandrey

Please Cc me on reply

--nextPart4170178.klHvLrPGtH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCdQIkR6LMutpd94wRAozFAJ0RKbjn4R+eNbguTEBMCmh12wk7PACgtvtP
25yXFZltRS3LAM6d5xF173s=
=hJxO
-----END PGP SIGNATURE-----

--nextPart4170178.klHvLrPGtH--
