Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWGaGfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWGaGfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWGaGfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:35:46 -0400
Received: from nsm.pl ([195.34.211.229]:22282 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751037AbWGaGfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:35:45 -0400
Date: Mon, 31 Jul 2006 07:56:55 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060731055655.GB7094@irc.pl>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl> <Pine.LNX.4.64.0607301043070.7932@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607301043070.7932@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2006 at 10:45:13AM -0700, Zwane Mwaikambo wrote:
> On Sun, 30 Jul 2006, Tomasz Torcz wrote:
>=20
> > On Sun, Jul 30, 2006 at 02:08:44PM +0200, bert hubert wrote:
> > > Hi everybody,
> > >=20
> > > Since 2.6.18-rc1, up to and including -rc3, cpufreq has died on me. It
> > > worked fine in 2.6.16.9.
> > >=20
> > > # modprobe p4_clockmod
> > > FATAL: Error inserting p4_clockmod
> > > (/lib/modules/2.6.18-rc3/kernel/arch/i386/kernel/cpu/cpufreq/p4-clock=
mod.ko):
> > > Device or resource busy
> > >=20
> >=20
> >   I have similar problem with cpufreq-nforce2 -- http://lkml.org/lkml/2=
006/7/7/234
> >   I haven't do a git-bisect yet.
>=20
> Could you fellows try it without;
>=20
> CONFIG_X86_SPEEDSTEP_CENTRINO
> CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
> CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE
> CONFIG_X86_SPEEDSTEP_ICH
> CONFIG_X86_SPEEDSTEP_SMI

  I had those =3Dn

> CONFIG_X86_ACPI_CPUFREQ

  I had this one =3Dy. After setting =3Dn, cpufreq-nforce2 (=3Dm) works aga=
in.

powernowd: PowerNow Daemon v0.96, (c) 2003-2005 John Clemens
powernowd: Found 1 cpu:  -- 1 thread (or core) per physical cpu
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: No
such file or directory
powernowd:   cpu0: 1228Mhz - 1753Mhz (7 steps)

--=20
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray


--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEzZunThhlKowQALQRAqbFAJ9/u7Dvg7ol8b2W0WzZzINlsB+plACbBuxi
n7iD065NNWvMk4xuQjdXXyo=
=6Tr9
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
