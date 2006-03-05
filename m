Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752094AbWCEHIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbWCEHIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbWCEHIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:08:21 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:22458 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1752094AbWCEHIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:08:21 -0500
Date: Sun, 5 Mar 2006 18:07:13 +1100
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060305070713.GF12510@samad.com.au>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
	Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
	Ingo Molnar <mingo@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <200603011647.34516.ak@suse.de> <20060301180714.GD20092@ti64.telemetry-investments.com> <200603011929.59307.ak@suse.de> <1141240611.5860.176.camel@mindpipe> <20060303191822.GE32407@ti64.telemetry-investments.com> <1141421204.3042.139.camel@mindpipe> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <1141474005.7859.22.camel@lycan.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Content-Disposition: inline
In-Reply-To: <1141474005.7859.22.camel@lycan.lan>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2006 at 02:06:45PM +0200, Martin Schlemmer wrote:
> On Fri, 2006-03-03 at 18:43 -0500, Bill Rugolsky Jr. wrote:
> > On Fri, Mar 03, 2006 at 05:09:57PM -0500, Jeff Garzik wrote:
> > > Or sata_nv/libata is to blame.
> > =20
> > In case you are coming late to the thread:
> >=20
> > The lost ticks are closely correlated with sata_nv disk activity on
> > multiple disks, and the problem is easily reproducable with "find /usr |
> > cpio -o >/dev/null" on an MD RAID1 -- but not on a single disk.
> >=20
> > Andi suggested:
> >=20
> >    Yes, I bet something forgets to turn on interrupts again and it's
> >    picked up by (and blamed on) the next guy who does an unconditional
> >    sti, which happens to be __do_sofitrq or idle.
> >=20
> > That sounds right to me.
> >=20
> > I built 2.6.16-rc5-git6 yesterday, and it still suffers from the same
> > issue.
> >=20
>=20
> Not sure this will help in anyway, but anyhow.

Hi

just to throw my 2c, I have a shuttle sn25p with a amd 2x 4400+, under
normal conditions I don't see any mising tick, but when I hammer the
network and the raid5 lvm I start to see missing ticks and the same
error message mentioned before. I am using debian 2.6.15 amd64


>=20
> I have had this system for about 6-8 months (maybe 10) now.  It was
> originally a Asus A8N-SLI Deluxe with a 3200+ Athlon64.  In November I
> changed to a Asus A8N-SLI Premium, and added another 1GB memory (now
> have 2GB memory).  In all that time I have not had any issues with lost
> ticks, but I was hesitant to get a X2 processor due to the issue that
> some people had.
 snip ..

>=20
> If anything might be of relevance, or you want me to try something, just
> say it.  Same with extra info that might be needed.
>=20
>=20
> Regards,
>=20
> --=20
> Martin Schlemmer
>=20



--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFECo4gkZz88chpJ2MRAugIAKC2++xeArWmLq0k4xHxy8dlYnSQcACYxb0Z
Oa6T2hVMEUvOrdNtGhPQUQ==
=xCsi
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
