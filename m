Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264661AbUEENXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264661AbUEENXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUEENXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:23:42 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:29668 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264661AbUEENXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:23:37 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>
In-Reply-To: <200405052312.44623.ross@datscreative.com.au>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
	 <200405052214.38855.ross@datscreative.com.au>
	 <1083760029.2797.33.camel@big>
	 <200405052312.44623.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gi25+E+sqWhzw6oGOvxW"
Message-Id: <1083763411.2797.54.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 15:23:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gi25+E+sqWhzw6oGOvxW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-05 at 15:12, Ross Dickson wrote:
> On Wednesday 05 May 2004 22:27, Ian Kumlien wrote:
> > On Wed, 2004-05-05 at 14:14, Ross Dickson wrote:
> > > To my knowledge the only thing left to sort out for the normal kernel
> > > distro is what to do about the timer_ack issue in check_timer().
> > >=20
> > > We need it off for nforce2 to get nmi_watchdog=3D1 working with ioapi=
c
> > > 8254 timer pin0  timer override patch routing. I vote to revisit Maci=
ej's
> > > patch that was dropped by Linus after appearing in 2.6.3-mm3.=20
> > > For those with problems of clock skew with the timer into pin0 routin=
g,=20
> > > that patch gave a virtual wire timer routing which worked well for th=
ose
> > > users.
> >=20
> > Whats the real difference between nmi_watchdog?1 and =3D2? Since
> > nmi_watchdog=3D2 works here:
> >=20
> > NMI:       9884
> > LOC:   80297310
> > ERR:          0
> > MIS:          0
>=20
> From memory 2 uses resources that code profiling tools need to use so
> if you can use 1 then you can have your watchdog and profile too.

Ahh outch...=20

> > Also, wouldn't it be better to not depend on bioses and bios versions
> > atm, ie hardcode pin0 since Allen Martin stated that it's hardwired on
> > pin0?
> >=20
> > ie, just:
> > if(pin2 && nforce2_chip)
> > {
> > 	printk("ALERT: Known defect in bios, mail your manufacturer. Using
> > pin0\n");
> > 	<whateverisneededtousepin0>
> > }
>=20
> It should be OK, but those with mobos that get clock skew on pin 0 would
> then demand a clock skew fix for their noisy hardware. I don't have a
> motherboard with skew problems.

Like: cat ntp.drift
-12.282

> Personally I think that the clock system should be made immune to noise
> generated timer interrupts just as it has been coded to detect missing
> timer interrupts. I am pretty sure on nforce2 athlon mobos the tsc is use=
d
> in detecting missing pulses. Kind of like a digital phase locked loop? so
> should it not also debounce the interrupts given that the ioapic interrup=
t
> hardware cannot?
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/6385.html
> Obviously the pc hardware design is flawed in this respect.

x86 is flawed in many ways, but it's cheap and you get what you pay for
=3D).

But wouldn't that cause problems with cpu freq scaling?

> Anyone know how to modify the existing timer tsc code to do this? And
> offer to do it? Any brand/type of mobo is open to clock speed up due
> to this effect, so I think it should be fixed, debouncing is fundamental
> to input transitions that need to be counted.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-Gi25+E+sqWhzw6oGOvxW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmOrT7F3Euyc51N8RAiudAKCpHtDGWi0/kN202RkCaHLi2mG2xQCePZXG
BINvlb2TZhCzaCpuTNwrNKk=
=/Y5z
-----END PGP SIGNATURE-----

--=-Gi25+E+sqWhzw6oGOvxW--

