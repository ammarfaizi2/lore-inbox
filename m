Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265583AbUEZM5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbUEZM5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUEZMyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:54:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14017 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265585AbUEZMxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:53:18 -0400
Date: Wed, 26 May 2004 14:53:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526125300.GA18028@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20040526125014.GE12142@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2004 at 02:50:14PM +0200, J=F6rn Engel wrote:
>=20
> Experience indicates that for whatever reason, big stack consumers for
> all three contexts never hit at the same time.  Big stack consumers
> for one context happen too often, though.  "Too often" may be quite
> rare, but considering the result of a stack overflow, even "quite
> rare" is too much.  "Never" is the only acceptable target.

Actually it's not mever in 2.4. It does get here there by our customers once
in a while. Esp with several NICs hitting an irq on the same CPU (eg the irq
context goes over it's 2Kb limit)

> done, a stack overflow will merely cause a kernel panic.  Until then,
> I am just as conservative as Andreas.

actually the 4k stacks approach gives MORE breathing room for the problem
cases that are getting hit by our customers...

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAtJMrxULwo51rQBIRAi83AJwIotH+cbvLLRl7G80z4lCdDI0YIgCffhIs
nRUbc2u4ry7Rf6VHG7LreFk=
=/cY2
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
