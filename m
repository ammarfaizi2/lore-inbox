Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266671AbUF3NH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266671AbUF3NH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUF3NF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:05:29 -0400
Received: from smtp.golden.net ([199.166.210.31]:18692 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S266665AbUF3NE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:04:59 -0400
Date: Wed, 30 Jun 2004 09:04:49 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: jsimmons@pentafluge.infradead.org
Cc: Eric Lammerts <eric@lammerts.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asiliantfb fixes
Message-ID: <20040630130448.GI29025@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	jsimmons@pentafluge.infradead.org, Eric Lammerts <eric@lammerts.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0406292217520.5837@ally.lammerts.org> <20040630031755.GF29025@linux-sh.org> <Pine.LNX.4.56.0406301252220.23967@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406301252220.23967@pentafluge.infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 30, 2004 at 12:52:49PM +0100, jsimmons@pentafluge.infradead.org=
 wrote:
>=20
> The below fix is missing. It needs to be applied.
>=20

Yes, this still needs to be merged. Can you roll this into your next
batch of fb updates? If not, I'll pass it along, unless Andrew decides to
merge this directly.

> --- linux-2.6.7/drivers/video/asiliantfb.c.orig 2004-06-28=20
> 22:03:38.000000000 -0400
> +++ linux-2.6.7/drivers/video/asiliantfb.c      2004-06-28=20
> 22:04:28.000000000 -0400
> @@ -571,7 +571,7 @@
>         }
>=20
>         pci_write_config_dword(dp, 4, 0x02800083);
> -       writeb(3, addr + 0x400784);
> +       writeb(3, p->screen_base + 0x400784);
>=20
>         init_asiliant(p, addr);
>=20

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4rpw1K+teJFxZ9wRAh9PAJ9JD84K7NHa/E8O8liPhDtnq8zYTQCdGPNN
qxWtqMDUApL3V/zQ0W3mmHs=
=GRnS
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
