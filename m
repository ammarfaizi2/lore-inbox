Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWDBPWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWDBPWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 11:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWDBPWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 11:22:53 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:35341 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932371AbWDBPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 11:22:52 -0400
Date: Sun, 2 Apr 2006 16:22:49 +0100
From: John Mylchreest <johnm@gentoo.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402152249.GD3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <1143983738.2994.18.camel@laptopd505.fenrus.org> <20060402135605.GB3443@getafix.willow.local> <1143989378.2994.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <1143989378.2994.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 04:49:37PM +0200, Arjan van de Ven <arjan@infradead=
=2Eorg> wrote:
> On Sun, 2006-04-02 at 14:56 +0100, John Mylchreest wrote:
> > On Sun, Apr 02, 2006 at 03:15:38PM +0200, Arjan van de Ven <arjan@infra=
dead.org> wrote:
> > >=20
> > > > Going from that, I can push a patch for gcc upstream to remove the
> > > > __KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the sema=
ntics
> > > > between the IBM patch for SSP applied to gcc-3 and ggc-4 have chang=
ed.
> > > >=20
> > > > -fno-stack-protector would work for gcc4, but for gcc3 it could sti=
ll be
> > >=20
> > > since this is a thing you have to turn on to get it, not off to not g=
et
> > > it, I think you're missing something big here ;)
> > >=20
> > > > patially enabled, and requires -fno-stack-protector-all. Mind If I =
ask
> > > > whats incorrect about defining __KERNEL__ for the bootcflags?
> > >=20
> > > it's silly and it's a non-standard gcc ... better get the gcc fixed to
> > > at least have the upstream protocol of having to turn it on not off..
> >=20
> > It gets turned on elsewhere (gcc spec),
>=20
> ehh???
> so you change gcc to force a specific, non-standard option on, and
> something breaks as a result... better get the gcc spec fixed I'd say=20

Yeah, something which I completely disregarded without thinking about
until this thread. Always helps not looking at this at 1am ;)
I always thought the arch/boot code should stay as part of the kernel
build. I'll re-address :)

Cheers for the input.

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--bajzpZikUji1w+G9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL+xJNzVYcyGvtWURApX7AKDLWJGkH3PFxg1X/amUf4ggF05GGACg3Lzr
FjC+pfjvm1P5ycdxbwpgM8Y=
=3tK+
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
