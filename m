Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSHNMpu>; Wed, 14 Aug 2002 08:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSHNMpu>; Wed, 14 Aug 2002 08:45:50 -0400
Received: from grendel.firewall.com ([66.28.56.41]:50890 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S317611AbSHNMpt>; Wed, 14 Aug 2002 08:45:49 -0400
Date: Wed, 14 Aug 2002 14:49:40 +0200
To: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GA-7DX+ crashes
Message-ID: <20020814124940.GB1824@thanes.org>
References: <Pine.LNX.4.44.0208141239380.1472-100000@r2-pc.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208141239380.1472-100000@r2-pc.dcs.qmul.ac.uk>
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
From: grendel@thanes.org (Grendel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2002 at 01:12:43PM +0100, Matt Bernstein scribbled:
> Hi,
>=20
> We're very much at a loss as to why the 60 new PCs we've bought largely
> don't run Linux (various 2.4 kernels including 2.4.19, limbo1-BOOT) for
[snip]
> Has anyone else had success or failure stories in particular with this=20
> motherboard? We don't really have a significant number of data points jus=
t=20
> yet, but are willing to try pretty much anything anyone might suggest!
>=20
> Matt
>=20
> symptoms
> - random data corruption (sometimes memory, more often HDD)
> - somtimes oopsing, but never in the same place
>=20
> what we think we've ascertained so far
> - they pass memtest86
> - we've tried different HDDs, no effect
> - tried ide=3Dnodma, possibly makes it crash after longer
> - tried noapic, no effect
> - tried all sorts of BIOS settings, no effect (except--possibly--turning=
=20
> 	off the on board IDE controller and playing nfsroot games)
> - ..and yet they seem to run that other OS fine :-(
> - extra cooling/underclocking doesn't seem to help
> - seems to be fs-independent (tried ext3, reiserfs, jfs)
I've had very similar (actually identical) problems with the ASUS A7V333
mobo. The mobo is completely VIA-based (both north and south) but the
southbridge seems to be much the same. What I did to make the machine run
stable was to - turn the USB2 support off (by hardware, a solder point on
the mobo) and short the solder point which is responsible for the CPU
functional settings data readout (the ROMSIP setting) to read the data from
a BIOS table instead of from the CPU itself. That seemed to have been enough
for me - now the mobo is stable (I'm gonna get rid of it, though...).

Another thing you might check is the CPU voltage - make sure it is the
standard 3.3 and not 3.5 as some manufacturers set it.

hope that helps a bit,

marek

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9WlHjq3909GIf5uoRAu7rAJ9zQ4nEpA22um1r5uR4YO3JoDt58wCfYM9L
7tQuJ9cDOMOuXpf8wOrWuEY=
=DhJi
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
