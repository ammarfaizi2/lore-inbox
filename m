Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264995AbTFROxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTFROxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:53:34 -0400
Received: from host81-136-212-236.in-addr.btopenworld.com ([81.136.212.236]:46014
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP id S264995AbTFROxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:53:33 -0400
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
	Windows!
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Anders Karlsson <anders@trudheim.com>
Cc: Karl Vogel <karl.vogel@seagha.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055931810.2285.24.camel@tor.trudheim.com>
References: <200306172030230870.01C9900F@smtp.comcast.net>
	 <3EF0214A.3000103@aitel.hist.no>  <E19SZ8v-0005Ie-00@relay-1.seagha.com>
	 <1055931810.2285.24.camel@tor.trudheim.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j7WPhoe4D7q0hOOE+qrZ"
Message-Id: <1055948888.3068.2.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 18 Jun 2003 16:08:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j7WPhoe4D7q0hOOE+qrZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-18 at 11:23, Anders Karlsson wrote:
> AIX uses (or used to use) the exact same way of reading/writing data
> from/to disk for all I/O. AIX also makes a distinction between code and
> data. If code in RAM is unused, it simply gets flushed. If it is needed
> again at a later time, it is paged in from disk where it was originally
> loaded from. Only dirty data is paged out into swap.
>=20
> Is it feasible to tweak the Linux VM to behave in the same fashion? If
> Linux already does it this way, I'll just shut up. :)

The distinction in Linux is between anonymous and file-backed mappings.
Executables are file mappings so the pages can just be dropped and they
will be read in from the backing file when needed again. This also holds
true for memory mapped files.

When a mapping has no file (anonymous) then the swap is used. This is
one of the reasons I like mmap() it means you dont end up using swap for
storing buffers containing bits of files which are on disk anyway.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-j7WPhoe4D7q0hOOE+qrZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+8IBYkbV2aYZGvn0RAi11AKCDumMYbFf6rfm4dv0PK3oq8HXtQACeNxAv
3t/dafHEEhyWpLZcd1pOsss=
=hFuc
-----END PGP SIGNATURE-----

--=-j7WPhoe4D7q0hOOE+qrZ--

