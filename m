Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVCIKpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVCIKpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVCIKpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:45:05 -0500
Received: from smtp.gentoo.org ([134.68.220.30]:55965 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262344AbVCIKjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:39:07 -0500
Subject: amd64 - ide_cd errors
From: Jeremy Huddleston <eradicator@gentoo.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uienSsDZ4YrTta0s3qAb"
Date: Wed, 09 Mar 2005 02:39:06 -0800
Message-Id: <1110364746.20392.125.camel@cid.outersquare.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uienSsDZ4YrTta0s3qAb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have a dvd+-rw drive (LITE-ON DVDRW LDW-411S with FS0K firmware).  The
drive appears to opperate correctly.  I can mount media, read from it,
and burn just fine, but printk output indicates some error.

2.6.10:
hdc: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=3D0x54
ide: failed opcode was 100

2.6.11:
hdc: packet command error: status=3D0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=3D0x54 { AbortedCommand
LastFailedSense=3D0x05 }
ide: failed opcode was: unknown

These messages do not appear if media is not in the tray.  If media is
in the tray, these messages will repeat continuously (at a rate of about
2 per second).  The media doesn't need to be mounted, just present.

Additionally, this did not occur when this drive was in an i686 box, but
it does occur now that it is in an x86_64 box.

Has anyone seen a problem like this or have any suggestions?

Thanks,
Jeremy

--=-uienSsDZ4YrTta0s3qAb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCLtJKOpjtAl+gMRURAj/OAKCSW82p1Zvi8MUEYiDGYTBmi1qeAgCeNB8g
g/K1+F1INsSBwDQ2r3ZJV+4=
=Go/n
-----END PGP SIGNATURE-----

--=-uienSsDZ4YrTta0s3qAb--

