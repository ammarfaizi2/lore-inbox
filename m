Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUERMa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUERMa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUERMa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:30:26 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:18440 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263184AbUERMaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:30:22 -0400
Date: Tue, 18 May 2004 14:30:20 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Dominik Karall <dominik.karall@gmx.net>
Subject: Re: [PATCH] Sis900 bug fixes 3/4
Message-ID: <20040518123020.GF23565@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Dominik Karall <dominik.karall@gmx.net>
References: <20040518120237.GC23565@picchio.gall.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
In-Reply-To: <20040518120237.GC23565@picchio.gall.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch 3 of 4

Fix PHY transceiver detection code to fall back to known PHY and not to
the last detected.
The code checks every transceiver detected for link status and type, but
fails when ghost transceivers are detected, deciding to use the last one
detected.

With this patch the driver should choose the correct transceiver even
when some ghosts are detected by checking for the type of the tranceiver
it is going to use.

This patch needs that patch #2 is applied before.

Any comment is highly appreciated.

Dominik:
Could you please test this patch ? Thanks.

--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqgHc2rmHZCWzV+0RAifMAKCzVt6XMO5jG4JgRQMvdQ2fGELKmQCePt4n
nsgDAM5s9bUekYBZZjXgQDs=
=cpW+
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
