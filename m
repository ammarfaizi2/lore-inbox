Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTIACY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbTIACY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 22:24:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46837 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S262874AbTIACYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 22:24:19 -0400
Date: Sun, 31 Aug 2003 22:15:41 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Subject: [PATCH] IO-APIC.txt Documentation
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Message-id: <20030901021541.GA4574@Krystal>
X-Info: http://krystal.dyndns.org
MIME-version: 1.0
Content-type: multipart/signed; boundary="=_Krystal-4788-1062382541-0001-2";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Editor: vi
X-Operating-System: Linux/2.4.20 (i586)
X-Uptime: 22:04:53 up  4:26,  2 users,  load average: 0.15, 0.03, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-4788-1062382541-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I found that with a recent version of scanpci, the -v parameter must be
used in order to get PCI boards'IRQ. It then lists the IRQ in
hexadecimal format (pirq=3D0x0e,0x0a,0x0b,0x0e for example), which I hope
are syntaxically correct for the pirq option of the kernel.


Mathieu Desnoyers

--
Mathieu Desnoyers <compudj@krystal.dyndns.org>
--- linux-2.4.20/Documentation/i386/IO-APIC.txt	2000-08-21 11:57:35.0000000=
00 -0400
+++ linux-2.4.20-md/Documentation/i386/IO-APIC.txt	2003-08-31 21:54:25.0000=
00000 -0400
@@ -83,7 +83,7 @@
 the following script tries to figure out such a default pirq=3D line from
 your PCI configuration:
=20
-	echo -n pirq=3D; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
+	echo -n pirq=3D; echo `scanpci -v | grep T_L | cut -c56-` | sed 's/ /,/g'
=20
 note that this script wont work if you have skipped a few slots or if your
 board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-4788-1062382541-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/UqvMPyWo/juummgRAtFbAJ9hIXO8f8L09gDYf/oDC2wS6sbH0gCghgg/
smArU/2ITFbV46XxWDwJtXY=
=s2YK
-----END PGP SIGNATURE-----

--=_Krystal-4788-1062382541-0001-2--
