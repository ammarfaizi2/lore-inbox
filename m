Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTDVIb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbTDVIb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:31:58 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47342 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263020AbTDVIb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:31:57 -0400
Subject: Re: [PATCH] Runtime memory barrier patching
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@muc.de
In-Reply-To: <200304220111.h3M1BEp5004047@hera.kernel.org>
References: <200304220111.h3M1BEp5004047@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AbtwhIJBeMqM6ZfpSpD2"
Organization: Red Hat, Inc.
Message-Id: <1051001038.1419.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 22 Apr 2003 10:43:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AbtwhIJBeMqM6ZfpSpD2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-04-22 at 01:23, Linux Kernel Mailing List wrote:
> ChangeSet 1.1169, 2003/04/21 16:23:20-07:00, ak@muc.de
>=20
> 	[PATCH] Runtime memory barrier patching
> =09
> 	This implements automatic code patching of memory barriers based
> 	on the CPU capabilities. Normally lock ; addl $0,(%esp) barriers
> 	are used, but these are a bit slow on the Pentium 4.
> =09

very nice. Question: would it be doable use this for prefetch() as well?
Eg default to a non-prefetch kernel and patch in the proper prefetch
instruction for the current cpu ? (eg AMD prefetch vs Intel one etc etc)


--=-AbtwhIJBeMqM6ZfpSpD2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+pQDOxULwo51rQBIRAmNlAKCI1BcPr2kijggOyagr3YBsMtCwmwCdG0iM
h7UmKcIYm/2dxk50++2WTes=
=nqg1
-----END PGP SIGNATURE-----

--=-AbtwhIJBeMqM6ZfpSpD2--
