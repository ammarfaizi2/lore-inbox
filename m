Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbTGOQZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268586AbTGOQZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:25:39 -0400
Received: from host81-136-144-97.in-addr.btopenworld.com ([81.136.144.97]:21376
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP id S268577AbTGOQZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:25:30 -0400
Subject: Re: [RFC][PATCH 0/5] relayfs
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, bob@watson.ibm.com
In-Reply-To: <16148.9560.602996.872584@gargle.gargle.HOWL>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
	 <1058282847.375.3.camel@sherbert>
	 <16148.9560.602996.872584@gargle.gargle.HOWL>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CCqHi25c7n2OODcVekSF"
Message-Id: <1058287227.377.17.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 15 Jul 2003 17:40:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CCqHi25c7n2OODcVekSF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-15 at 17:01, Tom Zanussi wrote:
> Gianni Tedesco writes:
>  > On Tue, 2003-07-15 at 16:15, Tom Zanussi wrote:
>  > > The following 5 patches implement relayfs, adding a dynamic channel
>  > > resizing capability to the previously posted version.
>  > >=20
>  > > relayfs is a filesystem designed to provide an efficient mechanism f=
or
>  > > tools and facilities to relay large amounts of data from kernel spac=
e
>  > > to user space.  Full details can be found in Documentation/filesyste=
ms/
>  > > relayfs.txt.  The current version can always be found at
>  > > http://www.opersys.com/relayfs.
>  >=20
>  > Could this be used to replace mmap() packet socket, how does it compar=
e?
>=20
> I think so - you could send high volumes of packet traffic to a bulk
> relayfs channel and read it from the mmap'ed relayfs file in user
> space.  The Linux Trace Toolkit does the same thing with large volumes
> of trace data - you could look at that code as an example
> (http://www.opersys.com/relayfs/ltt-on-relayfs.html).

What are the semantics of the mmap'ing the buffer? With mmaped packet
socket the userspace (read-side) requires no sys-calls apart from when
the buffer is empty, it then uses poll(2) to sleep until something new
is put in the buffer. Can relayfs do a similar thing? poll is not
mentioned in the docs...

Thanks.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-CCqHi25c7n2OODcVekSF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FC57kbV2aYZGvn0RAlPZAJ4ubrqgHYwGHycpyQYy16mNH6dd0gCePcXm
hPmi3faMe+ckTimEC/t1J1Y=
=Cn0u
-----END PGP SIGNATURE-----

--=-CCqHi25c7n2OODcVekSF--

