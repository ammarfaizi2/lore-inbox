Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWCDMDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWCDMDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWCDMDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:03:09 -0500
Received: from ctb-mesg4.saix.net ([196.25.240.74]:1466 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S1751489AbWCDMDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:03:07 -0500
Subject: Re: AMD64 X2 lost ticks on PM timer
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060303234330.GA14401@ti64.telemetry-investments.com>
References: <200602280022.40769.darkray@ic3man.com>
	 <200603011647.34516.ak@suse.de>
	 <20060301180714.GD20092@ti64.telemetry-investments.com>
	 <200603011929.59307.ak@suse.de> <1141240611.5860.176.camel@mindpipe>
	 <20060303191822.GE32407@ti64.telemetry-investments.com>
	 <1141421204.3042.139.camel@mindpipe> <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ovVpPxM5W9GqQwejp+am"
Date: Sat, 04 Mar 2006 14:06:45 +0200
Message-Id: <1141474005.7859.22.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ovVpPxM5W9GqQwejp+am
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-03 at 18:43 -0500, Bill Rugolsky Jr. wrote:
> On Fri, Mar 03, 2006 at 05:09:57PM -0500, Jeff Garzik wrote:
> > Or sata_nv/libata is to blame.
> =20
> In case you are coming late to the thread:
>=20
> The lost ticks are closely correlated with sata_nv disk activity on
> multiple disks, and the problem is easily reproducable with "find /usr |
> cpio -o >/dev/null" on an MD RAID1 -- but not on a single disk.
>=20
> Andi suggested:
>=20
>    Yes, I bet something forgets to turn on interrupts again and it's
>    picked up by (and blamed on) the next guy who does an unconditional
>    sti, which happens to be __do_sofitrq or idle.
>=20
> That sounds right to me.
>=20
> I built 2.6.16-rc5-git6 yesterday, and it still suffers from the same
> issue.
>=20

Not sure this will help in anyway, but anyhow.

I have had this system for about 6-8 months (maybe 10) now.  It was
originally a Asus A8N-SLI Deluxe with a 3200+ Athlon64.  In November I
changed to a Asus A8N-SLI Premium, and added another 1GB memory (now
have 2GB memory).  In all that time I have not had any issues with lost
ticks, but I was hesitant to get a X2 processor due to the issue that
some people had.

Beginning February I got an Athlon64 X2 3800+ processor, and since that
time I have also had no issues with lost ticks.  I usually run latest
git kernel +/- a week.  No extra patches, except I started using Alan's
libata PATA stuff a week or so back as well.

Only difference I can see that might be of consequence, is:

1) Board type?  Not sure if anybody with an A8N-SLI had any lost tick
issues ?

2) I do not use MD RAID1, but have 2 ST380013AS striped with
device-mapper's stripe module.

3) If I remember correctly, then I have the 2 hdd's on nv_sata ports 3
and 4, with ports 1 and 2 disabled, else they show up as sdc and sdd.
Not sure if its an A8N-SLI only peculiarity, and not 100% sure of the
port order - I can check if it might be an issue?

4) I do not use the NV lan adapter, as I had issues back when I got the
system, but rather the extra Marvell controller (skge module).  I think
it picked up fine, etc, but it lost connection after a minute or two.

5) I run the processor at 240FSB (or HT or whatever) with the memory at
333 (166 on some boards) multiplier (ending up at running 200Mhz
anyhow).  Not sure if this might make any difference, but just listing
it in case.

6) Haven't checked if this makes any difference, but the board have an
option for ACPI 2.0 support, which I have enabled.

If anything might be of relevance, or you want me to try something, just
say it.  Same with extra info that might be needed.


Regards,

--=20
Martin Schlemmer


--=-ovVpPxM5W9GqQwejp+am
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBECYLVqburzKaJYLYRAgcqAJ496Oh4b5nWYkWheU/s1l3sTM1z9QCggLCV
KLg562+kvykfXrxl1ai/kMI=
=z3kj
-----END PGP SIGNATURE-----

--=-ovVpPxM5W9GqQwejp+am--

