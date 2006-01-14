Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWANUi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWANUi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWANUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:38:27 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:55970 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751089AbWANUi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:38:27 -0500
Date: Sat, 14 Jan 2006 21:38:19 +0100
From: Harald Welte <laforge@netfilter.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.15-mm4] fix warning in ip{,6}t_policy.c
Message-ID: <20060114203818.GE6740@sunbeam.de.gnumonks.org>
References: <20060114180917.GA26443@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Content-Disposition: inline
In-Reply-To: <20060114180917.GA26443@ens-lyon.fr>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2006 at 07:09:17PM +0100, Benoit Boissinot wrote:
> Hi,
>=20
> the following warnings appeared in -mm4
> net/ipv4/netfilter/ipt_policy.c:154: warning: initialization from incompa=
tible pointer type
> net/ipv4/netfilter/ipt_policy.c:155: warning: initialization from incompa=
tible pointer type
> net/ipv6/netfilter/ip6t_policy.c:160: warning: initialization from incomp=
atible pointer type

oops, sorry. my mistake when merging patricks' ipt_policy code with
x_tables.

> It looks like they were missed in the x_tables conversion.

yes, since they were developed separately and only later merged.

> Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

I'll push this without any modifications via DaveM.
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyWE6XaXGVTD0i/8RAmZ3AJ92ZzGPDY1kE1rTnMNYLksfcdQWAwCghZrO
sANDD+HbTKMWKR9qOMe8lf4=
=HYJk
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--
