Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271396AbTG2LMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTG2LJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:09:35 -0400
Received: from [24.241.190.29] ([24.241.190.29]:392 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S271401AbTG2LHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:07:18 -0400
Date: Tue, 29 Jul 2003 07:07:16 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: NFS Server running 2.6.0-test2
Message-ID: <20030729110716.GC786@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Just converted my nfs server to 2.6.0-test2 last night.  This morning I
found this on my console:

{0}:/>
Message from syslogd@camel at Tue Jul 29 00:02:30 2003 ...
camel kernel: journal commit I/O error


{0}:/>mount
=2E
=2E
/dev/md/0 on /mnt/data1 type ext3 (rw)

{0}:/>find /mnt/data1/backups/www/tarballs -name www-\*tgz -mtime +7 -exec =
rm {} \;
rm: cannot remove `/mnt/data1/backups/www/tarballs/www-20030721.tgz':
Read-only file system

{0}:/>mount -o remount,rw /dev/md0
mount: block device /dev/md/0 is write-protected, mounting read-only


I have NFS Version 3 enabled but TCP disabled (was very laggy).


Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JlVk8+1vMONE2jsRAmxnAJ4jNGYThgRDYuCON+3zyYDAY2qc9gCgrx/f
NzL2Wj96SoWkdJvMhsGXm3I=
=GxTk
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
