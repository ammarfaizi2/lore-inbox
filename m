Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUCQKRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUCQKQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:16:59 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:52112 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261262AbUCQKQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:16:53 -0500
Date: Wed, 17 Mar 2004 10:50:33 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Karol Kozimor <sziwan@hell.org.pl>, dtor_core@ameritech.net,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040317095033.GA14983@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	Karol Kozimor <sziwan@hell.org.pl>, dtor_core@ameritech.net,
	acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it> <20040316214239.GA28289@hell.org.pl> <1079479694.5408.47.camel@cog.beaverton.ibm.com> <20040316233334.GA9001@dominikbrodowski.de> <1079484413.5408.56.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <1079484413.5408.56.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 04:46:54PM -0800, john stultz wrote:
> On Tue, 2004-03-16 at 15:33, Dominik Brodowski wrote:
> > On Tue, Mar 16, 2004 at 03:28:15PM -0800, john stultz wrote:
> > > On Tue, 2004-03-16 at 13:42, Karol Kozimor wrote:
> > > > Thus wrote Daniele Venzano:
> > > > > > I have a notebook with an Athlon-M CPU. I tried linux 2.6.4 with
> > > > > > CONFIG_X86_PM_TIMER=3Dy and I noticed that /proc/cpuinfo doesn'=
t get
> > > > > > updated when I switch frequency (via sysfs, using powernow-k7).=
 The is
> > > > > > issue seems cosmetic only, CPU frequency changes (watching
> > > > > > temperature/battery life).
> > > > > I can confirm, I'm seeing the same behavior. Please note that the
> > > > > bogomips count gets updated, it's only the frequency that doesn't
> > > > > change.
> > > >=20
> > > > Same here with a P4-M, follow-up to John and Dmitry.
> > >=20
> > > Hmm. This is untested, but I think this should do the trick.
> > >=20
> > > Dominik: Is there any reason I'm not seeing why cpu_khz should only be
> > > updated when using the TSC?
> >=20
> > Is cpu_khz always correct (or, at least, nonzero) when we're reaching t=
his=20
> > code path?
>=20
> Using the PIT time source, cpu_khz is zero, so maybe it should be
> conditional on if(cpu_khz)?

That will do the trick.

	Dominik

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWB9pZ8MDCHJbN8YRAoYwAJ0fYSwtFb3xz9e9ooInzKCd6QZf+ACeIrE6
UiEqGWst9mPrid/HjNQBsmk=
=00nJ
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
