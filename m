Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVA0Lte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVA0Lte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVA0Lte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:49:34 -0500
Received: from dea.vocord.ru ([217.67.177.50]:26051 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262585AbVA0Lt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:49:27 -0500
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: dtor_core@ameritech.net, Christoph Hellwig <hch@infradead.org>,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050127102008.GB28047@stusta.de>
References: <20050125195918.460f2b10.khali@linux-fr.org>
	 <20050126003927.189640d4@zanzibar.2ka.mipt.ru>
	 <20050125224051.190b5ff9.khali@linux-fr.org>
	 <20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
	 <20050126101434.GA7897@infradead.org> <1106737157.5257.139.camel@uganda>
	 <d120d5000501260600fb8589e@mail.gmail.com>
	 <1106757528.5257.221.camel@uganda> <20050126181941.GC5297@stusta.de>
	 <20050126222743.1e0a29ff@zanzibar.2ka.mipt.ru>
	 <20050127102008.GB28047@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-odKtNxIRLfRwjRsooNaP"
Organization: MIPT
Date: Thu, 27 Jan 2005 14:53:33 +0300
Message-Id: <1106826813.5257.286.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 27 Jan 2005 11:47:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-odKtNxIRLfRwjRsooNaP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-27 at 11:20 +0100, Adrian Bunk wrote:
> On Wed, Jan 26, 2005 at 10:27:43PM +0300, Evgeniy Polyakov wrote:
> >...
> > I greatly appreciate your comments, and they were addressed.
> > Part of exported symbols are unexported, patch is just waiting to be se=
nt,
>=20
> Ah, sorry. I only saw that the patch I sent two months ago still=20
> applies completely (except for an unrelated context change).

Patch is alredy sent, but probably it will not apper in the nearest -mm
release.

> > but I do not agree with dscore rename. I just do not understand it's ad=
vantage.
>=20
> It is only a small cosmetic thing:
> If there's only one object file in a module, a renaming in the Makefile=20
> is superfluous - you can simply rename the source file

Most of it's exports are preparation for EEPROM driver, which will
require
some changes in w1 core(it needs to export additional callbacks).

I'm currently review DS device set to find any dependency upon ds2490
chip -=20
but it looks like there is no one, so it is alredy not core, but device
driver
itlself.

I'm not too religious about it's name...

> cu
> Adrian
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-odKtNxIRLfRwjRsooNaP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB+NY9IKTPhE+8wY0RApYYAKCJGevZVg0rdL/7okIF3KIa1drx6wCgiGXd
4+rmwzLpPfvMjrImYmy0DHk=
=zWBh
-----END PGP SIGNATURE-----

--=-odKtNxIRLfRwjRsooNaP--

