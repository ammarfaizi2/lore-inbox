Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTK3WjM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTK3WjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:39:12 -0500
Received: from maximus.kcore.de ([213.133.102.235]:55580 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S261660AbTK3Wi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:38:58 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Need help with diagnosing SCSI related (probably hardware?) problem (DC395 driver)
Date: Sun, 30 Nov 2003 23:38:31 +0100
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_1Fny/2idILQu2U7";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311302338.45519.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_1Fny/2idILQu2U7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

since I couple of days I have the following problem. Though I have no idea =
how=20
to diagnose it and what is causing it. Maybe someone has a clue if I post i=
t=20
here.

My SCSI chain:
Tekram DC395, using the driver from Kurt Garloff=20
(http://www.garloff.de/kurt/linux/dc395/)
Attached is a TEAC CD-R56S4 CDR drive and Panasonic LF-D101 DVD-RAM drive. =
I=20
use the DVD-RAM to backup stuff, usually 2 GB gets written to a medium as o=
ne=20
file.

Since a couple of days however the system just freezes during the backup. A=
s=20
the drive LED of the CD burner blinks every minute or so I suspect Linux is=
=20
trying to issue a SCSI reset, because something (presumable the DVD-RAM=20
drive) got stuck. This happens endlessly until I press the reset button.

If the system is frozen, no keyboard input works, the screen is not updated=
=20
anymore. You can ping the system, but not ssh into. There is no hard disk=20
activity and everything that tries to access the hard disk seems to get stu=
ck=20
also. ssh'ing into the machine before starting the backup and using "tail -=
f=20
/var/log/messages" doesn't give any output.

After a reset when the SCSI controller BIOS inits it gets stuck when scanni=
ng=20
ID2, which is the DVD-RAM drive. Only power cycling gets it to boot again. =
So=20
I guess this device might be the problem. Though it's kinda annoying that t=
he=20
kernel gets stuck in this endless reset loop (or whatever happens at that=20
time) needing to reset the box. Which also makes it practically impossible =
to=20
debug this problem any further and definitely find out what the problem is.

If anyone has further ideas I could try I'd be happy to hear about them. I=
=20
only want to dump the drive if I can really be sure that it's broken.

Thanks! :)

Oliver

=2D-=20
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

--Boundary-02=_1Fny/2idILQu2U7
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ynF1OpifZVYdT9IRAiD/AKCsXsuQ5OTX/rP8bqBNfyLafjxlHACePZWk
NyLJlx0UV/+886A31ONn69Y=
=V8+t
-----END PGP SIGNATURE-----

--Boundary-02=_1Fny/2idILQu2U7--

