Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSCWDsC>; Fri, 22 Mar 2002 22:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSCWDrx>; Fri, 22 Mar 2002 22:47:53 -0500
Received: from dozer.billjonas.com ([207.106.130.91]:34309 "EHLO
	dozer.billjonas.com") by vger.kernel.org with ESMTP
	id <S292231AbSCWDrm>; Fri, 22 Mar 2002 22:47:42 -0500
Date: Fri, 22 Mar 2002 22:46:30 -0500
From: Bill Jonas <bill@billjonas.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] ide-scsi documentation fix (2.4.19-pre4 and 2.5.7)
Message-ID: <20020322224629.K20274@billjonas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PcDVawgyoD+Fem/v"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Ambivalence: Maybe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PcDVawgyoD+Fem/v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the course of a discussion on a LUG mailing list, I noticed that the
Configure.help text for CONFIG_BLK_DEV_IDESCSI is incorrect.  It
indicates that you should use "hdx=3Dscsi" on the kernel command line to
prevent devices from getting claimed by the regular IDE drivers;
actually, it should be "hdx=3Dide-scsi".  The incorrect documentation
exists in 2.4.19-pre4 as well as 2.5.7.  2.2 does not have the problem;
it does not state what the parameter should be.  The bootparam(7) man
page does not cover this particular command-line option.

Here is a patch for 2.4.19-pre4:

diff -r --unified linux-2.4.19-pre4.orig/Documentation/Configure.help linux=
-2.4.19-pre4/Documentation/Configure.help
--- linux-2.4.19-pre4.orig/Documentation/Configure.help	Fri Mar 22 21:00:18=
 2002
+++ linux-2.4.19-pre4/Documentation/Configure.help	Fri Mar 22 21:03:30 2002
@@ -734,7 +734,7 @@
   you can then use this emulation together with an appropriate SCSI
   device driver. In order to do this, say Y here and to "SCSI support"
   and "SCSI generic support", below. You must then provide the kernel
-  command line "hdx=3Dscsi" (try "man bootparam" or see the
+  command line "hdx=3Dide-scsi" (try "man bootparam" or see the
   documentation of your boot loader (lilo or loadlin) about how to
   pass options to the kernel at boot time) for devices if you want the
   native EIDE sub-drivers to skip over the native support, so that

Here is a patch for 2.5.7:

diff -r --unified linux-2.5.7.orig/drivers/ide/Config.help linux-2.5.7/driv=
ers/ide/Config.help
--- linux-2.5.7.orig/drivers/ide/Config.help	Fri Mar 22 21:31:23 2002
+++ linux-2.5.7/drivers/ide/Config.help	Fri Mar 22 22:28:14 2002
@@ -160,7 +160,7 @@
   you can then use this emulation together with an appropriate SCSI
   device driver. In order to do this, say Y here and to "SCSI support"
   and "SCSI generic support", below. You must then provide the kernel
-  command line "hdx=3Dscsi" (try "man bootparam" or see the
+  command line "hdx=3Dide-scsi" (try "man bootparam" or see the
   documentation of your boot loader (lilo or loadlin) about how to
   pass options to the kernel at boot time) for devices if you want the
   native EIDE sub-drivers to skip over the native support, so that

If there are any replies or further questions, please CC: me, as I am
not subscribed to linux-kernel ATM.

Thanks.

--=20
Bill Jonas    *    bill@billjonas.com    *    http://www.billjonas.com/

Developer/SysAdmin for hire!   See http://www.billjonas.com/resume.html

--PcDVawgyoD+Fem/v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8m/qUdmHcUxFvDL0RAtT5AJ9ItMq/X1PVXc3j2i5kp8tON17A1QCeNWp5
B+MsNPxSewJ1li7gBs6IAtI=
=jqbZ
-----END PGP SIGNATURE-----

--PcDVawgyoD+Fem/v--
