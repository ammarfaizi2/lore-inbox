Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318952AbSHNQ2j>; Wed, 14 Aug 2002 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSHNQ2j>; Wed, 14 Aug 2002 12:28:39 -0400
Received: from host213-121-104-171.in-addr.btopenworld.com ([213.121.104.171]:47231
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S318952AbSHNQ2i>; Wed, 14 Aug 2002 12:28:38 -0400
Subject: Re: mmap'ing a large file
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Mike Black <mblack@csihq.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <050a01c243a9$2afa3590$f6de11cc@black>
References: <050a01c243a9$2afa3590$f6de11cc@black>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-tkJ+fm+6Gu7nT1rFapGe"
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 14 Aug 2002 17:32:23 +0100
Message-Id: <1029342745.8255.6.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tkJ+fm+6Gu7nT1rFapGe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-08-14 at 16:42, Mike Black wrote:
> Is there a logical reason why a process can't mmap more than a 2G file?
>=20
> I seem to get stuck at 2142208000 with
> mmap: Cannot allocate memory

Perhaps this should be an FAQ item.

Intel is a 32bit architecture, that is to say the address space is 2^32
bytes (4GB), of this address space the kernel takes the top 2GB and
userspace the bottom 2GB.

There are patches that allow userspace to have 3GB or even 3.5GB
floating around. Obviously the kernel then only has 1GB/512MB - I'm not
sure what affect that will have.

The workaround to this is to only map in the portion(s) of the file you
actually need dynamically but this isn't always simple depending on the
application.

I suppose the short answer is 'its a hardware problem'.

HTH

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-tkJ+fm+6Gu7nT1rFapGe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9WoYXkbV2aYZGvn0RAkzIAJ9RxJugmjuRf9PhuhabBrdT4C4UsACfbzTe
HtnAnu+fnXOwvRb3oXdrdNk=
=WidT
-----END PGP SIGNATURE-----

--=-tkJ+fm+6Gu7nT1rFapGe--

