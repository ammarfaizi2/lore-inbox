Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbTFVLgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbTFVLgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:36:11 -0400
Received: from cpt-dial-196-30-179-204.mweb.co.za ([196.30.179.204]:51328 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S264992AbTFVLfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:35:52 -0400
Subject: Re: Which driver for the 3C940 / 3C2000?
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Cc: karim@opersys.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aM9QsweQXg995av0G9Yo"
Organization: 
Message-Id: <1056282620.5490.9.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 22 Jun 2003 13:50:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aM9QsweQXg995av0G9Yo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Karim wrote:
> Jurgen Kramer wrote:
>  > I am a bit confused about which driver a need for my onboard (Asus
>  > P4C800 mobo) 3Com gigabit Ethernet controller. It should be a 3C940 bu=
t
>  > sometimes it's called 3C2000. I found a driver at the asus site which
>  > compiles and works with some kernel versions. Is there a proper (open
>  > source) kernel driver for this chip? It seems that the tg3 driver
>  > support some type of 3C940 but not mine.
>  >
>  > lspci -n gives:
>  >
>  > 02:05.0 Class 0200: 10b7:1700 (rev 12)
>  >
>  > This chip is also currently not defined in pci_ids.h (2.4 and 2.5)
>=20
> I've got a P4C800DX-2.4GH-HT and have run into similar issues. I tried

I have similar setup.

> using the 3C2000 driver shipped by ASUS on their "driver" CD, but that wa=
s
> a weird experience. The driver built and installed fine with the SMP
> kernel shipped with RedHat9. HOWEVER ... I could browse some web sites
> and not others (I'm still trying to figure out how this could be ...)
> Somehow, I could point konqueror to slashdot.org, kernel.org, motorola.co=
m,
> yahoo.com, lwn.net, etc. and see the pages, but I was unable to visit int=
el.com,
> google.com, or amazon.com. I couldn't imagine this being a driver problem=
, so I
> tried all sorts of different things, but still had this weird behavior. F=
inally, I
> decided to put an 8139 with the same config, and that worked right away .=
.. !?!
>

Ditto

> During my research about the 3C2000, I discovered that the driver
> shipped with the board is actually a variant of the code in
> drivers/net/sk98lin, with modified printks to display 3Com text instead o=
f
> SysKonnect information:
> ...

Yep, its a SysKonnect chip.

> And it goes on for CNET and Linksys. Apparently, all these devices rely
> on the same core. However, a trivial adding of the appropriate vendor ID
> and device ID to the sk98lin in 2.4.21 resulted in an ooops at load time,
> so it isn't as straight forward as I would have liked it to be ...
>=20

Problem is rather that the drivers in the kernel really outdated.

> It'd be nice that the sk98lin driver already in Linux be modified to add
> support to the 3C940, albeit without the browsing weirdness ...
>

You can find the latest SysKonnect driver here:

  http://www.syskonnect.de/syskonnect/support/driver/htm/sk98lin.htm


It is only for 2.2 and 2.4 though.

I have 'ported' the latest version (6.10) and a previous version or two
to 2.5, but I had similar issues as you .... I could ping the boxen on
my network, but cannot ssh for instance - basically its as if it only
do icmp and rarely actually send/receive other data.

I have also mailed SysKonnect, but they told me to speak to 3COM :/

Anyhow, if somebody want my efforts in the 2.5 port to get it working,
ask.  I however do not have time to struggle with it currently.


Regards,

--=20

Martin Schlemmer




--=-aM9QsweQXg995av0G9Yo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9Zf8qburzKaJYLYRAv8PAJ9m1S3xP07YFNiWYdPeJtbnHzfQfACghS95
yu2OkiiXeVn4NUWmbZwJyHw=
=Fom1
-----END PGP SIGNATURE-----

--=-aM9QsweQXg995av0G9Yo--

