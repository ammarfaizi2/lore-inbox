Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283413AbRK2V7P>; Thu, 29 Nov 2001 16:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283416AbRK2V7F>; Thu, 29 Nov 2001 16:59:05 -0500
Received: from pec-4-46.tnt1.m2.uunet.de ([149.225.4.46]:41602 "EHLO
	avaloon.intern.net") by vger.kernel.org with ESMTP
	id <S283413AbRK2V6z>; Thu, 29 Nov 2001 16:58:55 -0500
From: M G Berberich <berberic@fmi.uni-passau.de>
Date: Thu, 29 Nov 2001 22:58:14 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.16: hda9: attempt to access beyond end of device
Message-ID: <20011129225814.A464@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Partition boundary problem in 2.4.16 ?!

I just tried to make a mke2fs on my /dev/hda9 and mke2fs with kernel
2.4.16 and it failed with a partial write. /var/log/messages says:

  kernel: 03:09: rw=3D0, want=3D289140, limit=3D289138
  kernel: attempt to access beyond end of device

It works fine with 2.4.13 and it works with 2.4.16 if blocksize ist
set to 4k (fails with 1k blocks). Both kernel have reiserfs- and
ext3-support enabled and i2c- and lm_sensors-patches applied. mke2fs is
version 1.25 (20-Sep-2001), using EXT2FS Library 1.25. Partition table
is (fdisk -l /dev/hda):

  Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders
  Units =3D cylinders of 16065 * 512 bytes

     Device Boot    Start       End    Blocks   Id  System
  /dev/hda1   *         1        24    192748+  83  Linux
  /dev/hda2            25        48    192780   83  Linux
  /dev/hda3            49        72    192780   83  Linux
  /dev/hda4            73      1432  10924200    5  Extended
  /dev/hda5            73        96    192748+  82  Linux swap
  /dev/hda6            97       120    192748+  83  Linux
  /dev/hda7           121       181    489951   83  Linux
  /dev/hda8           182       667   3903763+  83  Linux
  /dev/hda9           668       703    289138+  83  Linux
  /dev/hda10          704       946   1951866   83  Linux
  /dev/hda11          947      1432   3903763+  83  Linux

Linux avaloon 2.4.16 SMP i686 unknown
=20
Gnu C                  2.95.2	    Gnu make               3.79.1
binutils               2.9.5.0.37   util-linux             2.11m
mount                  2.11m	    modutils               2.3.16
e2fsprogs              1.25	    Linux C Library        2.1.3
ldd: version 1.9.11		    Procps                 2.0.6
Net-tools              1.54	    Console-tools          0.2.3
Sh-utils               2.0

I'm not on linux-kernel mailinglist, so please mail me If you need
aditional information.

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  |

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8Bq92np4msu7jrxMRAgIyAJ4592O7ayOR9fUNkRvbemmpTwOvUwCdFVwx
NVUJ3tdAuStLy6mce5/gJgc=
=dogm
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
