Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUCGOBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 09:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUCGOBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 09:01:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261989AbUCGOBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 09:01:42 -0500
Subject: Re: External kernel modules, second try
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
In-Reply-To: <1078667199.3594.50.camel@nb.suse.de>
References: <1078620297.3156.139.camel@nb.suse.de>
	 <20040307125348.GA2020@mars.ravnborg.org>
	 <1078664629.9812.1.camel@laptop.fenrus.com>
	 <1078667199.3594.50.camel@nb.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nlECVGRy5eJJpYbUAwEN"
Organization: Red Hat, Inc.
Message-Id: <1078668091.9106.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 07 Mar 2004 15:01:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nlECVGRy5eJJpYbUAwEN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-07 at 14:46, Andreas Gruenbacher wrote:
> Hello Arjan,
>=20
> On Sun, 2004-03-07 at 14:03, Arjan van de Ven wrote:
> > >=20
> > > Could you explain what is the actually gain of using the
> > > modversions file your patch creates. (modpost changes)
> >=20
> > distributions don't like to install the vmlinux since it's big(ish) and
> > means customers need to download a new vmlinux at each kernel erratum.
> > The same information is btw also present in System.map so imo the real
> > solution is to make modpost use System.map instead ;)
>=20
> System.map doesn't have the hashes,

are you sure ? I could have sworn it had.

>  and it's missing the symbols from
> module files.

sure but the module files are generally installed...


> Now it would be possible to extract the modver symbols from the
> installed vmlinux and .ko files when needed, but note that we may be
> building modules for kernels that are not currently running, and for
> which those binaries are not even installed. So this sounds like a bad
> idea.

I don't personally care about those; you need SOME stuff to build
against obviously, and vmlinux is well over the top I agree that. But
assuming the .ko's for the modules are there...you need those to use the
kernel anyway.

--=-nlECVGRy5eJJpYbUAwEN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBASys5xULwo51rQBIRAtwQAKCBcps1luMVXmSQ1QC9DcK/t3XvzgCfRqPy
0afnttQVk8pHk3xR173+mQc=
=sB5d
-----END PGP SIGNATURE-----

--=-nlECVGRy5eJJpYbUAwEN--

