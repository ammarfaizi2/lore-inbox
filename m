Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSLMQoY>; Fri, 13 Dec 2002 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSLMQoX>; Fri, 13 Dec 2002 11:44:23 -0500
Received: from CPE014260028338.cpe.net.cable.rogers.com ([65.48.140.35]:47108
	"EHLO outpost.dnsalias.org") by vger.kernel.org with ESMTP
	id <S265130AbSLMQoV>; Fri, 13 Dec 2002 11:44:21 -0500
Subject: Re: Symlink indirection
From: Jeff Bailey <jbailey@nisa.net>
To: root@chaos.analogic.com
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-Reply-To: <Pine.LNX.3.95.1021213101227.2190A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021213101227.2190A-100000@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZuBDGtkPYwcZPLXl0iuS"
Organization: 
Message-Id: <1039798306.921.11.camel@outpost.dnsalias.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Dec 2002 11:51:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZuBDGtkPYwcZPLXl0iuS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-12-13 at 10:23, Richard B. Johnson wrote:

> Since a symlink is just a file containing a name, the resulting path
> length is simply the maximum path length that user-space tools allow.
> This should be defined as "PATH_MAX". Posix defines this as 255 character=
s
> but I think posix requires that this be the minimum and all file-name
> handling buffers must be at least PATH_MAX in length.

Small nit here, the Posix draft I have says that the definition shall be
omitted from the <limits.h> header on specific implementation where the
corresponding value is equal or greater than the stated minimum, but
where the value can vary depending on the file to which it is applied.

Please don't ever rely on PATH_MAX existing.  pathconf() is a better
tool.  We spend a lot of time chasing authors to explain to them why it
really is okay for the Hurd (i386-pc-gnu)'s libc to omit this
definition.

Tks,
Jeff Bailey=20

--=20
When you get to the heart,
use a knife and fork.
 - From instructions on how to eat an artichoke.

--=-ZuBDGtkPYwcZPLXl0iuS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9+hAi5M5hmdCYCpkRAjxNAKC9YQm2euNtjC3v1j1IFMc0f4CaRgCg6/gp
en/iKhgXVAd01AaR0YDBLaA=
=NFGF
-----END PGP SIGNATURE-----

--=-ZuBDGtkPYwcZPLXl0iuS--
