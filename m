Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154050AbPGTK30>; Tue, 20 Jul 1999 06:29:26 -0400
Received: by vger.rutgers.edu id <S154079AbPGTK02>; Tue, 20 Jul 1999 06:26:28 -0400
Received: from Cantor.suse.de ([194.112.123.193]:2164 "HELO Cantor.suse.de") by vger.rutgers.edu with SMTP id <S154093AbPGTKZN>; Tue, 20 Jul 1999 06:25:13 -0400
Date: Tue, 20 Jul 1999 12:25:06 +0200
From: Kurt Garloff <garloff@suse.de>
To: SuSE Kernel Developers <kernel@suse.de>, Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: [PATCH] 2210 Make w/o /usr/include/linux
Message-ID: <19990720122506.A21397@bari.suse.de>
Mail-Followup-To: SuSE Kernel Developers <kernel@suse.de>, Linux kernel list <linux-kernel@vger.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=IiVenqGWf+H9Y6IX; micalg=pgp-md5; protocol="application/pgp-signature"
X-Mailer: Mutt 0.95.4i
X-Operating-System: Linux 2.2.10 i686
X-PGP-Info: on http://www.garloff.de/kurt/pgp.public.key.kurt.home.asc
X-PGP-Version: 2.6.3i
X-PGP-Key: 1024/CEFC9215
X-PGP-Fingerprint: 92 00 AC 56 59 50 13 83  3C 18 6F 1B 25 A0 3A 5F
Organization: =?iso-8859-1?Q?SuSE_GmbH=2C_N=FCrnberg=2C_FRG?=
Sender: owner-linux-kernel@vger.rutgers.edu


--IiVenqGWf+H9Y6IX
Content-Type: multipart/mixed; boundary=zhXaljGHf11kAtnf


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

if a link from /usr/include/linux to=20
/usr/src/where_ever/your/kernel/tree/actually/is/include/linux
is missing, you're in trouble for compiling some userspace apps.

However, the kernel compilation should not depend on it.

But the scripts/split-include does at the moment.H
Attached a patch to fix it.

--=20
Kurt Garloff  <garloff@suse.de>           SuSE GmbH, N=FCrnberg, FRG
Linux kernel development;      SCSI drivers: tmscsim(DC390), DC395

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Description: 2210-ipath.diff
Content-Disposition: attachment; filename=2210-ipath
Content-Transfer-Encoding: quoted-printable

--- linux-2.2.10.SuSE/Makefile~	Tue Jul 20 01:44:26 1999
+++ linux-2.2.10.SuSE/Makefile	Tue Jul 20 12:05:57 1999
@@ -466,7 +466,7 @@
 #
=20
 scripts/mkdep: scripts/mkdep.c
-	$(HOSTCC) $(HOSTCFLAGS) -o scripts/mkdep scripts/mkdep.c
+	$(HOSTCC) $(HOSTCFLAGS) -I$(HPATH) -o scripts/mkdep scripts/mkdep.c
=20
 scripts/split-include: scripts/split-include.c
-	$(HOSTCC) $(HOSTCFLAGS) -o scripts/split-include scripts/split-include.c
+	$(HOSTCC) $(HOSTCFLAGS) -I$(HPATH) -o scripts/split-include scripts/split=
-include.c

--zhXaljGHf11kAtnf--

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i

iQCVAwUBN5ROghaQN/7O/JIVAQEUdQP+LIQJjQRPpFGJXqanJN1nrCDEKX2AEVJp
Ycax1+70UWJMph9xxoW+FCArBMUJxGbX5c7Ad/WYqINLE7CO2QR52fUavLj0/vYi
iGg3SlpoaqnFTKwNWuGhseNrEaAdMkSpBtF1Xqo9VlBHySvYbi658EnJDFqy/efE
WT6RAfHSlKs=
=pAva
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
