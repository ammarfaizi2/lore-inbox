Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUIQIrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUIQIrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIQIrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:47:17 -0400
Received: from srv1.dnstoip.com ([66.220.30.245]:39900 "EHLO srv1.dnstoip.com")
	by vger.kernel.org with ESMTP id S268580AbUIQIrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:47:15 -0400
Subject: [patch] xpad driver - incorrect axis settings
From: William Pettersson <enigma@strudel-hound.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KjFWa9oRI1maQO+vZYJb"
Message-Id: <1095410828.2097.11.camel@enigmas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Sep 2004 18:47:08 +1000
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv1.dnstoip.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - strudel-hound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KjFWa9oRI1maQO+vZYJb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
Seems the xpad (xbox controller) driver, whilst functioning, reported
down as up, and up as down, on the analogue joysticks for the xpad.=20
Also the L and R triggers were implemented as axis, rather than buttons.
This patch fixes up both of those issues.  I'm yet to have any people
have any errors with it, although not many people have tested it.  Also
it seems weird that the driver would be reported functioning if the axis
were inverted, so it might be just an issue with the S controllers from
Microsoft.  I tried contacting the maintainer, but got no response from
his email account.
Here's a patch, which patches against most 2.6 kernels, including
2.6.8.1 and 2.6.9, and inverts the axis and fixes the buttons
http://www.strudel-hound.com/xpad-0.6.patch

As soon as I can find an original xbox controller, I'll test it out with
my driver to see what it does.  Until then, are there any changes anyone
could suggest?  Or if anyone could test it out with an actual original
xbox controller, or any xbox controller for that matter, it would be
great.  I'm willing to listen to any advice or demands or insults, I am
not an experience programmer and will make mistakes

William

--=-KjFWa9oRI1maQO+vZYJb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSqSMNSpXjKoV00kRAmvVAJ9irhP+k7irkwqP8/TXB6+2pcoaSgCeKqPN
tcztV6S5hZHOM284Hrl7KKg=
=+jib
-----END PGP SIGNATURE-----

--=-KjFWa9oRI1maQO+vZYJb--

