Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUCVAuK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUCVAuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:50:10 -0500
Received: from legolas.restena.lu ([158.64.1.34]:39851 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S261580AbUCVAuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:50:01 -0500
Subject: Re: Synaptics touchpad + external mouse with Linux 2.6?
From: Craig Bradney <cbradney@zip.com.au>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Dmitry Torokhov <dtor@mail.ru>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m33c81lsnk.fsf@defiant.pm.waw.pl>
References: <m33c81lsnk.fsf@defiant.pm.waw.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CqTr/PXMolwHa30qvB11"
Message-Id: <1079916600.4224.11.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 01:50:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CqTr/PXMolwHa30qvB11
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-21 at 23:52, Krzysztof Halasa wrote:
> Hi,
>=20
> I have a notebook PC (an old Fujitsu-Siemens Liteline, celeron 600 etc)
> with a Synaptics touchpad:
>=20
> Synaptics Touchpad, model: 1
>  Firmware: 4.6
>  Sensor: 19
>  new absolute packet format
>  Touchpad has extended capability bits
>  -> multifinger detection
>  -> palm detection
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1
>=20
> This notebook has external mouse+keyboard connector. Is it possible to
> have both the touchpad and the external mouse simultaneously active in
> their native modes? The hardware (keyboard controller) doesn't seem to
> support the active multiplexing mode (by Synaptics and others):
>=20
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: 0f <- i8042 (return) [3]
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: a9 <- i8042 (return) [3]
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: 5b <- i8042 (return) [3]
>=20
> It looks the keyboard controller just forwards all data from both
> devices. I can set them (i.e. Linux and XFree86 driver) to IM PS/2 mode
> and they will both work (Linux treats them as one device), but I can't
> use touchpad's special features.
>=20
> I was thinking about setting them to IM PS/2 mode first (both would go
> IM PS/2) then switching to Synaptics mode (the mouse should ignore it).
> On the receiving side, I could check if the packet is valid for IM or
> Synaptics mode and pass it to the respective driver. Not sure if the
> keyboard controller is fully transparent, though - it could be changing
> data as outlined in the Synaptics PS2-MUX paper ("legacy hidden
> multiplexing").
>=20
> If I set Linux to Synaptics mode (i.e. modprobe psmouse without any
> parameters), I can't use the external mouse as it produces 3-byte
> packets by default (the kernel =3D synaptics.c prints "Synaptics driver
> lost sync at byte 1").
>=20
> What do you think?

Hmm would be a nice thing to have both running "how they
should/natively". I have IMPS/2 set and am running the touchpad with a
usb logitech notebook mouse on a Siemens Amilo D7830.

Craig

--=-CqTr/PXMolwHa30qvB11
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAXjg3i+pIEYrr7mQRAkVnAJ9Hbze62nKeLcsssPjozSlKgRBULACbBala
klaR8U2wKTZmCFPttXy4qMk=
=5gj2
-----END PGP SIGNATURE-----

--=-CqTr/PXMolwHa30qvB11--

