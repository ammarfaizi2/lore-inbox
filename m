Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265589AbUALRYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUALRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:24:23 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:53893 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265589AbUALRYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:24:21 -0500
Subject: Re: 2.6.x breaks some Berkeley/Sleepycat DB functionality
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dan Egli <dan@eglifamily.dnsalias.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4002D65C.1010505@eglifamily.dnsalias.net>
References: <4002D65C.1010505@eglifamily.dnsalias.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UxRKo/3/ajMY4oiIy0oC"
Organization: Red Hat, Inc.
Message-Id: <1073928251.4428.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 18:24:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UxRKo/3/ajMY4oiIy0oC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-12 at 18:16, Dan Egli wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> I have encountered a strange issue in 2.6.0 and 2.6.1
>=20
> I run a PGP Public key server on this machine and under 2.4.x it's
> "smooth as silk". But if I boot under 2.6.x, it's gaurenteed failure. If
> I try to build a database using the build command (this is an sks
> server, so it's sks build or sks fastbuild) I IMMEDIATELY get  Bdb
> error. But the exact same command with the exact same libraries and
> input files under 2.4.20 works without a hitch.
>=20
> Anyone got any ideas? Anything else I can provide to assist in debugging?

this might be the same issue that hit some rpm versions; some versions
of db4 seem to detect the O_DIRECT header presence and starts using
O_DIRECT, without honoring the alignment requirements linux puts on
O_DIRECT usage...

--=-UxRKo/3/ajMY4oiIy0oC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAAtg7xULwo51rQBIRAiI/AJ9LBTYL7y6bzLGVtGGvSpS8YaEbDQCgjDpM
Ji265oriUDJBT69sWHG/x9Y=
=cmyM
-----END PGP SIGNATURE-----

--=-UxRKo/3/ajMY4oiIy0oC--
