Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFBURZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFBURZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFBULP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:11:15 -0400
Received: from lugor.de ([217.160.170.124]:5513 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S261291AbVFBUDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:03:48 -0400
From: Christian Hesse <mail@earthworm.de>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Date: Thu, 2 Jun 2005 22:03:18 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com>
In-Reply-To: <20050602174219.GC21363@atomide.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)k
	:nv*xqk4C@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)n#Q.o
	kE~&T]0cQX6]<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<3O7GY9y_i!qG&Vv\D8/
	%4@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1686080.EzRXDXc3AO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506022203.27734.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1686080.EzRXDXc3AO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 June 2005 19:42, Tony Lindgren wrote:
> * Christian Hesse <mail@earthworm.de> [050602 01:31]:
> > On Thursday 02 June 2005 03:36, Tony Lindgren wrote:
> > > Hi all,
> > >
> > > Here's an updated version of the dynamic tick patch.
> > >
> > > It's mostly clean-up and it's now using the standard
> > > monotonic_clock() functions as suggested by John Stultz.
> > >
> > > Please let me know of any issues with the patch. I'll continue to do
> > > more clean-up on it, but I think the basic functionality is done.
> >
> > I would like to test it, but have some trouble. The patch applies clean=
ly
> > and everything compiles fine, but linking fails:
> >
> > [ linker errors ]
>
> Should be fixed now, the header was defining it as a function un UP
> system with no local apic. Can you try the following version?

This one compiles and links without problems.

The reason I want to use this patch is that I hear a high pitched noise [1]=
=20
when running with 1000Hz and the processor is idle. With this patch I could=
=20
use 1000Hz without any noise.

But I found some problems on my system:

=2D time does not run the correct speed, it was some minutes in future afte=
r I=20
had compiled a new kernel

=2D pressing a key on the keyboard sometimes results in two or more charact=
ers,=20
not only one

=2D mouse misses some events, e.g. clicks are not recognized (synaptics=20
touchpad)

=2D using software suspend 2.1.8.10 I can suspend the system, but it hangs =
while=20
resuming

Anyway, thanks for your great work! Let me know if you have new versions to=
=20
test.

[1] http://bugme.osdl.org/show_bug.cgi?id=3D2478

=2D-=20
Christian

--nextPart1686080.EzRXDXc3AO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCn2YPlZfG2c8gdSURAlM5AKC62B2xT3q950Lm8kCXCCynZiWIowCeJcH8
RsDwvEq7U0B9+KQl1mxs26k=
=wdm9
-----END PGP SIGNATURE-----

--nextPart1686080.EzRXDXc3AO--
