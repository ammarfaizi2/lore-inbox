Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUEXNqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUEXNqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 09:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUEXNqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 09:46:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264286AbUEXNp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 09:45:57 -0400
Subject: Re: [PATCH/RFC] Lustre VFS patch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: hch@infradead.org
Cc: "Peter J. Braam" <braam@clusterfs.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, "'Phil Schwan'" <phil@clusterfs.com>
In-Reply-To: <20040524120858.GE26863@infradead.org>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
	 <20040524120858.GE26863@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sgrTlZG9R7fWaZ4pGgKm"
Organization: Red Hat UK
Message-Id: <1085406284.2780.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 May 2004 15:44:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sgrTlZG9R7fWaZ4pGgKm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-24 at 14:08, hch@infradead.org wrote:
> > vfs-raw_ops-vanilla-2.6.patch
> >=20
> >   This adds raw operations for setattr, mkdir, rmdir, mknod, unlink,
> >   symlink, link and rename.  The raw operations look up the parent
> >   directories (but not leaf nodes) involved in the operation and then
> >   ask the file system to execute the operation.  These methods allow
> >   us to delegate the execution of these functions to the server, and
> >   instantiate no dentries for leaf nodes, leaf nodes will only enter
> >   the dcache on subsequent lookups.  This patch dramatically
> >   simplifies the client/server lock management, particularly for
> >   rename.
> > =20
> >   In Ottawa Linus suggested that we could maybe do this with intents
> >   instead.  I feel that both are ugly, both are possible but intents
> >   looked akward.
>=20
>=20
> This is complete crap.  We don't want to methods for every namespace
> operation. =20

fun question: how does it deal with say a rename that would span mounts
on the client but wouldn't on the server? :)

--=-sgrTlZG9R7fWaZ4pGgKm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsfxLxULwo51rQBIRAjQLAJ9JHwfxgJ1lMUkZIsydyAUyMEyErwCdH5B7
shk9C4xIT7x2Rh35aREFZbU=
=kr9U
-----END PGP SIGNATURE-----

--=-sgrTlZG9R7fWaZ4pGgKm--

