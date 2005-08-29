Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVH2XwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVH2XwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVH2XwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:52:00 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:20713 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S932081AbVH2Xv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:51:59 -0400
Date: Tue, 30 Aug 2005 09:51:31 +1000
From: James Cameron <james.cameron@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, frank@google.com,
       linux-kernel@vger.kernel.org, james.cameron@hp.com
Subject: Re: ppp_mppe+pptp for 2.6.14?
Message-ID: <20050829235131.GB20452@hp.com>
References: <431341F4.8010200@gentoo.org> <20050829221034.GA4161@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20050829221034.GA4161@lists.us.dell.com>
Organization: Netrek Vanilla Server Dictator
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2005 at 05:10:34PM -0500, Matt Domsch wrote:
> I've asked James Cameron, pptp project lead, to try a test to force
> the server side to issue a CCP DOWN, to make sure the client-side
> kernel ppp_generic module does the right thing and drops packets.

I'm still working on this; tried Matt's patch against 2.6.13 last night,
but it seems 2.6.13 has broken raw sockets for pptp and pptpd ...
ENOPROTOOPT returned from the read() on the raw socket carrying the GRE
stream from pptp to the net.  Wasn't happening with 2.6.12.5.

My plan is to try Matt's patch against 2.6.12.5, and try 2.6.13 bare, to
isolate the cause of the ENOPROTOOPT changed behaviour.

The previous version of Matt's patch (before the SC_MUST_COMP feature)
is working fine for me with 2.6.12.5.

(If anyone has any ideas on raw socket breakage, let me know.  2.6.13
changed net/ipv4/raw.c but the changes look to me to be minor.)

--=20
James Cameron

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDE5+DIiWKUhK+Mj4RAgfPAJ4tvZ0i3by3827Yvh30SxNMxhuDZwCfSVWg
zDRI0VqnN47tz9iYtvcv/1c=
=Hltq
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
