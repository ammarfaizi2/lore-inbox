Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265988AbUFIVhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUFIVhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUFIVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:37:11 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:18637 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S265988AbUFIVhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:37:04 -0400
Date: Wed, 9 Jun 2004 23:33:38 +0200
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Alex Williamson <alex.williamson@hp.com>, clameter@sgi.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-ID: <20040609213338.GI11490@sunbeam.de.gnumonks.org>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com> <1086805676.4288.16.camel@tdi> <20040609130001.37a88da1.davem@redhat.com> <1086812976.4288.50.camel@tdi> <20040609132937.68866dfc.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
In-Reply-To: <20040609132937.68866dfc.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2004 at 01:29:37PM -0700, David S. Miller wrote:
> On Wed, 09 Jun 2004 14:29:36 -0600
> Alex Williamson <alex.williamson@hp.com> wrote:
>=20
> >    Which is probably why the patch never went anywhere.  There's
> > certainly an alignment issue in the usage of the struct arpt_arp in the
> > code snippet Christoph pointed out.  Sounds like it'd be better to fix
> > the usage than the structure alignment.
>=20
> Right.  I distinctly remember a similar fix being needed to
> ip_tables.c many months ago, a search though the change history
> for that file might prove profitable :-)

Or alternatively look into the netfilter bugzilla at:

https://bugzilla.netfilter.org/cgi-bin/bugzilla/show_bug.cgi?id=3D84

If somebody wants to prepare a trivial merge of that fix with arptables
- it should be extermely straight forward ;)

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAx4IyXaXGVTD0i/8RApWlAJwOwa7pUiQKuKEz+RN2p/WhgSv53gCeP/Nf
J0X0TRMCUWjuhbCPC3Iil6Q=
=nCqG
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
