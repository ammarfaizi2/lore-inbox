Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbTCPXeu>; Sun, 16 Mar 2003 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbTCPXeu>; Sun, 16 Mar 2003 18:34:50 -0500
Received: from B51f4.pppool.de ([213.7.81.244]:1214 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261652AbTCPXes>; Sun, 16 Mar 2003 18:34:48 -0500
Subject: IDE won't compile as module in 2.5.64
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Lejcl9vG4g/RxyxNPvFl"
Organization: 
Message-Id: <1047857872.5494.21.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Mar 2003 00:37:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lejcl9vG4g/RxyxNPvFl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

trying to compile the IDE subsystems as module yields:

drivers/built-in.o(.text+0x51602): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x51607): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x51635): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x51659): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x5165e): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x51676): more undefined references to
`ide_hwifs' follow
drivers/built-in.o(.text+0x51df7): In function
`ide_setup_pci_controller':
: undefined reference to `noautodma'
drivers/built-in.o(.text+0x52322): In function `ide_setup_pci_device':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x5232a): In function `ide_setup_pci_device':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x52341): In function `ide_setup_pci_device':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x52349): In function `ide_setup_pci_device':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x523c5): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x523cd): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x523e4): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x523ec): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x52404): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x5240c): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x52425): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x5242d): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x52c2f): In function `__ide_dma_off_quietly':
: undefined reference to `ide_toggle_bounce'
drivers/built-in.o(.text+0x52d2f): In function `__ide_dma_on':
: undefined reference to `ide_toggle_bounce'
drivers/built-in.o(.text+0x52ee8): In function `__ide_dma_read':
: undefined reference to `ide_execute_command'
drivers/built-in.o(.text+0x52fb8): In function `__ide_dma_write':
: undefined reference to `ide_execute_command'
drivers/built-in.o(.text+0x532b0): In function `__ide_dma_verbose':
: undefined reference to `eighty_ninty_three'
drivers/built-in.o(.init.text+0x391c): In function `init_hwif_generic':
: undefined reference to `noautodma'

I tried to figure out what's wrong and it seems that the make machinery
is not up-to-date since none of the code in question is dependent on
the definition of MODULE or alike.

Anymore more on par with this can give me a tip here?

--=20
Servus,
       Daniel

--=-Lejcl9vG4g/RxyxNPvFl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+dQrPchlzsq9KoIYRAun4AKDaK9NnRqXpO+epm2YSp8jbKBS7nQCfRiqr
pzchUWGglV1DKU4n3glQYyA=
=DHm8
-----END PGP SIGNATURE-----

--=-Lejcl9vG4g/RxyxNPvFl--

