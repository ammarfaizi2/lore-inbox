Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbTEOPdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTEOPdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:33:32 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:10624 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id S264086AbTEOPda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:33:30 -0400
Date: Thu, 15 May 2003 10:45:47 -0500
From: Bob McElrath <bob+debian-alpha@mcelrath.org>
To: mcompengr@earthlink.net
Cc: debian-alpha@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: alpha kernel memory leak
Message-ID: <20030515154546.GA19041@mcelrath.org>
References: <20030513151300.GB26879@mcelrath.org> <3EC374D0.53602A1@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <3EC374D0.53602A1@earthlink.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

mcompengr@earthlink.net [mcompengr@earthlink.net] wrote:
>=20
> (Please correct me where I'm wrong.)
>=20
> Generally, a memory leak is where an often called piece of code
> dynamically allocates itself some memory for temporary usage, and
> then fails to release that memory before being called again.
>=20
> This situation might be indicated by running out of swap space, at
> which point the machine should grind to a halt (all processes), but
> the memory usage reflected by the "top" or "free" commands won't show
> it.  Swap space should be twice the size of physical memory.

The machine does, in fact grind to a halt.  When I first boot the memory
usage is ~250MB and I have no problems using or starting any program.

After a few days the memory usage is ~500MB and I cannot start programs
(they are killed immediatly with OOM).  Note that in both cases the SAME
programs are running.  Just sitting here and watching 'top' shortly
after bootup, the memory usage goes up by ~2k/s.  This is with the
network down, so the machine should be quiescent and hopefully no memory
allocations taking place.  I just checked again with all services
stopped and the network down, at the console (no X), only init, tcsh and
my little perl memory logging script running.  It still leaks by 1.8k/s,
according to my calculations.

If I turn swap back on, most operations cause a massive amount of
swapping (switching desktops in X).

Are there any tools to examine how memory is being used, that report
sensible numbers?  As I mentioned 'ps' no longer reports any memory
numbers (procps 3.1.8, debian unstable).  And using top, the sum of VIRT
is never equal to 'used'.  If there is a memory leak, how do I determine
that definitively?

Cheers,
Bob McElrath [Univ. of Wisconsin at Madison, Department of Physics]

    "You measure democracy by the freedom it gives its dissidents, not the
    freedom it gives its assimilated conformists." -- Abbie Hoffman


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w7YqjwioWRGe9K0RAufZAKCA38mFJjUsKI5egXXYx3xBzxp2EgCcCvbT
LlTUdZuTXxnkZrIdIuCEDzM=
=vD0y
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
