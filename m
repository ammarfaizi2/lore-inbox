Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270743AbTGPMh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270744AbTGPMh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:37:28 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:7178 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S270743AbTGPMhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:37:25 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Wed, 16 Jul 2003 08:52:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Error using mii-tool on 2.6-test, 2.4 okay
Message-ID: <20030716125213.GA6582@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


	I've just switched another of my boxes over to 2.6-test; so
far, I've had only one problem -- attempts to force the network card
(tulip-based) to full-duplex with mii-tool fail with:

SIOCGMIIPHY on 'eth0' failed: Operation not supported
no MII interfaces found

       The same command works fine in 2.4.  This the packaged mii-tool
in Debian unstable (1.9 2000/04/28).  I've tried rebuilding the
package on another very similar machine, but the error remains.
Ethtool also doesn't work, but I'm not sure it did with 2.4 and this
card either.

       One thing that caught my eye: I have CONFIG_MII set to "y".
Are mii-tool and CONFIG_MII mutually exclusive?  CONFIG_TULIP is "m";
should CONFIG_MII be "m" too?   =20


--=20
Joseph Fannin
jhf@rivenstone.net

"Linus, please apply.  Breaks everything.  But is cool." -- Rusty Russell.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FUp9Wv4KsgKfSVgRAvZlAKCgz5Jd8lpJb6ZGMJRMf7wKVw6O5QCfQcKj
rYo2zcKbO1Ofj3kFoXGiNYE=
=YNHy
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
