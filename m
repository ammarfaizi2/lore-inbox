Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTLZJWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 04:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTLZJWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 04:22:55 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:43648 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265063AbTLZJWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 04:22:53 -0500
Subject: Re: Page aging broken in 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, riel@surriel.com
In-Reply-To: <20031225234023.20396cbc.akpm@osdl.org>
References: <1072423739.15458.62.camel@gaston>
	 <20031225234023.20396cbc.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WFhY2CBHumPBK4toubMJ"
Organization: Red Hat, Inc.
Message-Id: <1072430500.5222.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Dec 2003 10:21:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WFhY2CBHumPBK4toubMJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > And we never flush the TLB entry.=20
> >=20
> > I don't know if x86 (or other archs really using page tables) will
> > actually set the referenced bit again in the PTE if it's already set
> > in the TLB, if not, then x86 needs a flush too.
>=20
> x86 needs a flush_tlb_page(), yes.

it does? Are you 100% sure ?

Afaik x86 is very very slow in setting the A and D bits (like 2000 to
3000 cycles) *because* it doesn't need a TLB flush....




--=-WFhY2CBHumPBK4toubMJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6/2kxULwo51rQBIRAiWnAJ4/K1GSl2QXV443FbHTFEQAeG09WACgkqTj
4wyRLgeq+JS9N1qIZAErWPM=
=jZ22
-----END PGP SIGNATURE-----

--=-WFhY2CBHumPBK4toubMJ--
