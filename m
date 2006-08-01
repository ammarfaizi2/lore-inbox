Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWHAHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWHAHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161365AbWHAHv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:51:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161350AbWHAHvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:51:55 -0400
Message-ID: <44CF0866.3000505@redhat.com>
Date: Tue, 01 Aug 2006 00:53:10 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: David Miller <davem@davemloft.net>, johnpol@2ka.mipt.ru,
       zach.brown@oracle.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060731103322.GA1898@2ka.mipt.ru> <E1G7V7r-0006jL-00@gondolin.me.apana.org.au> <20060731105037.GA2073@2ka.mipt.ru> <20060731.035716.39159213.davem@davemloft.net> <20060731105943.GA26114@gondor.apana.org.au>
In-Reply-To: <20060731105943.GA26114@gondor.apana.org.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E9F03E3BCAB44146EFEB583"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E9F03E3BCAB44146EFEB583
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Herbert Xu wrote:
> The other to consider is that events don't come from the hardware.
> Events are written by the kernel.  So if user-space is just reading
> the events that we've written, then there are no cache misses at all.

Not quite true.  The ring buffer can be written to from another
processor.  The kernel thread responsible for generating the event
(receiving data from network or disk, expired timer) can run
independently on another CPU.

This is the case to keep in mind here.  I thought Zach and the other
involved in the discussions in Ottawa said this has been shown to be a
problem and that a ring buffer implementation with something other than
simple front and back pointers is preferable.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig1E9F03E3BCAB44146EFEB583
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEzwhm2ijCOnn/RHQRAufPAKCmVw/xv8k+jz0pt/e9r+JQdUUYhACffjtj
WlYBRLKz2lSQK7z5fLWyQqQ=
=zcGF
-----END PGP SIGNATURE-----

--------------enig1E9F03E3BCAB44146EFEB583--
