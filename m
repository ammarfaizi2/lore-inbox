Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbULOV3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbULOV3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbULOV3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:29:19 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:47488 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262496AbULOVW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:22:59 -0500
Date: Wed, 15 Dec 2004 14:22:53 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Vineet Joglekar <vintya@excite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there any prob in accessing new field added to inode mem structure, in some other functions?
Message-ID: <20041215212253.GL9923@schnapps.adilger.int>
Mail-Followup-To: Vineet Joglekar <vintya@excite.com>,
	linux-kernel@vger.kernel.org
References: <20041215164101.A52C3B740@xprdmailfe18.nwk.excite.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline
In-Reply-To: <20041215164101.A52C3B740@xprdmailfe18.nwk.excite.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 15, 2004  11:41 -0500, Vineet Joglekar wrote:
> I am using linux 2.4.21 and I am trying to play with the etx2 file system=
. My aim is to allocate a data structure dynamically to every file that is =
opened, at the time of opening.
> What I tried to do was: added the structure pointer in the inode data str=
ucture "ext2_inode" say "x_ptr". In the function "ext2_read_inode" which re=
ads the hard disk copy of inode into memory, I allocated memory to this poi=
nter and filled the appropriate value. I chose this function as I thought w=
hen a file is opened, this function will be always called once. Upto this i=
s working fine.
>=20
> Now when I try to use this pointer "x_ptr" in some other function, that i=
s, "do_generic_file_read" - which is called while reading a file, I am not =
getting any value in that pointer, but a null. (which is supposed to be the=
re as I am filling up appropriate value in function ext2_read_inode)

You are confusing "ext2_inode" (on disk structure, never change that) with
"ext2_inode_info" (in memory structure, what you want to change).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBwKstpIg59Q01vtYRAjEkAKDbq1ItQqiCdG9l53SHsihd8m6vDACfU9C0
lfg076hMZatS6N30t/WCrjs=
=7DoO
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--
