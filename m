Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263228AbUFFLZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUFFLZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 07:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUFFLZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 07:25:34 -0400
Received: from wblv-224-211.telkomadsl.co.za ([165.165.224.211]:7078 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263228AbUFFLZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 07:25:31 -0400
Subject: Re: keyboard problem with 2.6.6
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
References: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q9x8yZ11nn/kCYjVFQc4"
Message-Id: <1086521387.25484.14.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 13:29:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q9x8yZ11nn/kCYjVFQc4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-06 at 11:37, Sau Dan Lee wrote:
> >>>>> "Valdis" =3D=3D Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
>=20
>     >> You don't tell any kernel about that... it is the bootloader
>     >> you are talking to. And that one may very well have integrated
>     >> kbd support.
>=20
>     Valdis> So GRUB knows about keyboards, lets you type in the
>     Valdis> "init=3D/bin/bash", it loads the kernel, the kernel launches
>     Valdis> init, /bin/bash gets loaded=20
>=20
> If  init can  launch /bin/bash  (actually,  it lauches  getty in  most
> setups), why can't it start the userland keyboard driver daemon?
>=20
> Back  in the  old days  before the  introduction of  /etc/rc.d/, every
> daemon was started from by init.
>=20
>=20
>     Valdis> - and /bin/bash can't talk to the keyboard because the
>     Valdis> userspace handler hasn't happened. =20
>=20
> As soon as the daemon is  running, /bin/bash can talk to the keyboard.
> There is not much concurrency problems here.  The current input system
> makes  it possible  for /bin/bash  to start  opening the  keyboard and
> waiting for input before the userspace handler is ready.
>=20
>=20
>     Valdis> At that point you're stuck...
>=20
> I  can't see  how stuck  it is.   And if  you fear  that  the userland
> keyboard driver  would crash  (maybe due to  bugs), use  the 'respawn'
> option in /etc/inittab.

The point is that 'init=3D/bin/bash' is usually used as a method to
do some _unexpected_ rescue work - meaning you usually do not think
about it (or write a shell script to start a keyboard daemon) until
you need it.  Thats it - a rescue method - and its got nothing to do
with what is in inittab, or if getty's are started or not.  Some
distro's even have sash installed by default (statically linked) in
case your glibc is borked or such, and you need to cp/mv/gunzip things.

Anyhow, the other point that should be made, is that your are really
getting boring/annoying.  Please face the fact that many of us (most?)
do not want a silly daemon for keyboard, but an in-kernel driver.
Guess what else ... Valdis, etc do not even argue with you for wanting
this silliness (besides not wanting to get rid of the in-kernel driver),
but are prepared to add raw access, so that you can go and code/use your
daemon (Ok, so maybe the raw access is for more than what you want, but
anyhow ...).

So please stop being selfish and continuing to spam the list.


Thanks,

--=20
Martin Schlemmer

--=-Q9x8yZ11nn/kCYjVFQc4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAwwAqqburzKaJYLYRArObAKCB1ycnL3UMy8pUO0CcoZUFrkTPKACeIOvB
lhZbTRqrFMlPoyEx5DFwVJw=
=Cvgj
-----END PGP SIGNATURE-----

--=-Q9x8yZ11nn/kCYjVFQc4--

