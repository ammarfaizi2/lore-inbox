Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUFUWhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUFUWhq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUFUWgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:36:07 -0400
Received: from wblv-246-169.telkomadsl.co.za ([165.165.246.169]:15033 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266492AbUFUWd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:33:56 -0400
Subject: Re: [PATCH 0/2] kbuild updates
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040621223108.GC2903@mars.ravnborg.org>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <200406210026.43988.agruen@suse.de>
	 <1087771141.14794.89.camel@nosferatu.lan>
	 <200406210151.43325.agruen@suse.de>
	 <20040621223108.GC2903@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GlwxzMLhsdgHMRWwdecx"
Message-Id: <1087857197.9639.39.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 00:33:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GlwxzMLhsdgHMRWwdecx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-22 at 00:31, Sam Ravnborg wrote:
> On Mon, Jun 21, 2004 at 01:51:43AM +0200, Andreas Gruenbacher wrote:
> > > But my original concern (that the only way to figure where the source
> > > are for the running kernel will be broken) is still valid.
> >=20
> > User-space stuff that needs access to kernel headers at build time is a=
=20
> > problem. But for those programs, depending on the running kernel instea=
d of=20
> > simply looking in /usr/src/linux is an even bigger problem: What guaran=
tees=20
> > that the first time the program is run, the kernel will still be the sa=
me? So=20
> > depending on the running kernel is definitely wrong. Depending=20
> > on /usr/src/linux is also wrong; ideally those programs should look=20
> > in /usr/include/{linux,asm}. Unfortunately these headers are not always=
=20
> > recent enough, and so recently added definitions may be missing.
>=20
> But Martin has a point here.
> How to figure out for example the number of arguments to remap_page_range=
.
> One could do some grepping in the mm.h file, or one could try to compile
> a minimal module calling this function.
> If we go for the simple version by grepping we need to figure out where
> to find the source. In the past this was simple - just follow the
> build symlink. But now kernels may be shipped with separate source
> and output directory exposing the weakness of this method.
> A much more reliable way is to build a simple module.
> If the module build succeeds that specific version
> of remap_page_range is OK.
>=20
> nvidia does something similar, but they take the false assumption
> that the running kernel is always the one being build for.
> So they call gcc direct.
>=20
> Other modules uses the grep method - which will fail when the kernel
> is build with separate output and source directories.
>=20

Might it help if there was some silly 'external module example toolkit'
or whatever, that shows how to figure out with kbuild how to determine
srcdir, figure out how many args remap_page_range takes, etc?

I will admit that most fixes I do to external modules is maybe not
really because their build systems is 'buggy' as such, but more because
of short-sightedness and lack of understanding kbuild.  So above should
help.

Yeah, another project to maintain (in kernel if possible?).  I am
willing to try at some of the tests, but my docs skills is no where
good ... :/


Thanks,

--=20
Martin Schlemmer

--=-GlwxzMLhsdgHMRWwdecx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA12ItqburzKaJYLYRAoPDAKCIa74uwauJB9wWpIC7hiy+bZGSQgCfbO7K
2Jd4QRLS6LbpoyrPHmdl6fg=
=QmRt
-----END PGP SIGNATURE-----

--=-GlwxzMLhsdgHMRWwdecx--

