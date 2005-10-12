Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVJLOGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVJLOGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 10:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVJLOGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 10:06:21 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:5834 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S964783AbVJLOGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 10:06:21 -0400
Date: Wed, 12 Oct 2005 16:06:09 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Dave Engebretsen <engebret@us.ibm.com>,
       Santiago Leon <santil@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: correct modalias for vio devices
Message-ID: <20051012140609.GA20729@wavehammer.waldi.eu.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Dave Engebretsen <engebret@us.ibm.com>,
	Santiago Leon <santil@us.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty, Dave, Santiago

The vio devices currently don't have a modalias spec. This makes it
impossible to ask udev for loading the modules.

The modules already specifies a device table, which contains two values,
type and compat. At least for pSeries they seems to be filed from the
compatible and device_type properties in the openfirmware tree. The
pSeries code checks both values, while iSeries only checks the type.

As they need a complete match, the generated modalias string for them
may:
vio:T<type>
or
vio:T<type>C<compat>

Bastian

--=20
There is a multi-legged creature crawling on your shoulder.
		-- Spock, "A Taste of Armageddon", stardate 3193.9

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkNNGFEACgkQnw66O/MvCNHQsgCff2te8QqNs6tt92vSz3B8UkNH
5B8An0Ctv7HgYJK1jmUUG6KPlq3I0OwG
=xZfq
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
