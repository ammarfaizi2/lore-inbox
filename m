Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268431AbUKAPBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268431AbUKAPBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266972AbUKAOo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:44:27 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:59838 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S266032AbUKAO0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:26:47 -0500
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OovqFGDkeyJJfisRgUm+"
Date: Mon, 01 Nov 2004 15:26:43 +0100
Message-Id: <1099319203.17719.76.camel@debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OovqFGDkeyJJfisRgUm+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

First, why use a .a file to specify code bloat? I don't see why you want
the object files... ie:
ar tv /usr/lib/libxml2.a
rw-rw-r-- 0/0  76336 Oct 29 04:34 2004 SAX.o
rw-rw-r-- 0/0  83156 Oct 29 04:34 2004 entities.o
rw-rw-r-- 0/0  90704 Oct 29 04:34 2004 encoding.o
rw-rw-r-- 0/0  84272 Oct 29 04:34 2004 error.o
rw-rw-r-- 0/0  90620 Oct 29 04:34 2004 parserInternals.o
...

It can gladly sit there for all i care esp since it's installed by the
-dev package.
-rw-r--r--  1 root root 4312792 Oct 29 04:34 /usr/lib/libxml2.a

But when a app wants to load it you'll load a much smaller portion which
is: 987632 bytes.

As for X, check this out:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2886 root      15   0  416m 152m 283m S  1.7 15.1 309:31.75 XFree86

And yes, that might look bad, but consider agp memory, memory on the
card etc etc, then thats the figures we'd get. (and perhaps i should
actually shut down some apps as well =3D))

Btw, the most annoyingly large .a file i have ever found was libc.a in a
version of mdk, it included the whole libc build directory, post build,
weighing something along the lines of 24 mb.

Oh, and, you can never get rid of X, who will want something less
flexible when they have had something like this. You'll get back to the
same complexity sooner or later. I have to say that i much prefer
freedesktop's approach.

I'm not subbed so, you know what to do.
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-OovqFGDkeyJJfisRgUm+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBhkej7F3Euyc51N8RAvSmAJ451v+daDKyQ+/92FWyHcZOwWfr+wCgju5f
t7TsL9ZtVgAgYDW0IezxsLU=
=IEdy
-----END PGP SIGNATURE-----

--=-OovqFGDkeyJJfisRgUm+--

