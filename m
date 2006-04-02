Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWDBN4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWDBN4K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 09:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWDBN4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 09:56:10 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:26889 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932342AbWDBN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 09:56:09 -0400
Date: Sun, 2 Apr 2006 14:56:05 +0100
From: John Mylchreest <johnm@gentoo.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402135605.GB3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <1143983738.2994.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <1143983738.2994.18.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 03:15:38PM +0200, Arjan van de Ven <arjan@infradead=
=2Eorg> wrote:
>=20
> > Going from that, I can push a patch for gcc upstream to remove the
> > __KERNEL__ dep, but gcc4.1 ships with ssp by standard, and the semantics
> > between the IBM patch for SSP applied to gcc-3 and ggc-4 have changed.
> >=20
> > -fno-stack-protector would work for gcc4, but for gcc3 it could still be
>=20
> since this is a thing you have to turn on to get it, not off to not get
> it, I think you're missing something big here ;)
>=20
> > patially enabled, and requires -fno-stack-protector-all. Mind If I ask
> > whats incorrect about defining __KERNEL__ for the bootcflags?
>=20
> it's silly and it's a non-standard gcc ... better get the gcc fixed to
> at least have the upstream protocol of having to turn it on not off..

It gets turned on elsewhere (gcc spec), but principle for me is that if its
enabled it still leaks and breaks this code. At the moment (following
=66rom existing patches you put to this list) this mix will break until we
get stack-protector ported.

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL9f1NzVYcyGvtWURAqRtAJ9Z7/Cfv69tKM+RrHO31J1+iTx0kQCeO5Fl
yklo3qjsM89FFYZYA/uQ0js=
=baRp
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
