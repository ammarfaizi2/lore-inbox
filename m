Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbUDOVFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUDOVFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:05:25 -0400
Received: from legolas.restena.lu ([158.64.1.34]:51389 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263358AbUDOVFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:05:05 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Len Brown <len.brown@intel.com>
Cc: ross@datscreative.com.au, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
       Jesse Allen <the3dfxdude@hotmail.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <1082060255.24425.180.camel@dhcppc4>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dWascNq7f9lE0DjSxdN5"
Message-Id: <1082063090.4814.20.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Apr 2004 23:04:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dWascNq7f9lE0DjSxdN5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-15 at 22:17, Len Brown wrote:
> On Thu, 2004-04-15 at 11:10, Ross Dickson wrote:
> > On Wednesday 14 April 2004 11:02, Len Brown wrote:
> > > Re: IRQ0 XT-PIC timer issue
> > >=20
> > > Since the hardware is connected to APIC pin0, it is a BIOS bug
> > > that an ACPI interrupt source override from pin2 to IRQ0 exists.
> > >=20
> > > With this simple 2.6.5 patch you can specify "acpi_skip_timer_overrid=
e"
> > > to ignore that bogus BIOS directive.  The result is with your
> > > ACPI-enabled APIC-enabled kernel, you'll get IRQ0 IO-APIC-edge timer.
> > >=20
> > > Probably there is a more clever way to trigger this workaround
> > > automatcially instead of via boot parameter.
>=20
> > Hi Len, I have updated my nforce2 patches for 2.6.5 to work with your p=
atch.
> > I have tested them only on one nforce2 board Epox 8Rga+ but as little h=
as
> > changed in core functionality from past releases I think all will be OK=
....
> > Hopefully no clock skew. I saw none on my system but thats no guarantee=
.
>=20
> While I don't want to get into the business of maintaining
> a dmi_scan entry for every system with this issue, I think
> it might be a good idea to add a couple of example entries
> for high volume systems for which there is no BIOS fix available.
>=20
> Got any opinions on which system to use as the example?
> I'll need the output from dmidecode for them.

I have an A7N8X Deluxe v2 BIOS v1007 that I can give u whatever numbers
u need. IOAPIC and APIC are on.

Its running gentoo-dev-sources 2.6.3-r1 plus the idlec1halt patch and
nmi patch from Ross. I guess the kernel doesnt matter too much if its
just board details.=20

More details of my 2.6.1 days are at=20
http://atlas.et.tudelft.nl/verwei90/nforce2/

Craig


> > I tried your above patch with the timer_ack on as is default in 2.6.5 a=
nd
> > nmi_watchdog=3D1 failed as expected. I still think Maciej's 8259 ack pa=
tch=20
> > is more complete solution to the ack issue but this one gets watchdog g=
oing for
> > nforce2. I cannot see anyone using your above patch without an integrat=
ed
> > apic and tsc so I cannot see a problem triggering it off your kern arg.
>=20
> "acpi_skip_timer_override" is specific to IOAPIC mode,
> since that is the only place that the bogus interrupt
> source override is used.
>=20
> I'm not clued-in on the nmi_watchdog and 8259 ack issues.
> My focus is primarily the ACPI issues involved in getting
> these systems up and running in IOAPIC mode.
>=20
> > The second patch is the C1halt update I suggested in another posting.
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/1707.html
>=20
> Clearly this hang issue is more important than the timer issue.
> I'm impressed that you built such a sophisticated patch without
> any support from the vendors.  But it would be a "really good thing"
> if we got some input from the vendors before considering putting
> a workaround into the upstream kernel -- for they may have
> guidance which would either simplify it, or make it unnecessary.
> Perhaps Allen Martin at nVidia can comment?
>=20
> -Len
>=20
>=20
>=20

--=-dWascNq7f9lE0DjSxdN5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAfvjyi+pIEYrr7mQRAtCCAJ4x7eM90ML+9jD7z9+22300vJMkoACfRPM7
c9YabiSjE4WV0N3U+PZ6Gek=
=6CHk
-----END PGP SIGNATURE-----

--=-dWascNq7f9lE0DjSxdN5--

