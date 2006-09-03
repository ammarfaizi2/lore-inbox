Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWICDMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWICDMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 23:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWICDMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 23:12:53 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:54939 "EHLO
	pan.var.cx") by vger.kernel.org with ESMTP id S1751957AbWICDMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 23:12:53 -0400
Date: Sun, 3 Sep 2006 05:13:03 +0200
From: Frank v Waveren <fvw@var.cx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-ID: <20060903031303.GA26881@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain> <20060831204612.73ed7f33.akpm@osdl.org> <20060902110445.GC3335@var.cx> <1157222679.29250.386.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1157222679.29250.386.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2006 at 08:44:39PM +0200, Thomas Gleixner wrote:
> On Sat, 2006-09-02 at 13:04 +0200, Frank v Waveren wrote:
> > Here's a different patch, which should actually sleep for the
> > specified amount of time up to 2^64 seconds with a loop around the
> > sleeps and a tally of how long is left to sleep. It does mean we wake
> > up once every 300 years on long sleeps, but that shouldn't cause any
> > huge performance problems.
>
> Which non academic problem is solved by this patch ?
Compared to a current linus kernel, it fixes the overflow problem.
Compared to the current mm (good job on finding the sneaky bug in that
one by the way) it doesn't fix anything additional, but still fixes
all of the same things plus the academic problems. And it makes the
GNU coreutils people happy, which is rarely a bad thing.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE+kg/+gB9UUaNYsgRAsU1AJ0VsGX0Nsyz6l5MZxMiKFihI7mqjACePlWa
TK3EH8bZRMjcttaSkD6Ezhs=
=s0p1
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

-- 
VGER BF report: H 0.000448983
