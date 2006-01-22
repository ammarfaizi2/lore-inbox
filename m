Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWAVXjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWAVXjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 18:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWAVXjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 18:39:43 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:32950 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S964788AbWAVXjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 18:39:42 -0500
Date: Mon, 23 Jan 2006 01:39:38 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       George Anzinger <george@mvista.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] Time: Generic Timeofday Subsystem (v B17)
Message-ID: <20060122233938.GA31392@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	George Anzinger <george@mvista.com>, Ingo Molnar <mingo@elte.hu>
References: <1137801626.27699.279.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <1137801626.27699.279.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 04:00:26PM -0800, john stultz wrote:
> The patchset applies against the current 2.6.16-rc1-git.
>=20
> The complete patchset can be found here:
> 	http://sr71.net/~jstultz/tod/
>=20
> As always, feedback, suggestions and bug-reports are always appreciated.
>=20
Patches weren't explicitly mentioned, but I'm assuming they're also
welcome ;-)

At first glance the register/unregister interface is a bit
unconventional, but I have a few trivial patches to get those fixed up,
which I'll send to you separately.

It looks like struct clocksource will also need suspend/resume ops,
since it's defining its own sysclass (so there's no overlap with the
timer sysclass that several other architectures setup to deal with this).
I haven't done that yet, but if there's interest, I'll hack something up.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD1Be61K+teJFxZ9wRAh1fAJ0eVe83TRJuRkhaDwLZfbbL05PEKACfaMdb
jvlss0OYfK9tLGWwIJJ4YKw=
=axwm
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
