Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWBCJzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWBCJzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBCJzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:55:41 -0500
Received: from admingilde.org ([213.95.32.146]:24292 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932199AbWBCJzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:55:40 -0500
Date: Fri, 3 Feb 2006 10:55:36 +0100
From: Martin Waitz <tali@admingilde.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
       Keith Owens <kaos@sgi.com>
Subject: Re: [patch 05/44] generic {,test_and_}{set,clear,change}_bit()
Message-ID: <20060203095536.GO11002@admingilde.org>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Keith Owens <kaos@sgi.com>
References: <20060201090224.536581000@localhost.localdomain> <20060201090322.252374000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JlJsEFsx9RQyiX4C"
Content-Disposition: inline
In-Reply-To: <20060201090322.252374000@localhost.localdomain>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JlJsEFsx9RQyiX4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Feb 01, 2006 at 06:02:29PM +0900, Akinobu Mita wrote:
> +static __inline__ void set_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask =3D BITOP_MASK(nr);
> +	unsigned long *p =3D ((unsigned long *)addr) + BITOP_WORD(nr);
> +	unsigned long flags;
> +
> +	_atomic_spin_lock_irqsave(p, flags);
> +	*p  |=3D mask;
> +	_atomic_spin_unlock_irqrestore(p, flags);
> +}

You could even use your new generic non-atomic bitops to implement these

--=20
Martin Waitz

--JlJsEFsx9RQyiX4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD4yiYj/Eaxd/oD7IRArHHAJ9OBK4Lr6HDMj73PqpXo7diCEeDyACfbnKC
CP9904hBRBoIGYAHf537EZU=
=cmeF
-----END PGP SIGNATURE-----

--JlJsEFsx9RQyiX4C--
