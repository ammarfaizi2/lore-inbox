Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTLJBUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTLJBUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:20:33 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:54452
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S262888AbTLJBUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:20:31 -0500
Subject: NForce2 and AMD, disconnect.
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: ross@datscreative.com.au
In-Reply-To: <1071007478.5293.11.camel@athlonxp.bradney.info>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <200312081207.45297.ross@datscreative.com.au>
	 <1070993538.1674.10.camel@big.pomac.com>
	 <1071007478.5293.11.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aREIXKuf50j4q72En51J"
Message-Id: <1071019231.1670.35.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 02:20:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aREIXKuf50j4q72En51J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, again.

I did some reading on amd's site, and if the disconnect + apic fixed the
same problem as the ~500ns delay, then it could be as i suspect...

I suspect that something goes wrong with apic ack when the cpu is
disconnected and according to the amd docs we could check the
Northbridge's CLKFWDRST or isn't that avail on the outside?
(It would be interesting to see if that fixes the problem as well.)

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/262=
37.PDF

I don't really have the knowledge but it would sure be nicer to fix this
by checking this than to just disable it. I dunno if there is something
we could do from within the kernel aswell with the sending of HLT but i
doubt it.

Anyways, we need a generalized patch that does better checking on the
NMI bit (like Ross' patch).=20

PS. Anyone that can point me to northbridge tech docks? and CC

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-aREIXKuf50j4q72En51J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/1nTf7F3Euyc51N8RAqpFAKC4G2zeDQyXGf+6r+Hli9w74jDcCwCfXCPV
pg67pPEtReaU2ydtW26IICw=
=grm1
-----END PGP SIGNATURE-----

--=-aREIXKuf50j4q72En51J--

