Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVCLPyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVCLPyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCLPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:54:10 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:3551 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261940AbVCLPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:52:44 -0500
Date: Sat, 12 Mar 2005 15:52:36 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ed Tomlinson <tomlins@cam.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3
In-Reply-To: <200503120840.59095.tomlins@cam.org>
Message-ID: <Pine.LNX.4.60.0503121552010.26553@hermes-1.csi.cam.ac.uk>
References: <20050312034222.12a264c4.akpm@osdl.org> <200503120840.59095.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-1551468548-1110642756=:26553"
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-1551468548-1110642756=:26553
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 12 Mar 2005, Ed Tomlinson wrote:
> On Saturday 12 March 2005 06:42, Andrew Morton wrote:
> > 2.6.11-mm3
> >  From: Andrew Morton <akpm@osdl.org>
> >  To: linux-kernel@vger.kernel.org
> > =20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.=
6.11-mm3/
> >=20
> > - A new version of the "acpi poweroff fix". =A0People who were having t=
rouble
> > =A0 with ACPI poweroff, please test and report.
> >=20
> > - A very large update to the CFQ I/O scheduler. =A0Treat with caution, =
run
> > =A0 benchmarks. =A0Remember that the I/O scheduler can be selected on a=
 per-disk
> > =A0 basis with=20
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0echo as > /sys/block/sda/queue/scheduler
> > =A0=A0=A0=A0=A0=A0=A0=A0echo deadline > /sys/block/sda/queue/scheduler
> > =A0=A0=A0=A0=A0=A0=A0=A0echo cfq > /sys/block/sda/queue/scheduler
> >=20
> > - video-for-linux update
>=20
> Building with an -mm1 oldconfiged  on x86-64 arch I get:
>=20
>   LD      fs/ntfs/built-in.o
>   CC [M]  fs/ntfs/aops.o
>   CC [M]  fs/ntfs/attrib.o
> fs/ntfs/attrib.c: In function `ntfs_attr_make_non_resident':
> fs/ntfs/attrib.c:1295: warning: implicit declaration of function `ntfs_cl=
uster_alloc'
> fs/ntfs/attrib.c:1296: error: `DATA_ZONE' undeclared (first use in this f=
unction)
> fs/ntfs/attrib.c:1296: error: (Each undeclared identifier is reported onl=
y once
> fs/ntfs/attrib.c:1296: error: for each function it appears in.)
> fs/ntfs/attrib.c:1296: warning: assignment makes pointer from integer wit=
hout a cast
> fs/ntfs/attrib.c:1435: warning: implicit declaration of function `flush_d=
cache_mft_record_page'
> fs/ntfs/attrib.c:1436: warning: implicit declaration of function `mark_mf=
t_record_dirty'
> fs/ntfs/attrib.c:1443: warning: implicit declaration of function `mark_pa=
ge_accessed'
> fs/ntfs/attrib.c:1521: warning: implicit declaration of function `ntfs_cl=
uster_free_from_rl'
> make[2]: *** [fs/ntfs/attrib.o] Error 1
> make[1]: *** [fs/ntfs] Error 2
> make: *** [fs] Error 2

Thanks for the report.  All the above were already fixed in my tree except
for the mark_page_accessed() one which is now fixed (needs include
linux/swap.h).

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-1551468548-1110642756=:26553--
