Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVDZI7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVDZI7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDZI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:59:08 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:43433 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261401AbVDZI7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:59:01 -0400
Date: Tue, 26 Apr 2005 10:58:18 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: 7eggert@gmx.de, akpm@osdl.org, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] private mounts
Message-ID: <20050426085817.GA9131@vagabond>
References: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <OF9C5A2A1D.78873E27-ON88256FEE.00683441-88256FEE.00688DC9@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <OF9C5A2A1D.78873E27-ON88256FEE.00683441-88256FEE.00688DC9@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2005 at 12:02:43 -0700, Bryan Henderson wrote:
> >mknamespace -p users/$UID # (like mkdir -p)
> >setnamespace users/$UID   # (like cd)
>        ^^^^^^^^
>=20
> You realize that 'cd' is a shell command, and has to be, I hope.  That=20
> little fact has thrown a wrench into many of the ideas in this thread.

You don't want to have such command, really! What you want is a PAM
module, that looks whether there is already a session for that user and
switches to it's namespace, if it does. Remember that it's namespace
- it can be first created, then attached and then populated with mounts.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbgKpRel1vVwhjGURAvcCAJ9uTr5iy8uvbR1xwY0a7xMC/Qv51wCfVRsm
QVgUu6PUrJCwZDYQ1YLvkjQ=
=519K
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
