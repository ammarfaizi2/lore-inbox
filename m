Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265653AbUEZNMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUEZNMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbUEZNJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:09:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265653AbUEZNFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:05:20 -0400
Date: Wed, 26 May 2004 15:05:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526130500.GB18028@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20040526130047.GF12142@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2004 at 03:00:47PM +0200, J=F6rn Engel wrote:
> > > Experience indicates that for whatever reason, big stack consumers for
> > > all three contexts never hit at the same time.  Big stack consumers
> > > for one context happen too often, though.  "Too often" may be quite
> > > rare, but considering the result of a stack overflow, even "quite
> > > rare" is too much.  "Never" is the only acceptable target.
> >=20

> > actually the 4k stacks approach gives MORE breathing room for the probl=
em
> > cases that are getting hit by our customers...
>=20
> For the cases you described, yes.  For some others like nvidia, no.
> Not sure if we want to make things worse for some users in order to
> improve things for others (better paying ones?).  I want the seperate


You used the word "Never" and now you go away from it.... It wasn't Never,
and it will never be never if you want to include random binary only
modules. However in 2.4 for all intents and pruposes there was 4Kb already,
and now there still is, for user context. Because those interrupts DO
happen. NVidia was a walking timebomb, and with one function using 4Kb
that's an obvious Needs-Fix case. The kernel had a few of those in rare
drivers, most of which have been fixed by now. It'll never be never, but it
never was never either.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAtJX7xULwo51rQBIRAouqAJ9zDJRkZIdNFytL4fENOLuFZTgEJgCfa8fg
N50j/AtFPWjmG/0rXRZm4lY=
=v4Qg
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
