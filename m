Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUAFKgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 05:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUAFKgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 05:36:45 -0500
Received: from coffee.creativecontingencies.com ([210.8.121.66]:45522 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S261827AbUAFKgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 05:36:43 -0500
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
From: Peter Lieverdink <peter@cc.com.au>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
References: <1067411342.1574.11.camel@localhost>
	 <20031109131018.GA18342@deneb.enyo.de> <bop47i$7eg$1@gatekeeper.tmr.com>
	 <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L+1P1VneeaAPCSm+ee4S"
Message-Id: <1073385390.1110.2.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 21:36:31 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L+1P1VneeaAPCSm+ee4S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-11-11 at 10:27, Peter Lieverdink wrote:
> At 09:41 11/11/2003, you wrote:
> >In article <20031109131018.GA18342@deneb.enyo.de>,
> >Florian Weimer  <fw@deneb.enyo.de> wrote:
> >| Soeren Sonnenburg wrote:
> >|
> >| > losetup -e blowfish /dev/loop0 /file
> >| > Password:
> >| > mkfs -t ext3 /dev/loop0
> >| > mount /dev/loop0 /mnt
> >| > <error unknown fs type>
> >| > <from here something was seriously broken... could not reboot anymor=
e>
> >|
> >| I'm seeing something similar, but in my case, mke2fs already crashes.
> >|
> >| > system is:
> >| > Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux
> >|
> >| Mine ist -test9 on x86.
> >|
> >| Have you found a solution in the meantime?
> >
> >I have been using aes and not seeing this. I suppose it's unlikely that
> >there could be an error in the kernel crypto, but I think I'll wait and
> >try blowfish on a non-critical machine.
>=20
> My solution has been to not use cryptofs, it crashes with whatever=20
> algorithm I choose :-(

I've been using 'highmem=3Doff' until now, which provided a workaround.
Just built 2.6.1-rc1-mm2 and cryptloop+highmem works as it should now.

- peter.

--=-L+1P1VneeaAPCSm+ee4S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+o+tf34AjKyA6C4RAvnBAKCJ0UQChxhnis3T0VtBclDtCV3KWgCg42vc
Dpc1bcBtKWKiVeB3y+Qoh2Q=
=Sipj
-----END PGP SIGNATURE-----

--=-L+1P1VneeaAPCSm+ee4S--

