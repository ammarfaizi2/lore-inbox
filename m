Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVHWRGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVHWRGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVHWRGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:06:15 -0400
Received: from mail04.solnet.ch ([212.101.4.138]:34504 "EHLO mail04.solnet.ch")
	by vger.kernel.org with ESMTP id S932227AbVHWRGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:06:14 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
Reply-To: Damir Perisa <damir.perisa@solnet.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm2 - fs/xfs/xfs*.c warnings
Date: Tue, 23 Aug 2005 19:03:27 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050822213021.1beda4d5.akpm@osdl.org>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2003397.b0j7y1rfgq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508231903.36127.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2003397.b0j7y1rfgq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

i'm compiling 2.6.13-rc6-mm2 atm and noticed that xfs is having lots of=20
warnings while compiling. recently i switched to gcc 4.0.1 - maybe it's=20
because of this.

details:

fs/xfs/xfs_acl.c: In function 'xfs_acl_access':
fs/xfs/xfs_acl.c:445: warning: 'matched.ae_perm' may be used uninitialized=
=20
in this function

fs/xfs/xfs_alloc_btree.c: In function 'xfs_alloc_insrec':
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_startblock' may be used=20
uninitialized in this function
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_blockcount' may be used=20
uninitialized in this function

fs/xfs/xfs_bmap.c: In function 'xfs_bmap_alloc':
fs/xfs/xfs_bmap.c:2335: warning: 'rtx' is used uninitialized in this=20
function

fs/xfs/xfs_dir2_sf.c: In function 'xfs_dir2_block_sfsize':
fs/xfs/xfs_dir2_sf.c:110: warning: 'parent' may be used uninitialized in=20
this function

fs/xfs/xfs_dir_leaf.c: In function 'xfs_dir_leaf_to_shortform':
fs/xfs/xfs_dir_leaf.c:653: warning: 'parent' may be used uninitialized in=20
this function

fs/xfs/xfs_ialloc_btree.c: In function 'xfs_inobt_insrec':
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_free' is used=20
uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_freecount' is used=20
uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:567: warning: 'nrec.ir_startino' may be used=20
uninitialized in this function

and the following warning appears a lot of times:

fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined

just giving a heads-up if somebody wants to clean this code.=20

thanx + greetings,
Damir

Le Tuesday 23 August 2005 06:30, Andrew Morton a =E9crit=A0:
| ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc
|6/2.6.13-rc6-mm2/
|
| - Various updates.  Nothing terribly noteworthy.
|
| - This kernel still spits a bunch of scheduling-while-atomic warnings
| from the scsi code.  Please ignore.
|

=2D-=20
It is impossible for an optimist to be pleasantly surprised.

--nextPart2003397.b0j7y1rfgq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDC1boPABWKV6NProRAiFwAKCq5p35j+jnZEBxX1xZrbgIc/mgmwCfcGDP
BGtmVLZ0Yxl+DqJ26OJLMyc=
=affa
-----END PGP SIGNATURE-----

--nextPart2003397.b0j7y1rfgq--
