Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932813AbWGBTvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbWGBTvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 15:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWGBTvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 15:51:49 -0400
Received: from mail.gmx.net ([213.165.64.21]:37098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932813AbWGBTvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 15:51:48 -0400
X-Authenticated: #5082238
From: "Carsten Otto" <c-otto@gmx.de>
Date: Sun, 2 Jul 2006 21:51:45 +0200
To: linux-kernel@vger.kernel.org
Subject: Huge problem with XFS/iCH7R
Message-ID: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there!

(System specs below)

Short summary:
System (with software raid 5, XFS, four disks connected to AHCI
controller) crashes very often and loses data.

My system crashes every few days, at the moment daily. The message shown
is (the drive changes about every time, I do not see a pattern here):
---
ata4: handling error/timeout
ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
ata4: status=3D0x50 { DriveReady SeekComplete }
sdd: Current: sense key=3D0x0
	ASC=3D0x0 ASCQ=3D0x0
Info fid=3D0x0
---
Although according to this message only one of four drives failed (in
software RAID5) the system does not do anything useful. Hitting enter at
the login prompt does cause the password prompt to appear and no service
responds.

If I do a soft reset (using Magic Key u, then b) the BIOS does not detect
exactly one drive (which is the one shown in the error message I guess).
After a hard reset all drives are found, but I have to do a raid resync and
xfs_repair (at least, sometimes the raid needs to be tricked into starting).

This problem occured with all kernels (all vanilla), starting with
2.6.16.something up to 2.6.17.2.
I checked all four drives with a Maxtor tool, all drives are fine.
The temperature is not a problem, all drives are stable at about 35=B0C.
I replaced the SATA cables several times.

Some images showing the errors on screen are here:
http://c-otto.de/fehler/

I'd like to know what component causes this problem and how I can solve
it.

Please tell me if you need further information!

System specs:
- Intel iCH7R on Foxconn 945P7AA-EKRS2
- Pentium D 805 (2.66 GHz, 1MB Cache, Dual Core)
- 4x Maxtor 7V300F0 (MaXLine Plus III 300 GB; Sata 2; 16 MB Cache)
- 2 GB RAM

PS: Please include me in CC as I do not read the whole LKML.

Thanks a lot,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEqCPRjUF4jpCSQBQRAtTPAJ4+Ky53Zr/7xN62poPa7/1FXSnveACeODlG
LsXLenK+DJXHgqD475FpOo8=
=niEm
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
