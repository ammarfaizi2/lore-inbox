Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUABTQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbUABTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:16:11 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:32648 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261909AbUABTQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:16:08 -0500
Subject: Re: Syscall table AKA hijacking syscalls
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Libor Vanek <libor@conet.cz>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Christoph Hellwig <hch@infradead.org>,
       Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3FF5BF68.8060303@conet.cz>
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il>
	 <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org>
	 <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz>
	 <20040102180431.GB6577@wohnheim.fh-wedel.de>  <3FF5BF68.8060303@conet.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xf+vlRpZOWKILirQnuaA"
Organization: Red Hat, Inc.
Message-Id: <1073070944.9343.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Jan 2004 20:15:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xf+vlRpZOWKILirQnuaA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-02 at 19:58, Libor Vanek wrote:
> On Fri, Jan 02, 2004 at 07:04:31PM +0100, J=C3=B6rn Engel wrote:
> > On Fri, 2 January 2004 17:59:22 +0100, Libor Vanek wrote:
> > > >My guess is that the filesystem change notification would be a bette=
r
> > > >solution, either in userspace or in kernelspace, doesn't matter.  Bu=
t
> > > >that is far from finished or even generally accepted.
> > >=20
> > > This is also something (but just a bit) different - I don't need "cha=
nge=20
> > > notification" but "pre-change notification" ;)
> >=20
> > "Vor dem Spiel ist nach dem Spiel" -- Sepp Herberger
> >=20
> > Except for exactly two cases, pre-change and post-change and the same,
> > just off-by-one.  So you would need a bootup/mount/whenever special
> > case now, is that a big problem?
>=20
> Probably my english is bad but I don't understand what are you trying to =
say (except the german part ;-))
> A bit more about pre/post-change (if this is what are you trying to say) =
- I need allways pre-change because after file is changed I can no longer g=
et original (pre-change) version of file which I need for snapshot.

then you are off on the wrong track anyway since filedata can change
without system call anyway (think mmaped file where the dirtying doesnt'
involve a syscall

--=-Xf+vlRpZOWKILirQnuaA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/9cNgxULwo51rQBIRAlZCAJ9wHQ+BeizL8fzIOHx4tJ3LtPYdkQCeIUGz
pg9+z3KQB56UaNR51OTbZQQ=
=GzrZ
-----END PGP SIGNATURE-----

--=-Xf+vlRpZOWKILirQnuaA--
