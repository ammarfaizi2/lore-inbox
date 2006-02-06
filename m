Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWBFTxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWBFTxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWBFTxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:53:48 -0500
Received: from lug-owl.de ([195.71.106.12]:23245 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932334AbWBFTxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:53:47 -0500
Date: Mon, 6 Feb 2006 20:53:43 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
Subject: Re: Linux drivers management
Message-ID: <20060206195343.GI19232@lug-owl.de>
Mail-Followup-To: Yaroslav Rastrigin <yarick@it-territory.ru>,
	Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
	Nicolas Mailhot <nicolas.mailhot@laposte.net>,
	David Chow <davidchow@shaolinmicro.com>
References: <1139250712.20009.20.camel@rousalka.dyndns.org> <200602061002.27477.joshua.kugler@uaf.edu> <200602062217.19697.yarick@it-territory.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <200602062217.19697.yarick@it-territory.ru>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-06 22:17:19 +0300, Yaroslav Rastrigin <yarick@it-territory.=
ru> wrote:
> > I use two products that use out-of-tree drivers.  VMWare and NVidia car=
ds. =20
> > Fortunately, the build processes for both are rather painless, but ther=
e have=20
> > been times when it has *not* been, and it was extremely frustrating.  I=
=20
> > remember when VMWare was not doing a good job of supporting 2.6 kernels=
 and I=20
> > spent the better part of two days trying to track down a solution.  I f=
inally=20
> > did, but it was a third party, non-VMWare, patch to the VMWare code tha=
t=20
> > fixed it so it would compile and run.  That's not what I consider conve=
nience=20
> > for the non-technical user.  A non-technical user would not have been a=
ble to=20
> > do what I did, especially when they just want their software to work.
> And then think, why do you need to _build_ drivers in the first place.=20
> Wouldn't it be better to have one vmware.ko which insmod's with all 2.6 v=
ersions , from 2.6.0 to 2.6.16-rc2 ,=20
> and throw "upgrade pain" away completely ?=20

This would only work if we sacrified the freedom to change something.
The kernel code base changes. A lot, actually. If it didn't, there eg.
wouldn't be suspend2whatever, because the API was plain missing back
in those days. So sacrifice evolution for backwards compatibility?

These days (and it has always been that way) kernel development is a
quite active process. If core-APIs need to be changed, the person who
does it usually also updates all users of the given API. That won't
work if the drivers are not in the codebase, no chance to grep for
something on 3rd vendor's websites...

> > I want to install my machine and have everything work.  Don't make me c=
hase=20
> > all over the net trying to find a driver for my hardware.  If it's a ne=
twork=20
> All over the net ? Again, you're proving stable API/ABI supporters nicely=
=2E=20
> If kernel has stable ABI, basic/default driver is included on installatio=
n CD, and all you need to do=20
> is to launch ./install-linux.sh from CD in your shell or click OK and ent=
er your root password in GUI box.
> Newer/better driver - just go to device manufacturer's website, download =
installation package and install this driver.=20
> Without rebuilding.=20

Not everybody is using RedHar, SuSE, Debian or whatever. Consider I
was building a custom QBus-to-PCI bridge to use some ATI/NVidia
graphics board in my 15y old VAX. If my hardware hack required
broadening some in-kernel API, do you really think some guy at NVidia
(only to name an example:-) would cross-compile their stuff for a VAX?
Given a userbase of exactly _one_ person?

> > (i.e. ethernet device) the driver had *better* be in the tree.  Trying =
to=20
> > download the driver to another computer, transferring, etc, is enough t=
o make=20
> > me find another brand of network card.
> And what to do if you've bought new hardware, installed it and _voila_ - =
NO IN-TREE DRIVER exists ?
> Do you want every Linux user  going for shopping to nearest WalMart carry=
 full linux hardware compatibility list printed out ?
> Or intree driver list ?

Usually, it's quite simple to buy correct hardware. Look for something
that's a tad more intelligent (SCSI scanners in favour of USB/parport,
postscript printers, ...) and offloads the host CPU.

> > I sometimes delay kernel updates because I don't want to mess with upda=
ting my=20
> > NVidia and VMWare drivers.  This is *not* good for security.
> So who to blame ? Maybe, just look at those who don't want stable driver =
API ?

The Linux kernel is a project (or hundreds actually) that have choosen
their way of operation. That's evolution with not a lot of
looking-back. If you want to have a stable API, heck, just prepare
another fork and implement it. If this is what users want, they'll
take it.

> > So I did.  Please put your driver in the tree.  It will be better for a=
ll=20
> > concerned.
> Please, don't force your preferences over others'

My (personal!) view is that Linux isn't actually about the users. It's
about the developers. Developers develop what they have a use for (or
become famous.) Sometimes, regular users can make good use of it, once
distributions prepared all the userland.

So if you're a developer, try to become famous for implementing a
stable API.

If you're a user, stop fighting against an operating system's kernel
and start looking for a system _you_ want to use. Maybe some WinXP
variant?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD56lHHb1edYOZ4bsRAsF9AJ9orlcnQJiaBP3Yq8DzFucuxGnRVACdEiNo
I3dZDZFKWjqmgJYPEeBvX74=
=uaqC
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
