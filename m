Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUE1NqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUE1NqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUE1NqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:46:08 -0400
Received: from mail.donpac.ru ([80.254.111.2]:35819 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263015AbUE1NqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:46:02 -0400
Date: Fri, 28 May 2004 17:46:00 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528134600.GF7499@pazke>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org> <20040528125447.GB11265@redhat.com> <20040528132358.GA78847@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <20040528132358.GA78847@colin2.muc.de>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 149, 05 28, 2004 at 03:23:58PM +0200, Andi Kleen wrote:
> On Fri, May 28, 2004 at 01:54:47PM +0100, Dave Jones wrote:
> > On Fri, May 28, 2004 at 02:18:52PM +0200, Andi Kleen wrote:
> >=20
> >  > > simplify DMI blacklist table by removing the need to fill
> >  > > unused slots with NO_MATCH macro.
> >  >=20
> >  > Can you please delay that patch for 2.7?
> >  > 2.6 is for bug fixes, not for cleanups.
> >  >=20
> >  > There are large third party patchkits for DMI and "cleaning up"=20
> >  > the format will just cause lots of rejects and pain.=20
> >=20
> > Alternatively, those third parties could get their act
> > together and submit those patches back upstream.
>=20
> Often this is not the best thing to do - e.g. for upstream it is=20
> better to track down the bugs and try to fix them, even if that
> takes a long time or find some other cleaner solution that doesn't
> involve blacklisting. For a third party there are often time constraints=
=20
> (e.g. for a release) where there is no time to track down everything and=
=20
> blacklisting has to be more extensively used.

See the next patch then, it should make life of third party developers
much simpler. Also I can modify the patch to provide NO_MATCH constant,
so there will be no visible differencies.
=20
> My point stays that kernel interfaces should stay stable in the stable
> series as far as possible (=3D unless terminally broken, but that's
> clearly not the case here).  If you feel the need to clean up
> something better wait for the unstable series.

I can't call dmi_scan.c a kernel interface, currently it's a crap.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAt0KYby9O0+A2ZecRAgjbAKDPxZ8fweUMwpCvPcpagP2QnJhEkwCfROla
yh1ZM/5k0rF3bNvUL1tCacc=
=H6N6
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
