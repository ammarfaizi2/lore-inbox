Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWBAWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWBAWgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422986AbWBAWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:36:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422683AbWBAWgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:36:41 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138832179.6632.12.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
	 <1138830694.18762.46.camel@localhost.localdomain>
	 <1138832179.6632.12.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wQIaFlReAFqujQKOIg11"
Date: Wed, 01 Feb 2006 16:36:20 -0600
Message-Id: <1138833380.18762.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wQIaFlReAFqujQKOIg11
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-01 at 17:16 -0500, Steven Rostedt wrote:
>=20
> No, but I don't use an initrd, so my failure was first that it couldn't
> recognize my harddrives.  So I compiled in the necessary drivers into my
> kernel, and it booted right up to the GDM login.  I logged in, and was
> going to reply to you, but I guess I have a different network card since
> I had no network.
>=20

Ok, I took the config file I sent you, globally substituted '=3Dy' for
'=3Dm' and rebuilt, then booted that kernel. Other than a message that it
was unable to open the console (udev wasn't started) I got the exact
same failure (same panic backtrace).

> >=20
> > I'm fairly certain that the initrd contains the appropriate modules,
> > since I regenerate the initrd each time I generate a new kernel, but
> > I'll go back and verify.=20
> >=20
> > I'll also convert modules to compiled in and see if that makes a
> > difference.
>=20
> Thanks, I've been burnt before with incompatible modules in initrd, that
> I now only use compiled in modules that are needed to boot (ide, ext3,
> etc).  When compiling 3 different kernels with several different configs
> constantly for the same machine, it just becomes easier to not use an
> initrd.

One of the things I wanted to see was how the -rt patch worked with
SELinux, so I decided to try and run a kernel that looked like a distro
kernel (in this case FC4).  I just put together some scripting logic to
build the kernel and module tree three times (athlon64, p3smp, and
duron).  After I've rebuilt, I install on each target system using a
shell script that deletes the old module tree, rsyncs a new one,
installs the matching kernel and builds a new initrd.

Hmmm, FC4 is based on 2.6.14.x. Did something change in the 2.6.15
series that needs a user-space change as well? (I'm running a current
FC4 rootfs).

Clark

--=20
Clark Williams <williams@redhat.com>

--=-wQIaFlReAFqujQKOIg11
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4TfkHyuj/+TTEp0RAnwyAKCqCkWuo5Ag7e31NGfIVWG22+Dj5gCeItxY
lXGqp8rgMOCfqQSg5av3vbk=
=3Jw7
-----END PGP SIGNATURE-----

--=-wQIaFlReAFqujQKOIg11--

