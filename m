Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTHZH5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 03:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbTHZH5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 03:57:06 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:43758 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262813AbTHZH5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 03:57:02 -0400
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030826000218.2ceaea1d.akpm@osdl.org>
References: <20030825231449.7de28ba6.akpm@osdl.org>
	 <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com>
	 <20030826000218.2ceaea1d.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A91AFJt51X9BLOnzp32y"
Organization: Red Hat, Inc.
Message-Id: <1061884611.2982.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Tue, 26 Aug 2003 09:56:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A91AFJt51X9BLOnzp32y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-26 at 09:02, Andrew Morton wrote:

> umm, how about hashing only on offset into page?  That reduces the number=
 of
> threads which need to be visited in futex_wake() by a factor of up to 102=
4.

How likely do you consider it that we then get a major collision?
I wouldn't be surprised if, say, glibc lays some hot futexes out in a
way that's the same for all processes in the system, like start of the
page.... Might as well not hash :)

Greetings,
   Arjan van de Ven

--=-A91AFJt51X9BLOnzp32y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/SxLDxULwo51rQBIRAkGXAKCVOBy0hxcAAolZ85VRjBq1BVG8jwCeJrfp
oxu22hR4HyFqB8x0kutBfas=
=JDzq
-----END PGP SIGNATURE-----

--=-A91AFJt51X9BLOnzp32y--
