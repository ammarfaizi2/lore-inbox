Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266691AbRGIIvp>; Mon, 9 Jul 2001 04:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRGIIvg>; Mon, 9 Jul 2001 04:51:36 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:17424 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266691AbRGIIvS>;
	Mon, 9 Jul 2001 04:51:18 -0400
Date: Mon, 9 Jul 2001 12:51:15 +0400
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the status of kernel PNP?
Message-ID: <20010709125115.A19087@orbita1.ru>
In-Reply-To: <20010709105756.A18230@orbita1.ru> <20010709073410.1567.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010709073410.1567.qmail@science.horizon.com>; from linux@horizon.com on Mon, Jul 09, 2001 at 07:34:10AM -0000
X-Uptime: 11:04am  up 9 days, 17:59,  2 users,  load average: 0.00, 0.00, 0.00
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: pazke@orbita1.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2001 at 07:34:10AM -0000, linux@horizon.com wrote:
> > Please provide more detailed hardware description and a output of
> > 'cat /proc/isapnp'.  IMHO this problem can be solved easily.
>=20
> Thank you for being so soothing.  As you could probably notice, I was a b=
it
> frustrated.
>=20
> On the first machine, with the modem (note that I ran isapnp manually, si=
nce
> this modem is my net connection!):
>=20

> Card 1 'MOT15f0:Motorola VoiceSURFR 56K Modem' PnP version 1.0
>   Logical device 0 'MOT15f0:Unknown'
>     Supported registers 0x2
>     Compatible device MOT15f0
>     Device is active
>     Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
		  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		   =20
Use of isapnptools package mixed with kernel 2.4.x ISA PNP subsystem is ask=
ing=20
for trouble. Move /etc/isapnp.conf file to some other place and try to rebo=
ot.

[SNIP]

> isapnp: Scanning for PnP cards...
> isapnp: Card 'Motorola VoiceSURFR 56K Modem'
> isapnp:   Device 'Unknown'
> isapnp: 1 Plug & Play card detected total
> PnP: PNP BIOS installation structure at 0xc00fdbd0
> PnP: PNP BIOS version 1.0, entry at f0000:d20e, dseg at f0000
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.1 Flags 0x03 (Driver version 1.14)
> Starting kswapd v1.8
> parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
> matroxfb: Matrox Millennium (PCI) detected
> matroxfb: 640x480x8bpp (virtual: 640x13081)
> matroxfb: framebuffer at 0xFE000000, mapped to 0xc6807000, size 8388608
> Console: switching to colour frame buffer device 80x30
> fb0: MATROX VGA frame buffer device
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL=
_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
> ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
> ttyS02 at port 0x03e8 (irq =3D 5) is a 16550A
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hmm, looks strange to me, it seems that serial driver found your modem and =
configured
it as /dev/ttyS2. Did you try to test it with minicom for example ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7SXCDBm4rlNOo3YgRAtWkAJ9oAuslCFbXx7uM7OxcgHOdg4omsACfXef0
xCXtCyRNqqeN3hhFFaZ4Zsc=
=40kM
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
