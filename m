Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUCQVLC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCQVKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:10:35 -0500
Received: from phobos01.frii.net ([216.17.128.161]:13830 "EHLO mail.frii.com")
	by vger.kernel.org with ESMTP id S262071AbUCQVJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:09:54 -0500
From: Doug Holland <meldroc@frii.com>
Reply-To: meldroc@frii.com
To: linux-kernel@vger.kernel.org
Subject: Mount Rainier CD-RW problems.
Date: Wed, 17 Mar 2004 14:09:37 -0700
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_d6LWAUbyA/f7HCU";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403171409.50369.meldroc@frii.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_d6LWAUbyA/f7HCU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm running kernel 2.6.4, from the Debian source packages, and also with Co=
n=20
Kolivas' desktop performance patchset.

I'm trying to get Mount Rainier CD-RW writing working.  The drive is a=20
generically rebranded LITE-ON COMBO LTC-48161H combo DVD/CD-RW drive, which=
=20
is supposed to have Mt. Rainier support.  The drive works fine for reading=
=20
CD-ROMs, writing non Mt. Rainier CD-Rs, audio CDs, DVDs, etc.

I formatted a CD-RW using cdmrw, then tried mounting it and copying files t=
o=20
it.  It pretends to work, but when I do an ls to see the files I supposedly=
=20
wrote, I get a lot of permission denied errors.  If I umount the disk then=
=20
remount it, the files are missing.

I checked /var/log/syslog and got a lot of this:

Mar 17 13:41:37 localhost vmunix: hdc: tray open
Mar 17 13:41:37 localhost vmunix: end_request: I/O error, dev hdc, sector=20
12032
Mar 17 13:41:37 localhost vmunix: UDF-fs DEBUG=20
fs/udf/inode.c:1317:udf_update_inode: bread failure
Mar 17 13:42:03 localhost kernel: hdc: tray open
Mar 17 13:42:03 localhost kernel: end_request: I/O error, dev hdc, sector 6=
016
Mar 17 13:42:03 localhost kernel: UDF-fs DEBUG=20
fs/udf/inode.c:1317:udf_update_inode: bread failure

as well as=20

ar 17 13:45:48 localhost vmunix: VFS: busy inodes on changed media.
Mar 17 13:46:03 localhost vmunix: UDF-fs DEBUG=20
fs/udf/misc.c:286:udf_read_tagged: location mismatch block 1505, tag=20
2863311530 !=3D 97
Mar 17 13:46:03 localhost vmunix: udf: udf_read_inode(ino 1505) failed !bh
Mar 17 13:46:03 localhost vmunix: UDF-fs DEBUG=20
fs/udf/misc.c:286:udf_read_tagged: location mismatch block 1572, tag=20
4294967295 !=3D 164
Mar 17 13:46:03 localhost vmunix: udf: udf_read_inode(ino 1572) failed !bh
Mar 17 13:46:03 localhost vmunix: UDF-fs DEBUG=20
fs/udf/misc.c:286:udf_read_tagged: location mismatch block 1635, tag=20
2863311530 !=3D 227
Mar 17 13:46:03 localhost vmunix: udf: udf_read_inode(ino 1635) failed !bh
Mar 17 13:46:03 localhost vmunix: UDF-fs DEBUG=20
fs/udf/misc.c:286:udf_read_tagged: location mismatch block 1940, tag=20
2863311530 !=3D 532

Any idea what's going on?

Doug

--Boundary-02=_d6LWAUbyA/f7HCU
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAWL6daI9tShILUQARAt0aAKC673TdJlo1Lwb/00pdZNGhYfK3BgCgzb48
qLS2WMhvcKY99uvygrRrUqo=
=I7wh
-----END PGP SIGNATURE-----

--Boundary-02=_d6LWAUbyA/f7HCU--
