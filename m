Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUD2MRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUD2MRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUD2MR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:17:29 -0400
Received: from legolas.restena.lu ([158.64.1.34]:21697 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264182AbUD2MQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:16:22 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: Jesse Allen <the3dfxdude@hotmail.com>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <200404292144.37479.ross@datscreative.com.au>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
	 <200404282133.34887.ross@datscreative.com.au>
	 <20040428205938.GA1995@tesore.local>
	 <200404292144.37479.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZDpf+2Z8bzrhgeH+04IG"
Message-Id: <1083240974.8367.14.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 14:16:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZDpf+2Z8bzrhgeH+04IG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-29 at 13:44, Ross Dickson wrote:
> On Thursday 29 April 2004 06:59, Jesse Allen wrote:
> > On Wed, Apr 28, 2004 at 09:33:34PM +1000, Ross Dickson wrote:
> > > >=20
> > > > It may be this board never hangs no matter what,
> > > > or perhaps C1 disconnect was simply disabled in that BIOS
> > > > b/c there was no option for it in Advanced Chipset Features
> > > > like there is for the most recent BIOS.
> > >=20
> > > Maybe other MOBO manufacturers skimp on filter caps and regulator dam=
ping
> > > ability and a resonance occurs in the on-board supply rails? Do Shutt=
le make
> > > any claims to using an improved on board regulator? Or Shuttle may ha=
ve=20
> > > always programmed more time in C1 cycle handshakes if such is=20
> > > configurable?=20
> >=20
> > Do you really think so?  I think there may be a resonance occuring, eve=
n with=20
> > this new BIOS.  I plugged in new headphones into my nforce2 onboard sou=
nd, and=20
> > get a high pitched noise.  Now here is where it gets weird:  This noise=
 does=20
> > not occur on boot until sometime after the IDE driver is loaded.  I als=
o=20
> > believe it varies under a high load.  If you disable C1 disconnect, it'=
s gone. =20
> > Also I've heard a high pitched noise at certain times coming right from=
 the=20
> > copmuter (very faint, but I do have very good hearing, I can even hear =
a hush=20
> > sounding from my router.  my brother was quite astonished when I pointe=
d that=20
> > out)  I try to distinguish whats doing it.  It could be the hard drive.=
  But=20
> > when I found the other sound in the head phones, I found that the sound=
 varies=20
> > almost in unison with the sound coming from the computer.  Maybe the ID=
E or=20
> > hard drive is related, but it is too much related to C1 disconnect.
>=20
> I think I might break out my oscilloscope this weekend and have a look at=
 how=20
> clean the supply rails are around the cpu and northbridge and southbridge=
.=20
> Who knows I might get lucky and see some unexpected ripple or spikes.
>=20
> >=20
> > Whether it is really possible that my board can really generate this so=
und, I=20
> > don't know.  Though, I have once determined that resonance was occuring=
 in an=20
> > old system, causing unstable CPU operation.  It wasn't that I heard a s=
ound=20
> > coming from it =3D).  But what I thought was the case was causing it, a=
nd pulled=20
> > it out of the case.  I ran it on the table and found it to be stable.  =
That=20
> > was the only thing wrong.  I've also studied resonance before a bit.  I=
 know=20
> > resonance can break systems.  But to think that my board is doing emmit=
ting=20
> > noise like that is pretty bizarre.
>=20
> Not as bizarre as you may think. I have heard coils and even capacitors "=
sing"
> in years past whilst servicing electronics.
>=20
> >=20
> > It may be true that this Shuttle board may have resonance problems.  So=
 that=20
> > would indicate that they did something much like you describe by changi=
ng the=20
> > C1 handshake time?  Isn't that much like what your patch does?
>=20
> I had not really thought about it from that perspective. Whilst my patch =
cannot=20
> alter the handshake times it does prevent consecutive C1 cycles from occu=
rring
> too close together. Too close together I think being less than about 800n=
s. I=20
> guess I could look at that with a cro too - use an appropriate pin as the=
 trigger
> source and see if supply rails have load dump voltage rises when going in=
to
> disconnect. Maybe rail voltage rings for about 700ns and might be out of=20
> tolerence inside Athlon during that time. Would be very interesting if a=20
> few hundred picofarad of low esr decoupling cap placed on a supply rail n=
ear a
> chip makes a difference? A pinout of the nforce2 chipset would help a gre=
at deal
> here but I do not have one. Can anyone oblige me?
>=20
> >=20
> >=20
> > >=20
> > > > hang issue is completely explained and solved.
> > >=20
> > > I have had good (100%) success in reproducing the fault with the Alba=
tron=20
> > > KM18G pro MOBO. I needed m-atx form factor and distributor was local =
to me.
> > > Makes very nice - cheap and stable system but only with the lockup wo=
rkaround.
> > >=20
> > > I also recollect that Windows had lockups with nforce2 for a while de=
pending=20
> > > whether you ran the Nvidia or Microsoft driver.
> > > http://lkml.org/lkml/2003/12/13/5
> > > Anybody got the inside running on that one and what was different bet=
ween the=20
> > > two drivers?
> > >=20
> >=20
> > Yeah, unfortunately, I didn't save a link to the message board that I f=
ound=20
> > that on.  But the issue is pretty common.  I'm sure more info can be fo=
und on i
> > the windows side.
>=20
> No tech info but this link shows user had Lockups with Nvidia's ide drive=
r but
> OK with MS one.
> http://club.cdfreaks.com/showthread/t-91381.html
>=20
> -

This has become a rather interesting problem to watch from afar. The
Athlon here seems to have no issues with the NForce driver under Windows
(I dont burn a lot of DVDs on it tho). Whenever its in Linux, its mainly
a testing machine these days.

It will be interesting to see if theres a real hardware problem and then
if it can be worked around in software (cant image a single product
recall happening).

--=-ZDpf+2Z8bzrhgeH+04IG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAkPIOi+pIEYrr7mQRApmZAJ9G5/sHOLiYF3y1P08dvXnFVxCgdgCcDjvI
XMDLFVdz+z7A+iW3uoVHPko=
=CXCq
-----END PGP SIGNATURE-----

--=-ZDpf+2Z8bzrhgeH+04IG--

