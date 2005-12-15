Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVLOXpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVLOXpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVLOXpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:45:43 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:27877 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751143AbVLOXpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:45:43 -0500
Date: Fri, 16 Dec 2005 10:45:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Dike <jdike@addtoit.com>
Cc: tony.luck@intel.com, dhowells@redhat.com, akpm@osdl.org, lkml@rtr.ca,
       tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, pj@sgi.com, mingo@elte.hu,
       hch@infradead.org, torvalds@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051216104508.40f2281f.sfr@canb.auug.org.au>
In-Reply-To: <20051215203818.GA11487@ccure.user-mode-linux.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
	<20051215203818.GA11487@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__16_Dec_2005_10_45_08_+1100_+EYlZj8dVwFJjKEj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__16_Dec_2005_10_45_08_+1100_+EYlZj8dVwFJjKEj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Dec 2005 15:38:18 -0500 Jeff Dike <jdike@addtoit.com> wrote:
>
> On Thu, Dec 15, 2005 at 09:45:10AM -0800, Luck, Tony wrote:
> > There was a USENIX paper a couple of decades ago that described how
> > to do a fast s/w disable of interrupts on machines where really disabli=
ng
> > interrupts was expensive.  The rough gist was that the spl[1-7]()
> > functions would just set a flag in memory to hold the desired interrupt
> > mask.  If an interrupt actually occurred when it was s/w blocked, the
> > handler would set a pending flag, and just rfi with interrupts disabled.
> > Then the splx() code checked to see whether there was a pending interru=
pt
> > and dealt with it if there was.
>=20
> ... and this is currently implemented (but not yet merged to mainline) in
> UML.

And, of course, this is the way the PowerPC iSeries has always worked becau=
se
we are not allowed to disable hardware interrupts for long periods of time =
or
the hypervisor will consider that our logical partition is dead.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__16_Dec_2005_10_45_08_+1100_+EYlZj8dVwFJjKEj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDogAJFdBgD/zoJvwRArRWAJ0bPwkMQYITF4mMPa03bCV1YqfzFwCfZMC6
zyIod/e5yGhzpZr8LRlXboM=
=MJ3A
-----END PGP SIGNATURE-----

--Signature=_Fri__16_Dec_2005_10_45_08_+1100_+EYlZj8dVwFJjKEj--
