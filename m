Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVDMAaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVDMAaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVDMA1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:27:44 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:1948 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262931AbVDLUTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:19:49 -0400
Date: Tue, 12 Apr 2005 21:19:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jamie Lokier <jamie@shareable.org>
cc: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
In-Reply-To: <20050412144529.GE10995@mail.shareable.org>
Message-ID: <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk>
References: <3S8oN-So-15@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it>
 <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it>
 <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it>
 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>
 <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org>
 <20050412144529.GE10995@mail.shareable.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-526741490-1113337064=:26320"
Content-ID: <Pine.LNX.4.60.0504122117480.26320@hermes-1.csi.cam.ac.uk>
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-526741490-1113337064=:26320
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0504122117481.26320@hermes-1.csi.cam.ac.uk>

On Tue, 12 Apr 2005, Jamie Lokier wrote:
> Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> > Jamie Lokier <jamie@shareable.org> wrote:
> > > Miklos Szeredi wrote:
> >=20
> > >>=A0=A0=A04)=A0Access=A0should=A0not=A0be=A0further=A0restricted=A0for=
=A0the=A0owner=A0of=A0the
> > >>=A0=A0=A0=A0=A0=A0mount,=A0even=A0if=A0permission=A0bits,=A0uid=A0or=
=A0gid=A0would=A0suggest
> > >>=A0=A0=A0=A0=A0=A0otherwise
> > >=A0
> > >=A0Why?=A0=A0Surely=A0you=A0want=A0to=A0prevent=A0writing=A0to=A0files=
=A0which=A0don't=A0have=A0the
> > >=A0writable=A0bit=A0set?=A0=A0A=A0filesystem=A0may=A0also=A0create=A0a=
ppend-only=A0files=A0-
> > >=A0and=A0all=A0users=A0including=A0the=A0mount=A0owner=A0should=A0be=
=A0bound=A0by=A0that.
> >=20
> > That=A0will=A0depend=A0on=A0the=A0situation.=A0If=A0the=A0user=A0is=A0m=
ounting=A0a=A0tgz=A0owned
> > by=A0himself,=A0FUSE=A0should=A0default=A0to=A0being=A0a=A0convenient=
=A0hex-editor.
>=20
> If the user wants to edit a read-only file in a tgz owned by himself,
> why can he not _chmod_ the file and _then_ edit it?
>=20
> That said, I would _usually_ prefer that when I enter a tgz, that I
> see all component files having the same uid/gid/permissions as the tgz
> file itself - the same as I'd see if I entered a zip file.

As you say _usually_, even you admit that sometimes you would want the=20
real owner/permissions to be shown.  And that is the point Miklos is=20
trying to make I believe: it should be configurable not hard set to only=20
one which is what I understand HCH wants.

There are uses for both.  For example today I was updating the tar ball=20
which is used to create the var file system for a new chroot.  I certainly=
=20
want to see corretly setup owner/permissions when I look into that tar=20
ball using a FUSE fs...

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-526741490-1113337064=:26320--
