Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTF2WLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbTF2WLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 18:11:35 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:17881 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264918AbTF2WLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 18:11:33 -0400
Date: Sun, 29 Jun 2003 23:25:40 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030629222540.GE4298@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
References: <20030629213723.GD4298@carfax.org.uk> <200306291754580730.0289CA02@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <200306291754580730.0289CA02@smtp.comcast.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2003 at 05:54:58PM -0400, rmoser wrote:
> On 6/29/2003 at 10:37 PM Hugo Mills wrote:
> >   Start with the easy bits: make a list of _every_ piece of metadata
> >that can be stored by an ext2 filesystem. Do the same for ReiserFS.
> >Work out how one maps to the other. Write a C/C++ struct to contain
> >that metadata. Work out how you're going to store your metadata nodes
> >on-disk. Those are the easy bits.
>=20
> Nerg.  Heh that's gonna be hard to find.  Need to get a book on filesyste=
ms.

   Hardly difficult. I found what appears to be a pretty complete
35-page document on the structure of the FAT filesystem in about 10
seconds with Google. ext2 was a little tricker to find, but eventually
I got to the sourceforge project for e2fsprogs.

[snip]
> >   Fix bugs, and repeat for ReiserFS.
> >
> >   By this point, you will know how ext2 and Reiser really work. Then
> >you can start considering how to manage your metadata objects inside a
> >partly-converted filesystem. Work out how to do that, and implement it
>=20
> What?  I'd rather structure the datasystem to handle it right off the bat.
> (I'm expecting to get flamed for this statement lol)

   And quite rightly. Take small steps, moving towards your ultimate
goal. Don't try to get a perfect system working immediately -- you
_will_ fail (unless you're some previously unsung =FCbercoder, in which
case you'll merely find it insanely difficult :) ).

   Hugo.

--=20
=3D=3D=3D Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk=
 =3D=3D=3D
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
     --- For months now, we have been making triumphant retreats ---    =20
               before a demoralised enemy who is advancing              =20
                           in utter disorder.                           =20

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/2dkssJ7whwzWGARAtdVAJ9voR25iESo0yYvgxfU39arWwLDKgCglxCu
S0swUcInyKlooN390YiyWJs=
=qdUs
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
