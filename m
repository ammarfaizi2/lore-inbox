Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUG1VBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUG1VBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUG1VBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:01:00 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:45982 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263795AbUG1VAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:00:22 -0400
Date: Wed, 28 Jul 2004 17:00:16 -0400
From: Andreas Dilger <adilger@clusterfs.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and SPEC SFS Run rules.
Message-ID: <20040728210016.GA1439@schnapps.adilger.int>
Mail-Followup-To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain> <Pine.LNX.4.44.0407261016580.32233-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y46NoIcKQuicSz3X"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407261016580.32233-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y46NoIcKQuicSz3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 26, 2004  10:18 +0100, Tigran Aivazian wrote:
> I think the important part of rule 1. saying "server adheres to the=20
> protocol" is this bit from rfc1813:
>=20
>    The following data modifying procedures are
>    synchronous: WRITE (with stable flag set to FILE_SYNC), CREATE,
>    MKDIR, SYMLINK, MKNOD, REMOVE, RMDIR, RENAME, LINK, and COMMIT.
>=20
> E.g. if a client had a successful SYMLINK and the server crashed, the=20
> client is not going to discover on the next reboot (of the server) that=
=20
> the symlink is somehow disappeared...

Just an FYI - if you are running a heavy sync load like a sync NFS
server you may want to consider running a large external journal for
performance.  This means your journal data writes are always sequential
and to a different disk than the main filesystem.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--Y46NoIcKQuicSz3X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBCBPgpIg59Q01vtYRAoa+AKCIaNW6E+VjBcEaZ0VTGWsbBBrteQCdFCWO
yFNuirtvGSdagDkwq8mDjW0=
=a6hk
-----END PGP SIGNATURE-----

--Y46NoIcKQuicSz3X--
