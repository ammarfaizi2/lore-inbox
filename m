Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUCBMai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 07:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbUCBMaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 07:30:35 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:17643 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S261624AbUCBMad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 07:30:33 -0500
Date: Tue, 2 Mar 2004 14:29:09 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: modules registering as sysctl handlers
Message-ID: <20040302122909.GG24260@mulix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi=20

Looking at 2.6.3-bk, it appears that the sysctl code does not raise a
module's reference count before calling a sysctl handler registered by
that module.=20

- are modules allowed to register sysctl handlers?
register_sysctl_table is exported, so I imagine so.=20

- am I missing something and modules are in fact protected against
concurrent unloading and invocation of sysctl?

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARH4UKRs727/VN8sRAmfJAJ93L3cBTyLdOtLxS5GtbPzM9v54+ACgtAK/
Y7o8KXEanh7yLaWUGZCzDAs=
=1x5k
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
