Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTLQR2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTLQR2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:28:00 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:21898 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264485AbTLQR16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:27:58 -0500
Subject: scsi_id segfault with udev-009
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fa+eAiN8DkV+y1XvrDxh"
Message-Id: <1071682198.5067.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 19:29:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fa+eAiN8DkV+y1XvrDxh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Getting this with scsi_id and udev-009:

--
Starting program:
/space/var/tmp/portage/udev-009/work/udev-009/extras/scsi_id/scsi_id -p
0x80 -s /block/sdb
=20
Program received signal SIGSEGV, Segmentation fault.
0x080499c5 in sysfs_get_attr (dev=3D0x80d2d68, attr=3D0x80b559c "dev") at
scsi_id.h:45
45              return
sysfs_get_value_from_attributes(dev->directory->attributes,
(gdb) k
Kill the program being debugged? (y or n) y
(gdb) run -p 0x83 -s /block/sdb
Starting program:
/space/var/tmp/portage/udev-009/work/udev-009/extras/scsi_id/scsi_id -p
0x83 -s /block/sdb
=20
Program received signal SIGSEGV, Segmentation fault.
0x080499c5 in sysfs_get_attr (dev=3D0x80d2d68, attr=3D0x80b559c "dev") at
scsi_id.h:45
45              return
sysfs_get_value_from_attributes(dev->directory->attributes,
(gdb) q
--

I cannot see why to be honest.


Thanks,

--=20

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa



--=-Fa+eAiN8DkV+y1XvrDxh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4JKWqburzKaJYLYRAqGYAJwMisn6kVTXvPprmLZmh8tiYk0jBQCcCrWO
GACixJqZ/avPZ8ELBJvL7vo=
=zrBv
-----END PGP SIGNATURE-----

--=-Fa+eAiN8DkV+y1XvrDxh--

