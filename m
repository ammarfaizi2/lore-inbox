Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263377AbTDLTD7 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbTDLTD7 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:03:59 -0400
Received: from wooledge.org ([209.142.155.49]:19204 "HELO pegasus.wooledge.org")
	by vger.kernel.org with SMTP id S263377AbTDLTD6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 15:03:58 -0400
Date: Sat, 12 Apr 2003 15:15:13 -0400
From: Greg Wooledge <greg@wooledge.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NFS client hangs when X is running (2.4.20)
Message-ID: <20030412191512.GA21966@pegasus.wooledge.org>
References: <20030411233132.GA15999@pegasus.wooledge.org> <shsfzoodpgy.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <shsfzoodpgy.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
X-Operating-System: OpenBSD 3.2
X-www.distributed.net: 128 packets (128.00 stats units) [2,849,911 keys/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Trond Myklebust (trond.myklebust@fys.uio.no) wrote:

> Sounds very much like a network card driver problem.

I don't think so, simply because this has happened to me on two
compeletely different Linux systems.  One (griffon) has a 3c59x
card, and the other (dwarf) had a tulip and an ne2k-pci.

(Or did you mean on the server side?  The OpenBSD box is using two
RTL 8139 cards.)

>      > [5.] nfs: server pegasus not responding, still trying However,
>      > this is erroneous.  Pegasus (the OpenBSD box) responds
>      > perfectly to ping, showmount -e, ssh and so on.  Any existing
>      > ssh connections to pegasus continue working, even ones I
>      > started in an rxvt window in the 15-30 second period when the
>      > NFS subsystem hadn't locked up yet.  No other errors are
>      > reported.
>=20
> .... and a tcpdump would show?

I haven't tried that yet, but after discussing this with another
person who was having the same problems, we learned that OpenBSD's
firewall (pf) was blocking the Linux packets when configured with
"scrub in all" (which is recommended in the OpenBSD FAQs).

After commenting out the "scrub in all" and rebooting back to 2.4.20,
I have X and NFS working simultaneously.

--=20
Greg Wooledge                  |   "Truth belongs to everybody."
greg@wooledge.org              |    - The Red Hot Chili Peppers
http://wooledge.org/~greg/     |

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (OpenBSD)

iD8DBQE+mGXAkAkqAYpL9t8RAohjAKDF61A1hE7sJLmPDQOKINuSeD3legCgqc+1
lntcJ+vDpzrdIpHXbz1HqA4=
=Zkst
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
