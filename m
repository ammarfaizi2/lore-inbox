Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268918AbUHMAgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268918AbUHMAgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268583AbUHMAge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:36:34 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:48041 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268918AbUHMAeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:34:06 -0400
Date: Thu, 12 Aug 2004 18:34:03 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Otto Wyss <otto.wyss@orpatec.ch>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: New concept of ext3 disk checks
Message-ID: <20040813003403.GK18216@schnapps.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Otto Wyss <otto.wyss@orpatec.ch>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <411BAFCA.92217D16@orpatec.ch> <20040812223907.GA7720@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jz2RIiWkXBLiaBi"
Content-Disposition: inline
In-Reply-To: <20040812223907.GA7720@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4jz2RIiWkXBLiaBi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 12, 2004  18:39 -0400, Theodore Ts'o wrote:
> 2) Run e2fsck -f on the snapshot, and check to see if there are any
> error on the filesystem.  Assuming a non-buggy kernel and properly
> functioning hardware, there should be none.  Afterwards, release the
> read-only snapshot.
>=20
> 3) If there are any errors, e-mail the output of e2fsck to the system
> administrator.
>=20
> 4) If there were no errors detecting by the fsck run, run the command
> "tune2fs -C 0 -T now /dev/XXX" on the live filesystem.  This sets the
> mount count and last filesystem checked time to the appropriate values
> in the superblock.
>=20
> Tell you what --- if someone is willing to put the time into
> developing such a script, I'll include it in the contrib section of
> e2fsprogs.  I've put all the hooks to do this in e2fsprogs, and I've
> wanted this for quite some time, but the last time I looked at it, the
> command-line EVMS tools were truly gruesome to behold/use.  I believe
> things have gotten much better since then, so this shouldn't be too
> hard to do now.

I did this a few years ago, but it fell through the cracks.  The
script is written for the LVM1 code, but AFAIK the LVM2 code also
has compatible user tools.

http://www.mail-archive.com/reiserfs-list@namesys.com/msg08474.html

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--4jz2RIiWkXBLiaBi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBHAx7pIg59Q01vtYRAiVnAKDYqMusahBlyfMzY6J+epHUPmkK1wCgoMwf
C/7j/KRFVNSQBeS3zNVcpkE=
=NzrF
-----END PGP SIGNATURE-----

--4jz2RIiWkXBLiaBi--
