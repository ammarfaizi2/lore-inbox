Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUH3UXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUH3UXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUH3UXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:23:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268448AbUH3UXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:23:33 -0400
Subject: Re: What policy for BUG_ON()?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040830201519.GH12134@fs.tum.de>
References: <20040830201519.GH12134@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0TDvNVI2te2pQj/dpvOD"
Organization: Red Hat UK
Message-Id: <1093897329.2870.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 22:22:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0TDvNVI2te2pQj/dpvOD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-30 at 22:15, Adrian Bunk wrote:
> Let me try to summarize the different options regarding BUG_ON,=20
> concerning whether the argument to BUG_ON might contain side effects,=20
> and whether it should be allowed in some "do this only if you _really_=20
> know what you are doing" situations to let BUG_ON do nothing.
>=20
> Options:
> 1. BUG_ON must not be defined to do nothing
> 1a. side effects are allowed in the argument of BUG_ON
> 1b. side effects are not allowed in the argument of BUG_ON
> 2. BUG_ON is allowed to be defined to do nothing
> 2a. side effects are allowed in the argument of BUG_ON
> 2b. side effects are not allowed in the argument of BUG_ON

since you quoted me earlier my 2 cents:
1) I would prefer BUG_ON() arguments to not have side effects; its just=20
cleaner that way. (similar to assert)

2) if one wants to compiel out BUG_ON, I rather alias it to panic() than
to nothing.


--=-0TDvNVI2te2pQj/dpvOD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBM4xxxULwo51rQBIRAteAAJ4pqhKgFIx28uq9aeduyBIIQ80gXwCeOr1G
9U/VQwjFDE0X/Oh7xyPVbBE=
=i7qx
-----END PGP SIGNATURE-----

--=-0TDvNVI2te2pQj/dpvOD--

