Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272001AbTHDRrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272044AbTHDRrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:47:03 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:51922
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S272001AbTHDRq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:46:58 -0400
Subject: Re: Badness in device_release at drivers/base/core.c:84
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <20030804093035.A24860@beaverton.ibm.com>
References: <20030801182207.GA3759@blazebox.homeip.net>
	 <20030801144455.450d8e52.akpm@osdl.org>
	 <20030803015510.GB4696@blazebox.homeip.net>
	 <20030802190737.3c41d4d8.akpm@osdl.org>
	 <20030803214755.GA1010@blazebox.homeip.net>
	 <20030803145211.29eb5e7c.akpm@osdl.org>
	 <20030803222313.GA1090@blazebox.homeip.net>
	 <20030803223115.GA1132@blazebox.homeip.net>
	 <20030804093035.A24860@beaverton.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k+zJSygnJ1iFV8U5e6cm"
Message-Id: <1060019339.883.12.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Mon, 04 Aug 2003 13:48:59 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k+zJSygnJ1iFV8U5e6cm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-04 at 12:30, Patrick Mansfield wrote:
> On Sun, Aug 03, 2003 at 06:31:15PM -0400, Diffie wrote:
> > On Sun, Aug 03, 2003 at 06:23:13PM -0400, Diffie wrote:
>=20
> > > Thank you for all your help.Sorry but i gave the wrong URL in previou=
s
> > > email.The correct one is http://www.blazebox.homeip.net:81/diffie/ima=
ges/linux-2.6.0-test2/
> > >=20
>=20
> Per your screen dump - it found the cd-rom's on id 3 and 4, but not your
> disk drive that was at id 0, and the adapter found something at id 6 (hos=
t
> adapter is at id 7).
>=20
> You could try turning on scan logging, it might give more information.
> You can turn on the logging at boot time, make sure you have
> CONFIG_SCSI_LOGGING on, the information of interest (scan of host 0 chan =
0
> id 0 lun 0) likely will scroll off screen.
>=20
> For scan logging, add to your boot line:
>=20
> 	scsi_mod.scsi_logging_level=3D0x140
>=20
> To limit the logging info, make sure max_scsi_luns=3D1 via config or boot
> time option scsi_mod.max_scsi_luns=3D1.
>=20
> -- Patrick Mansfield
>=20

Patrick,

That's correct Plextor 40TW (ultraplex wide) is on ID3 and Plextor
plexwriter 32/10/12s is on ID4.Originally i had the IBM 36LZX drive at
ID6 (factory setting) but when using the aic7xxx_old driver it was
detected as /dev/sdb for some reason.I've changed the ID to 0 and it
became /dev/sda again...strange it is.

The Adaptec AHA-2940U2W card is set to boot from ID0 by default and it
has 2.57.2 BIOS (the latest i think).

I tried the latest 2.6.36 driver from Justin's site on kernel 2.4.21 and
it works great.I was unable to boot the 2.5 driver on 2.6.0-test2 it
game oops and i had to define blkdev.h in few places.

I will try your suggestions and report back.

Regards,

Paul B.



--=-k+zJSygnJ1iFV8U5e6cm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/LpyLIymMQsXoRDARAsyjAJ9lHHaWvLQBt/vhV93SnZkYSzL88ACfeovL
rZL9JldnS1zwcPF+X1C5Iec=
=yoPi
-----END PGP SIGNATURE-----

--=-k+zJSygnJ1iFV8U5e6cm--

