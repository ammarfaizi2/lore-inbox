Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268736AbUHTUtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268736AbUHTUtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268785AbUHTUsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:48:32 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:31385 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268773AbUHTUq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:46:59 -0400
Date: Fri, 20 Aug 2004 14:46:56 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pankaj Agarwal <pankaj@pnpexports.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: how to identify filesystem type
Message-ID: <20040820204656.GW8967@schnapps.adilger.int>
Mail-Followup-To: Pankaj Agarwal <pankaj@pnpexports.com>,
	Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <001901c485cc$208c3a60$9159023d@dreammachine> <je657fzchp.fsf@sykes.suse.de> <000901c486c9$40d92e60$6d59023d@dreammachine>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wnBGVoaGQwxWUIo6"
Content-Disposition: inline
In-Reply-To: <000901c486c9$40d92e60$6d59023d@dreammachine>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wnBGVoaGQwxWUIo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 19, 2004  19:33 +0530, Pankaj Agarwal wrote:
>=20
> this is the output when you have a mounted block device.....you can only
> mount when you know the filesystem ....thats wat i wanna know...hoe to
> identify filesytems...on ablockdevice.
>=20
> thanks anyways, looking forward for more information on this

There is a tool available as part of e2fsprogs (1.34 maybe?) which is
called "blkid" that identifies block devices.  Currently fsck uses this
to know what fsck.fstype to use, and it was my hope to have mount(8)
use this also (never got around to doing that work).

The benefits of blkid are that you can use it as a regular user, even
without read access to the disk (it will return cached values generated
by root if you don't have read access to the block device), it also will
print LABEL and UUID information to identify the filesystem, if you use
it repeatedly from some application it doesn't re-scan all of the devices
each time (important for large numbers of block devices).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--wnBGVoaGQwxWUIo6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBJmNApIg59Q01vtYRAnrKAJ0YmNt3Ns5z/UpV+p/jJthDmfL59wCfYt/I
iW5rSq6IIYRhThfnq+spZl0=
=SZNE
-----END PGP SIGNATURE-----

--wnBGVoaGQwxWUIo6--
