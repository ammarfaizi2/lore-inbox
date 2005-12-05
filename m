Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVLEXXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVLEXXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVLEXXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:23:48 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:13583 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S964848AbVLEXXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:23:46 -0500
Date: Mon, 5 Dec 2005 23:23:01 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
       Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] natsemi: NAPI support
Message-ID: <20051205232301.GA4551@sirena.org.uk>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
	Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20051204231209.GA28949@electric-eye.fr.zoreil.com>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Dec 05, 2005 at 12:12:09AM +0100, Francois 
	Romieu wrote: > -> netif_poll_disable() may sleep while a spinlock is 
	held. So it can, thanks. [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2005 at 12:12:09AM +0100, Francois Romieu wrote:

> -> netif_poll_disable() may sleep while a spinlock is held.

So it can, thanks.

> Btw, the poll/close routines seem racy with each other.

I had been under the impression that the stack was supposed to make sure
that no poll() is running before the driver close() gets called?  I
could well be missing something there, though.  Indeed, now that I think
about it the calls netif_poll_disable() in suspend() ought to mean that
we don't need to look at hands_off inside poll().

--=20
"You grabbed my hand and we fell into it, like a daydream - or a fever."

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ5TL0w2erOLNe+68AQJaEAP/UO3bW/DMlaja/hXTTaP0mfEnjJx2JB5o
wO5lIJjldC+NKiOOk/bMPmjJfh9u5rUXC/vGJiBvH1y6ton0WAWCbcdrV8XPVSYw
dRBqAetDsNJ1QpGm3FsI7K1Clz+VE9ZdnlmGMMNlifCyP6oVC9jzr9HC7hhWb7M0
HlbjZxmRNHQ=
=BEhk
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
