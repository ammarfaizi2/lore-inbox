Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUEaUXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUEaUXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUEaUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:23:36 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:55234 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264776AbUEaUXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:23:19 -0400
Date: Mon, 31 May 2004 21:23:09 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Michal Jaegermann <michal@harddata.com>
Cc: Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
Message-ID: <20040531202308.GD10420@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Michal Jaegermann <michal@harddata.com>,
	Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org
References: <200405310250.i4V2ork05673@mailout.despammed.com> <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au> <20040531141253.A18246@mail.harddata.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20040531141253.A18246@mail.harddata.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 31, 2004 at 02:12:53PM -0600, Michal Jaegermann wrote:
> On Mon, May 31, 2004 at 01:44:40PM +0800, Ian Kent wrote:
> > 
> > Why not scaled longs (or bigger), scalled to number of significant 
> > digits. The Taylor series for the trig functions might be a painfull.
> 
> Taylor series usually are painful for anything you want to calculate
> by any practical means.  Slow convergence but, for a change, quickly
> growing roundup errors and things like that.  An importance and uses
> of Taylor series lie elsewhere.
> 
> OTOH polynomial approximations, or rational ones (after all division
> is quite quick on modern processors), can be fast and surprisingly
> precise; especially if you know bounds for your arguments and that
> that range is not too wide.  Of course when doing that in a fixed
> point one needs to pay attention to possible overflows and
> structuring calculations to guard against a loss of precision is
> always a good idea.

   It's also worth pointing out that there are other, much
faster-converging, polynomial series that can be used to approximate
trig functions. Chebyshev polynomials are, I believe, pretty
well-behaved. IIRC, they are what the Sinclair Spectrum used to use.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Hey, Virtual Memory! Now I can have a *really big* ramdisk! ---   

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu5QsssJ7whwzWGARAvTiAJwPtEGCphvpokA/B1GoYH8XjwYf9gCePkqu
8JJDdl5nXWQU6bgz4fc/lnM=
=sxiN
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
