Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUBRIhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 03:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBRIhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 03:37:04 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:45815 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263596AbUBRIhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 03:37:00 -0500
Date: Tue, 17 Feb 2004 10:09:39 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: 2.6.2: P4 ClockMod speed
Message-ID: <20040217090939.GA9935@dominikbrodowski.de>
Mail-Followup-To: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>,
	linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
References: <20040216213435.GA9680@dominikbrodowski.de> <40313AA9.1060906@arenanetwork.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <40313AA9.1060906@arenanetwork.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2004 at 09:48:25PM +0000, dual_bereta_r0x wrote:
> >>locked on cpu *real* speed.
> >
> >
> >It's just a change of appearance -- the cpufreq driver uses the theoreti=
cal
> >speed of the CPU for its calculations; the actual CPU speed isn't
> >affected. You can verify this by looking at /proc/cpuinfo which still te=
lls
> >3124.376 MHz.
> >
> >By doing so it becomes easier to enter different frequencies e.g. into
> >/sys/devices/system/cpu/cpufreq/scaling_setspeed -- on my desktop, typin=
g=20
> >in
> >1200000 is easier than 12121224... [*]
>=20
> Sure but if i want to downgrade it, for example, by night, to a lower=20
> speed, and then next day return it to full power? Will I stuck at 2.4GHz?

No, it will run at the same speed as before -- the ratio between actual
cpu_khz and cpufreq/scaling_setspeed will always be the same.

> >[*] The _actual_ CPU speed should be used on all cpufreq drivers where t=
his
> >specific CPU frequency has implications to external components, e.g. LCD,
> >memory or pcmcia devices. Where only the _frequency ratio_ is of importa=
nce
> >[for loops_per_jiffy and friends] such "rounding" is acceptable, as long=
 as
> >the ratio is constant.
>=20
> Indeed. I'll showing in LCD a lower speed than the running.

That's not the point: some hardware (e.g. ARM) needs different memory
settings and different settings of the LCD controller  for different=20
CPU frequencies, as the Front Side Bus of the CPU is closely related=20
to the CPU frequency. On x86, all cpufreq techniques I've
seen so far do not modify the FSB [*], so memory settings etc. do not need
to be modified.

	Dominik

[*] or scaling the FSB didn't work...

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAMdpTZ8MDCHJbN8YRAlUUAKCZGP6jqj6zBOVs74bpagAoqDU7cQCfSSoi
OWNYLud2rchO1xKFuHNBi0o=
=IjVx
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
