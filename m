Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTH2S6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTH2S6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:58:55 -0400
Received: from mx.laposte.net ([213.30.181.11]:29355 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261719AbTH2S5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:57:49 -0400
Subject: Re: CONFIG_LOG_BUF_SHIFT hardwired in 2.6.0-test4-bk2 ?
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030829114111.18ec26d0.rddunlap@osdl.org>
References: <1062181819.3618.4.camel@rousalka.dyndns.org>
	 <20030829113634.3d5a6f20.rddunlap@osdl.org>
	 <20030829114111.18ec26d0.rddunlap@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jlw+JnOGGSRxi6f0ZN6v"
Organization: Adresse personnelle
Message-Id: <1062183460.4847.6.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 29 Aug 2003 20:57:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jlw+JnOGGSRxi6f0ZN6v
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 29/08/2003 =E0 20:41, Randy.Dunlap a =E9crit :
> On Fri, 29 Aug 2003 11:36:34 -0700 "Randy.Dunlap" <rddunlap@osdl.org> wro=
te:
>=20
> | On Fri, 29 Aug 2003 20:30:19 +0200 Nicolas Mailhot <Nicolas.Mailhot@laP=
oste.net> wrote:
> |=20
> | | Hi,
> | |=20
> | | 	I'm testing acpi changes and unfortunately all the debug messages
> | | overflow the log buffer. So I decided to increase CONFIG_LOG_BUF_SHIF=
T=20
> | | in .config (there was a menu entry for this at some time in menuconfi=
g
> | | but I can't find it anymore).
> | |=20
> | | 	Anyway no matter what I do the value seems to be reseted to 14 at bu=
ild
> | | time. Is there a way to cleanly change it without poking directly int=
o
> | | the kernel source code ?
> |=20
> | You need to enable DEBUG_KERNEL (kernel debugging) to see it in the men=
u.
> |=20
> | After you edit .config, run 'make oldconfig' and that should fix it.
>=20
> More accurately, you cannot edit .config and make oldconfig on this
> config option if DEBUG_KERNEL is not set.  It won't take effect.
> It will be lost by make oldconfig, so enable DEBUG_KERNEL first.

More accurately if DEBUG_KERNEL is not set you won't get the menuconfig
entry to set it *and* whatever manual changes you to to it in your
.config won't be taken into account.

Which is just plain stupid - if it's linked this hard to DEBUG_KERNEL
what the hell is it doing in another config section ? It's not like it
depended on another option (like usb-storage on usb & scsi). I missed it
both in menuconfig (duh - didn't thought of re-reading the whole menu
structure after enabling debug) and during manual .config edit.

(anyway you solved my problem at light speed and for this you're my day
god - thanks a lot)

--=20
Nicolas Mailhot

--=-Jlw+JnOGGSRxi6f0ZN6v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/T6IkI2bVKDsp8g0RAtALAJ4saDM9Wr0Kb8HSyDmI8cACNFYQQQCbBn/M
ZFWJ4mPrArgX9jQ57qx3OHk=
=NPo6
-----END PGP SIGNATURE-----

--=-Jlw+JnOGGSRxi6f0ZN6v--

