Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268925AbUHZMdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268925AbUHZMdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUHZMbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:31:07 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:29585 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S268925AbUHZMXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:23:47 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hans Reiser <reiser@namesys.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040826121630.GN5618@nocona.random>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <1093467601.9749.14.camel@leto.cs.pocnet.net>
	 <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com>
	 <20040826112818.GL5618@nocona.random>
	 <1093520699.9004.11.camel@leto.cs.pocnet.net>
	 <20040826121630.GN5618@nocona.random>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D3ArTSO9oAYRBV+cOuLD"
Date: Thu, 26 Aug 2004 14:23:34 +0200
Message-Id: <1093523014.9004.45.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D3ArTSO9oAYRBV+cOuLD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 14:16 +0200 schrieb Andrea Arcangeli:

> > Currently plugins are not modules. It just means that there's a defined
> > interface between the reiser4 core and the plugins. Just like you could
> > see filesystems as "VFS plugins".
>=20
> but filesystems are exactly always modules (in precompiled kernels at
> least).

Yes, of cousre.

> Anyways I don't see any visible EXPORT_SYMBOL in reiser4.

Yes, there's no module infrastructure there. These "plugins" need to be
linked at compile time. Some plugins need to be anyway since the the
filesystem is useless without them. Others whould be optional features.

> > In fact, reiser4 plugins are
> > - users of the reiser4 core API
> > - some of them are implementing Linux VFS methods (thus being some sort
> > of glue code between the Reiser4 storage tree and the Linux VFS)
>=20
> then it seems a bit misleading to call those things plugins.
>=20
> As you wrote those are "users of the reiser4 core API", with plugins I
> always meant dynamically loadable things, like plugins for web browers
> (hence kernel modules in kernel space). While here apparently you can't
> plugin anything at runtime, it's just code that uses the reiser4 core
> API that can be modified with a kernel patch as usual.

Right. The name is probably at bit misleading. But assuming the
compression "plugin" whould be dynamically loadable at some later point
it would be a plugin then?


--=-D3ArTSO9oAYRBV+cOuLD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLdZGZCYBcts5dM0RAh0HAJ0WXyorP8GvKodLywpP+QzD0Sn03QCfdDYZ
sIx3tTLZcRlZL7iW0k+UM/I=
=DB1N
-----END PGP SIGNATURE-----

--=-D3ArTSO9oAYRBV+cOuLD--

