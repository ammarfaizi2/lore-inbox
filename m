Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUESL4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUESL4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUESL4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:56:16 -0400
Received: from mx1.actcom.net.il ([192.114.47.13]:27340 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S262388AbUESL4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:56:14 -0400
Date: Wed, 19 May 2004 13:54:29 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
Message-ID: <20040519105429.GH31630@mulix.org>
References: <20040519122350.2792e050.ak@suse.de> <20040519104339.GG31630@mulix.org> <20040519125001.3866f830.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Hr//EUsa8//ouuB"
Content-Disposition: inline
In-Reply-To: <20040519125001.3866f830.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+Hr//EUsa8//ouuB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2004 at 12:50:01PM +0200, Andi Kleen wrote:
> On Wed, 19 May 2004 13:43:40 +0300
> Muli Ben-Yehuda <mulix@mulix.org> wrote:
>=20
> > On Wed, May 19, 2004 at 12:23:50PM +0200, Andi Kleen wrote:
> > >=20
> > > futex_wait goes to an interruptible sleep, but does a WARN_ON later
> > > if it wakes up early. But waking up early is totally legal, since
> > > the sleep is interruptible and any signal can wake it up.
> >=20
> > That's not what the WARN_ON is saynig, unless I'm missing
> > something. It's checking if we were woken up early and there's no
> > signal pending for us.=20
>=20
> True. Anyways, it seems to happen in practice.

Granted; the interesting question is whether this is harmless or
something to worry about. Any ideas why it happens?=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--+Hr//EUsa8//ouuB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqzzlKRs727/VN8sRApYKAJ9u5jld8rcOY26sUvTwc6LuzQDGugCfWn3c
l9EW5Wn5w38wEINNqZWAhbc=
=xeil
-----END PGP SIGNATURE-----

--+Hr//EUsa8//ouuB--
