Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272636AbTHEKyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272644AbTHEKyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:54:51 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:63727 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S272636AbTHEKyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:54:49 -0400
Subject: Re: [PATCH] O13int for interactivity
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <200308052045.39476.kernel@kolivas.org>
References: <200308050207.18096.kernel@kolivas.org>
	 <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au>
	 <200308052045.39476.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y9amqA3uaIo6D43aIGmp"
Organization: Red Hat, Inc.
Message-Id: <1060080867.5308.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 05 Aug 2003 12:54:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y9amqA3uaIo6D43aIGmp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 12:45, Con Kolivas wrote:
> On Tue, 5 Aug 2003 20:32, Nick Piggin wrote:
> > What you are doing is restricting some range so it can adapt more quick=
ly
> > right? So you still have the problem in the cases where you are not
> > restricting this range.
>=20
> Avoiding it becoming interactive in the first place is the answer. Anythi=
ng=20
> more rapid and X dies dead as soon as you start moving a window for examp=
le,=20
> and new apps are seen as cpu hogs during startup and will take _forever_ =
to=20
> start under load. It's a tricky juggling act and I keep throwing more bal=
ls=20
> at it.

generally that's a sign that the approach might not be the best one.

Lets face it: we're trying to estimate behavior here. Result: There
ALWAYS will be mistakes in that estimator. The more complex the
estimator the fewer such cases you will have, but the more mis-estimated
such cases will be.
The only way to really deal with estimators is to *ALSO* make the price
you pay on mis-estimation acceptable. For the scheduler that most likely
means that you can't punish as hard as we do now, nor give bonuses as
much as we do now.


--=-Y9amqA3uaIo6D43aIGmp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/L4zjxULwo51rQBIRAnbzAJ9nHWeHAVeR6VKKI8xtLMPx1oteAgCgpjWO
N+iFz8R8F7gOTSRyC5MNWx8=
=JUuK
-----END PGP SIGNATURE-----

--=-Y9amqA3uaIo6D43aIGmp--
