Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVAGVYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVAGVYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVAGVX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:23:29 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:50928 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S261601AbVAGVVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:21:00 -0500
Subject: Re: MS_NOUSER and rootfs
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <200501071932.35184.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1105024095.15293.74.camel@tubarao>
	 <200501071932.35184.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t8/3ADIyMspGqn4Yr9eY"
Organization: Linux Networx
Date: Fri, 07 Jan 2005 13:53:32 -0700
Message-Id: <1105131212.18437.15.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t8/3ADIyMspGqn4Yr9eY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-07 at 19:32 +0200, Denis Vlasenko wrote:
> On Thursday 06 January 2005 17:08, Thayne Harbaugh wrote:
> > What is the purpose of the MS_NOUSER flag serve and why is it set on
> > rootfs?
>=20
> Was grep helpful?

No, it wasn't.  There are (realling from memory) about six places that
MS_NOUSER appears in the entire tree.

One is in fs.h file where it is defined.

One is in in ramfs/inode.c (?) where MS_NOUSER is set on rootfs for
rootfs_get_sb()

One is in namespace.c in the graft_tree() function that prevents MS_BIND

Thrice in shmem.c - I have to admit I haven't read this very closely

One in libfs.c where there's a template for file systems that aren't
supposed to be mountable

One in Documentation/filesystems/porting where it describes that it can
be used in place of FS_NOMOUNT

There isn't a description as to what the intention is for MS_NOUSER and
why it should be applied to rootfs.  I'm looking for some education as
to what it does so I can work out the details as to why it's used in
graft_tree(), rootfs_get_sb() and shmem.c.

It appears that Al Viro wrote some of that and I'm hoping that he can
find some time to reply (I'm sure he gets millions of emails about
little details and it's hard to cut through them).  Maybe there's
someone else that understands that can give me an education or point me
in the right direction.

Thanks for your response.

--=20
Thayne Harbaugh
Linux Networx

--=-t8/3ADIyMspGqn4Yr9eY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB3vbMsYFQl3A+qS0RAplgAKCIdKR78G0HuVYQbhooXCNcc/0awgCgojmo
ViOxdFyvY/+WLKq0jGdNdlA=
=+iRF
-----END PGP SIGNATURE-----

--=-t8/3ADIyMspGqn4Yr9eY--

