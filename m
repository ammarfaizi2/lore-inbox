Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWC1KXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWC1KXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWC1KXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:23:51 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:43463 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751259AbWC1KXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:23:50 -0500
Date: Tue, 28 Mar 2006 12:23:46 +0200
From: Harald Welte <laforge@netfilter.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: Re: failed to configure iptables with 2.6.16 kernel
Message-ID: <20060328102346.GJ28782@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Hubert Tonneau <hubert.tonneau@fullpliant.org>,
	linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
References: <064G9Y712@briare1.heliogroup.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVHblb/y9DPlgkHs"
Content-Disposition: inline
In-Reply-To: <064G9Y712@briare1.heliogroup.fr>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qVHblb/y9DPlgkHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2006 at 01:10:54PM +0000, Hubert Tonneau wrote:
> Harald Welte wrote:
> >
> > this sounds like you're missing support for the tcp/udp match.
> > This functionality is implemented in xt_tcpudp.{c,ko}, which is compiled
> > as soon as x_tables is compiled.
>=20
> Loading 'xt_tcpudp' module solves the problem. Thanks for the answer.

great.

> So, the problem was just that the new 'x_tables' module is loaded automat=
ically
> according to modules dependencies, but 'xt_tcpudp' is not.

that is strange, since the iptables userspace program should explicitly
request loading that module. =20

unfortunately you didn't reply to my question on the version number of
the iptables program.  Maybe we have some yet-unknown issues with old
iptables versions, and I want to get to the bottom of this.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--qVHblb/y9DPlgkHs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKQ6yXaXGVTD0i/8RAnSNAKCKF2iy3ZbreCdUBzPyVX3rJzPqjQCfeXF/
dP/3MX7a5Qe68ysHRFgHB/Q=
=Tif9
-----END PGP SIGNATURE-----

--qVHblb/y9DPlgkHs--
