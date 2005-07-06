Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVGFUgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVGFUgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVGFUgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:36:18 -0400
Received: from email.esoft.com ([199.45.143.4]:11666 "EHLO esoft.com")
	by vger.kernel.org with ESMTP id S262163AbVGFUeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:34:13 -0400
Subject: Re: reiser4 plugins
From: Jonathan Briggs <jbriggs@esoft.com>
To: Hubert Chan <hubert@uhoreg.ca>
Cc: "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
In-Reply-To: <87mzozemqp.fsf@evinrude.uhoreg.ca>
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>
	 <87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>
	 <1120675943.13341.10.camel@localhost>  <87mzozemqp.fsf@evinrude.uhoreg.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PoQIS3nu07blch1tWasI"
Organization: eSoft, Inc.
Date: Wed, 06 Jul 2005 14:33:18 -0600
Message-Id: <1120681998.13341.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-Envelope-From: jbriggs@esoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PoQIS3nu07blch1tWasI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-07-06 at 15:51 -0400, Hubert Chan wrote:
> On Wed, 06 Jul 2005 12:52:23 -0600, Jonathan Briggs <jbriggs@esoft.com> s=
aid:
[snip]
> > It still has the performance and locking problem of having to update
> > every child file when moving a directory tree to a new parent.  On the
> > other hand, maybe the benefit is worth the cost.
>=20
> Every node should store the inode number(s) for its parent(s).  Not the
> path name.  So you don't need to do any updates, since when you move a
> tree, inode numbers don't change.

You do need the updates if you change what inode is the parent.

/a/b/c, /a/b/d, /a/b/e, /b
mv /a/b /b
Now you have to change the stored grand-parent inodes for /a/b/c, /a/b/d
and /a/b/e so that they reference /b/b instead of /a/b.
--=20
Jonathan Briggs <jbriggs@esoft.com>
eSoft, Inc.

--=-PoQIS3nu07blch1tWasI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCzEAOG8fHaOLTWwgRAsZfAJ9isO94/vbgL77SKKzkey+qqe0WsQCfTaU8
mItT2sR8XaJiRv3zFQ4kIXg=
=gMQb
-----END PGP SIGNATURE-----

--=-PoQIS3nu07blch1tWasI--

