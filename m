Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUHYXtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUHYXtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHYXtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:49:35 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:42922 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S266281AbUHYXs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:48:58 -0400
Date: Thu, 26 Aug 2004 01:48:39 +0200
From: Harald Welte <laforge@netfilter.org>
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040825234839.GT5824@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Henrik Nordstrom <hno@marasystems.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <412CDFEE.1010505@triplehelix.org> <20040825203206.GS5824@sunbeam.de.gnumonks.org> <Pine.LNX.4.61.0408252334230.28603@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408252334230.28603@filer.marasystems.com>
User-Agent: Mutt/1.5.6+20040722i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2004 at 11:35:05PM +0200, Henrik Nordstrom wrote:
> On Wed, 25 Aug 2004, Harald Welte wrote:
>=20
> >The 'problem' is that we try to get a readlock while we're already
> >protected under a write lock.
> >
> >Please see the following [quite trivial, but yet untested] patch:
> >
> >EXPORT_SYMBOL(ip_nat_used_tuple);
> >+EXPORT_SYMBOL(ip_nat_find_helper);
>=20
> Why this new exported symbol?

Because other code that is not yet in the kernel needs it (like
ct_sync).  That's one of the reasons to get the API's straightened out
:)

> Regards
> Henrik

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBLSVXXaXGVTD0i/8RAgGAAJ9XCMFisXx4c0gkIuPGghcRt1dk3QCfQpZx
G3+ul7abzCbmKiRMthsu7Qg=
=5MII
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
