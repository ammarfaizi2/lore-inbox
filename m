Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWGSJQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGSJQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWGSJQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:16:02 -0400
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:41629 "EHLO
	mail.enneenne.com") by vger.kernel.org with ESMTP id S964773AbWGSJQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:16:00 -0400
Date: Wed, 19 Jul 2006 11:16:00 +0200
From: Rodolfo Giometti <giometti@linux.it>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Message-ID: <20060719091559.GD25330@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] no console disabling during suspend stage
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: multipart/mixed; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a little patch to avoid disabling console during suspend stage
while we are debugging kernel.

Ciao,

Rodolfo

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-no-console-disabling-on-kernel-debugging
Content-Transfer-Encoding: quoted-printable

--- kernel/power/main.c	2006-07-19 10:54:11.000000000 +0200
+++ kernel/power/main.c.new	2006-07-18 19:38:41.000000000 +0200
@@ -86,7 +86,9 @@
 			goto Thaw;
 	}
=20
+#ifndef CONFIG_DEBUG_KERNEL
 	suspend_console();
+#endif
 	if ((error =3D device_suspend(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Finish;

--uXxzq0nDebZQVNAZ--

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEvfhPQaTCYNJaVjMRArQ/AJ9kH8tD9+4Ns9dePH7itlofL9XqvACgk+ur
ne26TtLGRWhHpAkSQBOmV64=
=Wnji
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
