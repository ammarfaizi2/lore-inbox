Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272540AbTHEQH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272819AbTHEQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:07:28 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:4082 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S272540AbTHEQH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:07:27 -0400
Subject: Re: [PATCH] revert to static = {0}
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rddunlap@osdl.org>, Leann Ogasawara <ogasawara@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qsFPJfUXIeYMqb5NpooN"
Organization: Red Hat, Inc.
Message-Id: <1060099637.5308.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 05 Aug 2003 18:07:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qsFPJfUXIeYMqb5NpooN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 17:48, Hugh Dickins wrote:
> Please revert to static zero initialization of a const: when thus
> initialized it's linked into a readonly cacheline shared between cpus;
> otherwise it's linked into bss, likely to be in a dirty cacheline
> bouncing between cpus.

how about adding a big fat comment here that says this?
Otherwise this keeps happening all the time...

--=-qsFPJfUXIeYMqb5NpooN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/L9Y1xULwo51rQBIRAjuhAJoCLm901EsaUj3oytoPPnYkrcIw3wCeNhbU
k5221AOrkV1mclhc6NI9isQ=
=CWKm
-----END PGP SIGNATURE-----

--=-qsFPJfUXIeYMqb5NpooN--
