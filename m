Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272737AbRI3HDg>; Sun, 30 Sep 2001 03:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272817AbRI3HD1>; Sun, 30 Sep 2001 03:03:27 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:29962
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S272737AbRI3HDR>; Sun, 30 Sep 2001 03:03:17 -0400
Date: Sun, 30 Sep 2001 00:03:27 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Ookhoi <ookhoi@dds.nl>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) (solved)
Message-ID: <20010930000327.F2665@one-eyed-alien.net>
Mail-Followup-To: Ookhoi <ookhoi@dds.nl>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010929162224.E9327@humilis> <200109300011.f8U0BGY58130@aslan.scsiguy.com> <20010930085730.G9327@humilis>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010930085730.G9327@humilis>; from ookhoi@dds.nl on Sun, Sep 30, 2001 at 08:57:31AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm... this makes me wonder if the Byte Merge option is keeping the PCI
consistancy rules, or perhaps the aic7xxx driver is making assumptions
about when PCI writes are actually occuring, without doing a read cycle
between critical writes to make sure they actually happen.

Matt

On Sun, Sep 30, 2001 at 08:57:31AM +0200, Ookhoi wrote:
> Hi Justin,
>=20
> > >The new driver for the Adaptec 7892B gives me the following problems
> > >(see dmesg) on a asus a7v mobo with kernel 2.4.9-ac17.
> > >
> > >I have to run the system underclocked to make it boot at all. As soon
> > >as I run it at 1000 or 1200 MHz, it does a Kernel panic: for safety
> > >during the scsi boot part. It is a 1200MHz processor. The system runs
> > >fine after the (long) boot.
> >=20
> > IIRC, the a7v is an AMD processor with VIA chipset. If you go into the
> > MB BIOS and disable all of the "Make my PCI bus go as fast as possible
> > even if this means violating the spec" options, the "new" aic7xxx
> > driver should work fine. I wish VIA would get a clue.
>=20
> It is indeed an AMD system with the VIA KT133 chipset.
>=20
> I played with the bios settings to find out with which option it would
> or would not give trouble. Under Advanced, CHIP Configuration the option
> Byte Merge has to be disabled to make the kernel boot fine with the new
> aic7xxx driver. This is with kernel 2.4.9-ac18
>=20
> The bios manual says:
> Byte Merge [Enabled by default]
> To optimize the data transfer on PCI, this merges a sequence of
> individual memory writes (bytes or words) into a single 32-bit block of
> data. However, byte merging may only be done when the bytes within a
> data phase are in a prefetchable address range. Configuration options:
> [Disabled] [Enabled]
>=20
> Why does the old driver boot fine with this enabled, and has the new
> driver troubles booting then? The system seemed to run fine after the
> long boot with the new driver and byte merge enabled, so it seemes that
> only the boot gives troubles. The system didn't always boot till the end
> with the new kernel and byte merge enabled btw, as it sometimes stopped
> with the message: Kernel panic: for safety
>=20
> Anyway, thank you for the hint! It all works fine now. :-)
>=20
> 	Ookhoi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7tsO/z64nssGU+ykRAoGcAJ4sYcZ0tYBBpvY540ln3Pciki1Y2wCg8TLK
yKnMs7jcb+i+lAPjY1WeSuQ=
=uPrT
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
