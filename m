Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbTHFQxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270677AbTHFQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:53:51 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:3549
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S270650AbTHFQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:53:42 -0400
Subject: Re: Badness in device_release at drivers/base/core.c:84
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: wb <dead_email@nospam.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3F2F84D2.8000202@nospam.com>
References: <20030801182207.GA3759@blazebox.homeip.net>
	 <20030801144455.450d8e52.akpm@osdl.org>
	 <20030803015510.GB4696@blazebox.homeip.net>
	 <20030802190737.3c41d4d8.akpm@osdl.org>
	 <20030803214755.GA1010@blazebox.homeip.net>
	 <20030803145211.29eb5e7c.akpm@osdl.org>
	 <20030803222313.GA1090@blazebox.homeip.net>
	 <20030803223115.GA1132@blazebox.homeip.net>
	 <20030804093035.A24860@beaverton.ibm.com>
	 <1060021614.889.6.camel@blaze.homeip.net>
	 <1352160000.1060025773@aslan.btc.adaptec.com>
	 <5793.199.181.174.146.1060050091.squirrel@www.blazebox.homeip.net>
	 <3F2F84D2.8000202@nospam.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TK340b1uLg/3LuHCo1Ra"
Message-Id: <1060188955.887.3.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Wed, 06 Aug 2003 12:55:55 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.5; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TK340b1uLg/3LuHCo1Ra
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 06:20, wb wrote:
> >=20
> > I'll look into serial console and try to set it up.Do i need extra
> > hardware or cables to run serial console? any poniters or setup
> > suggestions would be welcome as i never used serial consoles before.
> > Regards,
> >=20
> > Paul
> > -
>=20
>   Your need a NULL modem serial cable available
>   from any computer store.
>=20
> Install uucp - I use on the HOST :
>=20
> uucp-1.06.1-33.7.2.
>=20
> Also , LILO is broken on some machines and ignores
> serial input so make sure you use at least
>=20
> lilo-21.6-71
>=20
> On the TARGET
>=20
> 1. Connect the serial ports together ( COM1->COM1 ) with
>     the serial cable .
>=20
> 2. Modify LILO to use serial line on the TARGET
>     add to lilo.conf:
>        append=3D"console=3DttyS0,9600n8  console=3Dtty0 "
>        serial=3D0,9600N8
>=20
>     Run lilo
>=20
> 3. Add to /etc/inittab on the HOST
>=20
>        S0:s12345:respawn:/sbin/agetty 9600 ttyS0
>=20
> 4. To see ALL THE CONSOLE MESSAGES during boot on the TARGET
>=20
>     mv /dev/console /dev/console.org
>     ln  /dev/ttyS0 /dev/console
>=20
> 5. Start uucp on the HOST:
>=20
>      cu -l /dev/ttyS0 -s 9600
>=20
> 6. Boot your target
>=20
> ///
>=20
> John Donnelly AT HP DOT com
>=20

John,

I appreciate your writing short and sweet howto :-).

I was able to get it going from FreeBSD 5.1 box with cu -l /dev/ttyd0
2&<1 > log to my Linux machine.

Thank you for helping.

Paul B.

--=-TK340b1uLg/3LuHCo1Ra
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MTMbIymMQsXoRDARAqycAJ9AnaoHxwqVzQN7UHdEs1gom4kfVgCfTeqA
lCRHDXnINmQK4Yn99dCV1cg=
=bPyK
-----END PGP SIGNATURE-----

--=-TK340b1uLg/3LuHCo1Ra--

