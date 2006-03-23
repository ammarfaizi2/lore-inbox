Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWCWN3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCWN3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWCWN3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:29:08 -0500
Received: from vesl.donpac.ru ([80.254.111.33]:5804 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S1750759AbWCWN3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:29:07 -0500
Date: Thu, 23 Mar 2006 16:29:03 +0300
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix DMI onboard device discovery
Message-ID: <20060323132903.GB8403@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
X-Uname: Linux 2.6.15-1-686 i686
User-Agent: Mutt/1.5.11
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

attached patch fixes invalid pointer arithmetic in DMI code to
make onboard device discovery working again. Tested and works.

Please consider applying.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dmi-fix
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.16.vanilla/arch/i386/kernel/dmi_=
scan.c linux-2.6.16/arch/i386/kernel/dmi_scan.c
--- linux-2.6.16.vanilla/arch/i386/kernel/dmi_scan.c	2006-03-22 21:07:32.00=
0000000 +0300
+++ linux-2.6.16/arch/i386/kernel/dmi_scan.c	2006-03-22 21:11:32.775227680 =
+0300
@@ -106,7 +106,7 @@ static void __init dmi_save_devices(stru
 	struct dmi_device *dev;
=20
 	for (i =3D 0; i < count; i++) {
-		char *d =3D ((char *) dm) + (i * 2);
+		char *d =3D ((char *) dm) + sizeof(struct dmi_header) + (i * 2);
=20
 		/* Skip disabled device */
 		if ((*d & 0x80) =3D=3D 0)

--tsOsTdHNUZQcU9Ye--

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIqKfPjHNUy6paxMRAqgkAKCGhMNo7Z8jCJOjf1KZOy7206RmgACgnk7l
KQnpeqV5b+mtOrpxBHXQEiA=
=0QKF
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
