Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270640AbTHEUUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270647AbTHEUUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:20:39 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:20466 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270640AbTHEUUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:20:25 -0400
Subject: Re: [PATCH] Export touch_nmi_watchdog
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030805200810.GA31598@colin2.muc.de>
References: <20030805192908.GA19867@averell>
	 <20030805123811.1fe61585.akpm@osdl.org>
	 <20030805200810.GA31598@colin2.muc.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-81kpQpZfvpXH9nInBbet"
Organization: Red Hat, Inc.
Message-Id: <1060114808.5308.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 05 Aug 2003 22:20:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-81kpQpZfvpXH9nInBbet
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 22:08, Andi Kleen wrote:
> On Tue, Aug 05, 2003 at 12:38:11PM -0700, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > Sometimes drivers do long things with interrupt off and the NMI watch=
dog
> > >  triggers quickly. This mostly happens in error handling. It would be=
=20
> > >  better to fix the drivers to sleep in this case, but it's not always
> > >  possible or too much work.
> >=20
> > yup.
> >=20
> > Do we need an mdelay_while_touching_nmi_watchdog() variant?
>=20
> Maybe that would be too encoraging for broken code.=20
>=20
> Admittedly I did that by hand for the MPT fusion driver (which currently=20
> triggers the watchdog when it gets into any error handling situation)=20
> This especially hurts on x86-64 which runs the watchdog by default.=20
> But it's strictly a bad hack, not a good interface.

having a more generic/portable "trigger_watchdog" function would be
better then, such that ALL watchdogs, and not just the NMI one can hook
into this

--=-81kpQpZfvpXH9nInBbet
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MBF4xULwo51rQBIRArGqAJ94V6EHEfJsX1jCLDmVUj+X91EnjgCdFSLr
ji67L9ODafw7X0nyiI/bIy8=
=qXfz
-----END PGP SIGNATURE-----

--=-81kpQpZfvpXH9nInBbet--
