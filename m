Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUAKUFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUAKUFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:05:23 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:36278 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265971AbUAKUFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:05:09 -0500
Date: Sun, 11 Jan 2004 12:04:52 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Lukas Postupa <postupa@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: USB hangs
Message-ID: <20040111200452.GB23039@one-eyed-alien.net>
Mail-Followup-To: Lukas Postupa <postupa@gmx.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <1073846788.2087.29.camel@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <1073846788.2087.29.camel@linux>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Did the patch Alan posted make any difference?

I've been getting several reports recently of problems with usb-storage and
EHCI controllers.  If you unload the ehci driver, your device will run at
1.1 speeds -- can you try that and see if it works?

Matt

On Sun, Jan 11, 2004 at 07:46:29PM +0100, Lukas Postupa wrote:
> Alan Cox wrote:
> > With the various fixes people had been posting USB storage
> > writing was still hanging repeatedly when doing a 20Gb rsync
> > to usb-storage disks with a low memory system. Doing things
> > like while(true) sync() made it hang even more often.
> >=20
> > After a bit of digging the following seems to fix it
> >=20
> > Not sure if 2.6 needs this as well.
>=20
> I have similiar problems with kernel 2.6.0 on Intel architecture with
> 512 MB Ram.
>=20
> My Abit IT7-MAX2 2.0 mainboard has two USB - EHCI controllers:
>=20
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
>=20
> 02:06.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
>=20
> I'm using rsync to transfer my data to usb storage.
> Connecting usb storage to one of the 4 ports of VIA EHCI controller and
> then transferring data to it works good.
>=20
> But connecting usb storage to one of the 6 ports of INTEL EHCI
> controller and then transferring data to it, will hang up usb storage:
>=20
> Buffer I/O error on device sda1, logical block 121479
> lost page write due to I/O error on sda1
> Buffer I/O error on device sda1, logical block 121480
> lost page write due to I/O error on sda1
> ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001002 POWER sig=3Dse0  CSC
> hub 6-0:1.0: port 2, status 100, change 1, 12 Mb/s
> usb 6-2: USB disconnect, address 4
> usb 6-2: usb_disable_device nuking all URBs
> usb 6-2: unregistering interface 6-2:1.0
> usb-storage: storage_disconnect() called
> usb-storage: usb_stor_stop_transport called
> usb-storage: -- dissociate_dev
> usb-storage: -- sending exit command to thread
> usb-storage: *** thread awakened.
> usb-storage: -- exit command received
> usb-storage: -- usb_stor_release_resources finished
> usb 6-2: unregistering device
>=20
> VIA EHCI controller uses interrupt 21.
> INTEL EHCI controller uses interrupt 23.
>=20
> cat /proc/interrupts:
>=20
>            CPU0      =20
>   0:   16675721    IO-APIC-edge  timer
>   1:       6876    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   9:          5   IO-APIC-level  acpi
>  12:     191706    IO-APIC-edge  i8042
>  14:     251218    IO-APIC-edge  ide0
>  15:          1    IO-APIC-edge  ide1
>  16:    1446615   IO-APIC-level  uhci_hcd, nvidia
>  18:          0   IO-APIC-level  uhci_hcd, uhci_hcd
>  19:        278   IO-APIC-level  uhci_hcd, uhci_hcd, EMU10K1
>  21:     257509   IO-APIC-level  ehci_hcd
>  22:       7640   IO-APIC-level  eth0
>  23:     322432   IO-APIC-level  ehci_hcd
> NMI:          0=20
> LOC:   16675149=20
> ERR:          0
> MIS:          0
>=20
> Any ideas?
>=20
> Lukas



--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Stef, you just got beaten by a ball of DIRT.
					-- Greg
User Friendly, 12/7/1997

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAaxkIjReC7bSPZARAqwGAKCCyq5qOohAsJ50wiXPl+j4wG1bzQCfeCzJ
ygb2ljgC+WDPWHYZU9aYTd4=
=YRmd
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
