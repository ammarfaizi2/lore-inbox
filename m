Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312479AbSDHXa0>; Mon, 8 Apr 2002 19:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313792AbSDHXaZ>; Mon, 8 Apr 2002 19:30:25 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:58118 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S312479AbSDHXaY>; Mon, 8 Apr 2002 19:30:24 -0400
Date: Mon, 8 Apr 2002 16:30:20 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        USB Storage List <usb-storage@one-eyed-alien.net>
Subject: Re: sddr09.c
Message-ID: <20020408163020.B7868@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	USB Storage List <usb-storage@one-eyed-alien.net>
In-Reply-To: <UTC200204082310.XAA559533.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andries --

I have docs on this thing.  It's been an on-again, off-again project with
some other developers.  You're the first to be able to write to the thing.

The translation is designed to preserve integrity -- i.e. you write the
data, then atomically set one block invalid and another valid.  There's
actually a command for this at the controller-level.

I suggest that, if you're serious about finishing this, you get on board
the usb-storage devel team (contact me off-lists about this), so we can get
you access to the specs and then get this thing working.

Matt

On Mon, Apr 08, 2002 at 11:10:43PM +0000, Andries.Brouwer@cwi.nl wrote:
> This evening I cleaned up sddr09.c, and after some playing
> succeeded in writing to a SM card.
> Remains the question: does anyone have docs for this thing?
>=20
> (The "read control" command gives 64 bytes for each 16kB block.
> The last 48 look like junk. The first 16 either are all zero,
> or start with six FF bytes followed by two groups of five bytes.
> The first two bytes of both groups of five are equal, and
> describe the PBA <-> LBA correspondence.
> I do not know what the final three bytes of both groups mean.
> They have five nybbles of even parity and one nybble that ends
> in two 1 bits.
> What is the purpose of this PBA <-> LBA mapping?
> To avoid bad blocks? Or is rewriting a sector much slower
> than relocating it and writing a fresh one?
> I invented a "write_data" command, but have not yet tried
> to do a "write_control".)
>=20
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I want my GPFs!!!
					-- Stef
User Friendly, 11/9/1998

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8sigMz64nssGU+ykRAkAoAKCsehgGwiF03ZEI0+ltnXjmAXNMnQCg8L4R
zXikR3ctUVLjxzVeQar/bVQ=
=ScIi
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
