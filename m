Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUHZMJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUHZMJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUHZMGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:06:44 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:13968 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268802AbUHZMAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:00:55 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Rik van Riel <riel@redhat.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wqpJ0jQK10SAdFjTAomn"
Date: Thu, 26 Aug 2004 14:00:27 +0200
Message-Id: <1093521627.9004.23.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wqpJ0jQK10SAdFjTAomn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 07:42 -0400 schrieb Rik van Riel:

> > > I like cat < a > b. You can keep your progress.
> >=20
> > cat <a >b does not preserve following file properties even on standard
> > UNIX filesystems: name,owner,group,permissions.
>=20
> Losing permissions is one thing.  Annoying, mostly.
>=20
> However, actual losing file data during such a copy is
> nothing short of a disaster, IMHO. =20
>=20
> In my opinion we shouldn't merge file-as-a-directory
> semantics into the kernel until we figure out how to
> fix the backup/restore problem and keep standard unix
> utilities work.

Well, again, what about xattrs and ACLs...?

Actually, reiser4 doesn't currently implement storage of arbitrary user
data under a file.

It's just some sysfs-like information that can be retrieved, some
properties can be changed. If you copy a file the worst thing that can
happen right now is that you lose the information whether that file
should be encrypted or compressed. You don't lose data.

In case some people are wondering, this is what you can find in the
reiser4 metas:

leto:/home/chtephan/.muttrc/metas > la
insgesamt 1
dr-xr-xr-x  1 chtephan users   0 26. Aug 13:52 .
-rwx------  1 chtephan users 290 12. Jan 2004  ..
-r--r--r--  1 chtephan users   0 26. Aug 13:52 bmap
-rw-r--r--  1 chtephan users   0 26. Aug 13:52 gid
-r--r--r--  1 chtephan users   0 26. Aug 13:52 items
-r--r--r--  1 chtephan users   0 26. Aug 13:52 key
-r--r--r--  1 chtephan users   0 26. Aug 13:52 locality
--w-------  1 chtephan users   0 26. Aug 13:52 new
-r--r--r--  1 chtephan users   0 26. Aug 13:52 nlink
-r--r--r--  1 chtephan users   0 26. Aug 13:52 oid
dr-xr-xr-x  1 chtephan users   0 26. Aug 13:52 plugin
-r--r--r--  1 chtephan users   0 26. Aug 13:52 pseudo
-r--r--r--  1 chtephan users   0 26. Aug 13:52 readdir
-rw-r--r--  1 chtephan users   0 26. Aug 13:52 rwx
-r--r--r--  1 chtephan users   0 26. Aug 13:52 size
-rw-r--r--  1 chtephan users   0 26. Aug 13:52 uid

Some of them are reiser4 specific things (items, key, locality, oid)
which can only be queried anyway.

The rest is what you can also get using other VFS calls.

leto:/home/chtephan/.muttrc/metas/plugin > la
insgesamt 0
dr-xr-xr-x  1 chtephan users 0 26. Aug 13:52 .
dr-xr-xr-x  1 chtephan users 0 26. Aug 13:52 ..
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 compression
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 crypto
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 digest
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 dir
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 dir_item
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 fibration
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 file
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 formatting
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 hash
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 perm
-rwxr-xr-x  1 chtephan users 0 26. Aug 13:54 sd

Here you can change reiser4 specific things. Here you can change some
properties how the file is stored in the reiser4 tree. For example you
can activate compression, encryption or authentication or set some hints
to optimize speed.

You can't create or remove these pseudo-files, just like in sysfs.

I don't know, but if someone wants to store user data I think you would
have to implement a directory "userdata" or something where you can
store it.

Not all of the information does make a lot sense inside a modified tar.
Who is interested in the bmap information of the file or some other
read-only information?


--=-wqpJ0jQK10SAdFjTAomn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLdDbZCYBcts5dM0RAizLAJoDIUG7l/J0r/+Q7Qhvys/jNCeB7QCePDbv
vUQPq1FsqrzE2TSkcAxFkYc=
=MYx8
-----END PGP SIGNATURE-----

--=-wqpJ0jQK10SAdFjTAomn--

