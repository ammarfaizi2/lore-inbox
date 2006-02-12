Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWBLPDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWBLPDf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 10:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWBLPDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 10:03:35 -0500
Received: from nef2.ens.fr ([129.199.96.40]:9487 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751132AbWBLPDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 10:03:35 -0500
Date: Sun, 12 Feb 2006 16:03:31 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Filesystem for mobile hard drive
Message-ID: <20060212150331.GA22442@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 12 Feb 2006 16:03:32 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

I am about to buy a mobile hard drive (actually, a FireWire/USB box and a
normal hard drive), and it raises the question of which filesystem to put on
it. I am not wondering which of ext3, reiserfs, XFS or JFS is best, but more
basically whether I should use a Linux/Unix-style filesystem or the horrible
FAT.

The drawbacks of FAT are numerous and well-known: poor efficiency with big
files, fragmentation, bad handling of file names, lack of robustness, and
worst of all, the 4 Go limit. On the other hand, FAT gives the possibility
to easyly read the drive on non-Unix systems (I know there are ext2 and
reiserfs readers for windows, I do not know for XFS or JFS, but at the worst
it should be possible to do something with colinux).

All these elements are rather feeble, but the Unix-style filesystems have a
big drawback as mobile filesystems: they store UIDs. UIDs make sense inside
a given system, but not across systems. On the most annoying case, I can
have my disk automatically mounted on a system where I am not root, and all
my files unreadable because they belong to another user.

Since big mobile mass-storage devices which require efficient filesystems
will become more and more common, I think this problem should be addressed.
Someone suggested to me to use some sort of network filesystem (NFS or SMB),
and its UID mapping facility. That should work, but that is rather an ugly
solution, and that is not something that can be done in five minutes while
visiting a friend.

I believe that we lack an option at the VFS to completely override file
ownership of a filesystem. But maybe there are other solutions.

Did someone already think in depths about this issue?


Regards,

--=20
  Nicolas George

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFD705DsGPZlzblTJMRAmiRAKDTCQ7sOrpHEH+wukJ1q4081FXpvQCgtHLd
+p8otjFeHHHq9eVS3CRWVbM=
=m1Vh
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
