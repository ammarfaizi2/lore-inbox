Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUCRJGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUCRJGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:06:04 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:20677 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262122AbUCRJF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:05:58 -0500
Date: Thu, 18 Mar 2004 10:05:22 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Kenneth Chen <kenneth.w.chen@intel.com>,
       linux-ia64@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       CPU Freq ML <cpufreq@www.linux.org.uk>
Subject: Re: add lowpower_idle sysctl
Message-ID: <20040318090522.GC15526@dominikbrodowski.de>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrew Morton <akpm@osdl.org>,
	Kenneth Chen <kenneth.w.chen@intel.com>, linux-ia64@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	CPU Freq ML <cpufreq@www.linux.org.uk>
References: <20040317170436.430acfbe.akpm@osdl.org> <200403180318.i2I3IDF03166@unix-os.sc.intel.com> <20040317192821.1fe90f24.akpm@osdl.org> <Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2004 at 10:40:31PM -0500, Zwane Mwaikambo wrote:
> On Wed, 17 Mar 2004, Andrew Morton wrote:
>=20
> > "Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
> > >
> > >  > > Logically it means a sysctl entry in /proc/sys/kernel.
> > >  > Yes, but the *meanings* of the different values of that sysctl need
> > >  > to be defined, and documented.  If lowpower_idle=3D42 has a totally
> > >  > different meaning on different architectures then that's unfortuna=
te
> > >  > but understandable.  But we should at least enumerate the different
> > >  > values and try to get different architectures to honour `42' in the
> > >  > same way.
> > >
> > >  Writing to sysctl should be a bool, reading the value can be number =
of
> > >  module currently disabled low power idle.  I think the original inte=
nt
> > >  is to use ref count for enabling/disabling.  (granted, we copied the
> > >  code from other arch).

I assume ia64 does idling using the ACPI processor.c driver? If so, couldn't
writing to /proc/acpi/processor/./power be an option?

> > OK, so why not give us:
> >
> > #define IDLE_HALT			0
> > #define IDLE_POLL			1
> > #define IDLE_SUPER_LOW_POWER_HALT	2
> >
> > and so forth (are there any others?).
> >
> > Set some system-wide integer via a sysctl and let the particular
> > architecture decide how best to implement the currently-selected idle m=
ode?
>=20
> I'm wondering whether the setting of these magic numbers can't be done
> using cpufreq infrastructure.

I doubt it -- there's no ia64 cpufreq driver anyway, and cpufreq is about
frequency scaling and (sometimes) throttling, but not "idling". And
"idling" is a too different implementation anyways.

	Dominik

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWWZSZ8MDCHJbN8YRAlz4AJ0ZeCCzoZldEp69vQVzq+NnvMTQDACffTW9
TReGbG5yQcVHeBhXV2c5kHY=
=YaTB
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
