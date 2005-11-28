Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVK1MSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVK1MSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVK1MSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:18:14 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:15807 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751256AbVK1MSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:18:14 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: ide-cd doesn't replace ide-scsi?
Date: Mon, 28 Nov 2005 12:18:11 +0000
User-Agent: KMail/1.9
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8228205.pfpLSzteVH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511281218.17141.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8228205.pfpLSzteVH
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FWviDlh+ekQyv8v"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_FWviDlh+ekQyv8v
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Note: results are with 2.6.13 (-gentoo-r4 + supermount) and 2.6.14 (-gentoo)
I've been struggling with burning DVD+R DL discs and upgrading the firmware=
 on=20
my DVD burner, and just today decided to rmmod ide-cd and try using ide-scs=
i.=20
Turns out it works... so is ide-cd *supposed* to handle cases other than=20
simple reading and burning or is this a bug? If not a bug, should ide-scsi=
=20
really be marked as deprecated?
Also, two bugs with ide-scsi:
1. On loading the module, it detects and allocates 6 SCSI devices for a sin=
gle=20
DVD burner (Toshiba ODD-DVD SD-R5272); kernel log for this event attached
2. On attempted unloading of the module, rmmod says 'Killed' and the module=
=20
stays put, corrupt. There was some kind of error in dmesg, but it appears t=
o=20
have avoided syslog-- If I see it again, I'll save it.
=2D-=20
Luke-Jr
Developer, Utopios
http://utopios.org/

--Boundary-01=_FWviDlh+ekQyv8v
Content-Type: text/plain;
  charset="us-ascii";
  name="ide-scsi.manyburners.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-scsi.manyburners.txt"

Nov 28 04:13:14 [kernel] ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Nov 28 04:13:14 [kernel] scsi2 : SCSI host adapter emulation for IDE ATAPI devices
Nov 28 04:13:15 [kernel] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lun 0
Nov 28 04:13:15 [kernel] sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 1
Nov 28 04:13:15 [kernel] sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr2 at scsi2, channel 0, id 0, lun 2
Nov 28 04:13:15 [kernel] sr3: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr3 at scsi2, channel 0, id 0, lun 3
Nov 28 04:13:15 [kernel] sr4: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr4 at scsi2, channel 0, id 0, lun 4
Nov 28 04:13:15 [kernel] sr5: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr5 at scsi2, channel 0, id 0, lun 5
Nov 28 04:13:15 [kernel] sr6: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr6 at scsi2, channel 0, id 0, lun 6
Nov 28 04:13:15 [kernel] sr7: scsi3-mmc drive: 62x/62x writer cd/rw xa/form2 cdda tray
Nov 28 04:13:15 [kernel] Attached scsi CD-ROM sr7 at scsi3, channel 0, id 0, lun 0
--Boundary-01=_FWviDlh+ekQyv8v--

--nextPart8228205.pfpLSzteVH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDivWJZl/BHdU+lYMRAsqbAJ4mfu9F1Whk6HAOPY3jLnfHGs2sswCfbmYa
CnHRthWyl+jJ2Kjjo8kW1jw=
=7CFg
-----END PGP SIGNATURE-----

--nextPart8228205.pfpLSzteVH--
