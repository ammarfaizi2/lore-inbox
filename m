Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUAAM3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAAM3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:29:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261539AbUAAM3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:29:01 -0500
Date: Thu, 1 Jan 2004 13:28:51 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
Message-ID: <20040101122851.GA13671@devserv.devel.redhat.com>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com> <1072958618.1603.236.camel@thor.asgaard.local> <1072959055.5717.1.camel@laptop.fenrus.com> <1072959820.1600.252.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1072959820.1600.252.camel@thor.asgaard.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 01, 2004 at 01:23:40PM +0100, Michel D=E4nzer wrote:
> > > How does this patch look?
> >=20
> > ugly.
> >=20
> > I find using #defines for function arguments ugly beyond belief and
> > makes it really hard to look through code. I 10x rather have an ifdef in
> > the function prototype (which then for the mainstream kernel drm can be
> > removed for non-matching versions) than such obfuscation.
>=20
> That doesn't strike me as particularly beautiful either...=20

well the advantage is that the ifdefs can just go away in kernel trees of
specific versions... (eg unifdef it)

> is it really easier for merges, considering that the ugly way is kinda
> needed for functions which take different arguments on BSD anyway?

I disagree there. The "BSD takes different arguments" thing *should* be
fixed imo by making the common core of the function an inline function, and=
 have
one or two (depends if the common core happens to have its arguments in com=
mon
with one of the oses) OS specific wrappers with the right prototype. This
way the difference in error return sign can also be solved in the wrapper
instead of with a nasty macro...

The compiler generates the same code, but it's a lot easier to read/review.

Greetings,
    Arjan van de Ven

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/9BKCxULwo51rQBIRAr4KAKCm1p+mf4n8JYmcGQFCEemK/SBCOwCgleDr
TFEpBtIo87uHrfNTYzeTT1w=
=6etE
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
