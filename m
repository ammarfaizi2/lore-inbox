Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVLFVSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVLFVSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVLFVSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:18:07 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:49162 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1030242AbVLFVSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:18:05 -0500
Date: Tue, 6 Dec 2005 21:17:30 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
       Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] natsemi: NAPI support
Message-ID: <20051206211729.GB3709@sirena.org.uk>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
	Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk> <20051206001934.GA18329@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20051206001934.GA18329@electric-eye.fr.zoreil.com>
X-Cookie: Two heads are more numerous than one.
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Dec 06, 2005 at 01:19:34AM +0100, Francois 
	Romieu wrote: > Mark Brown <broonie@sirena.org.uk> : > > I had been 
	under the impression that the stack was supposed to make sure > > that 
	no poll() is running before the driver close() gets called? [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2005 at 01:19:34AM +0100, Francois Romieu wrote:
> Mark Brown <broonie@sirena.org.uk> :

> > I had been under the impression that the stack was supposed to make sure
> > that no poll() is running before the driver close() gets called?

> Not exactly. dev_close() waits a bit but it can not be sure that the
> device driver will not schedule ->poll() from its irq handler later.

Prior to waiting dev_close() clears __LINK_STATE_START which will cause
netif_rx_schedule_prep() to return false.  As far as I can see that
should prevent the interrupt handler scheduling any further poll() calls?

--=20
"You grabbed my hand and we fell into it, like a daydream - or a fever."

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ5X/4g2erOLNe+68AQIKJgP+LSEKTPx3eJhBB+A+K8jwF/Er7e570wtI
HVdG1DxBe1CHsjydGSVmM7JX6Dk+txBz9MHnEmR4TQiJH47oN1vXgj1SpBearmKj
6kKeXfIBfHwCr/rbcQj26E3RMHi7Dyz8NGXPLK5k1LV2t+GF4CGlJM5Trm9rBpoU
Mj2E5ncd8js=
=Q2H2
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
