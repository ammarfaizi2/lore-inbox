Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTE0Mux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTE0Mux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:50:53 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:45319 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S263458AbTE0Muv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:50:51 -0400
Date: Tue, 27 May 2003 15:04:21 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.69/i386] rmmod ohci_hcd - deadlock
Message-ID: <20030527130421.GB701@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am seeing a deadlock on removal of the ohci_hcd module. You get to see
some usb disconnect messages after which the machine is dead and needs
to be powercycled. This is a Sony Vaio C1MHP. I am unable to test 2.5.70
because it hangs on boot with unhandled IRQs.

This also happens when unloading the usb-storage module beforehand.

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (pr=
og-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 000e0000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

lsusb:

Module                  Size  Used by
8139too                14336  1=20
mii                     2528  1 8139too
crc32                   2944  1 8139too
snd_ali5451            12004  0=20
snd_ac97_codec         32900  1 snd_ali5451
snd_pcm                53568  1 snd_ali5451
snd_page_alloc          3876  1 snd_pcm
snd_timer              13152  1 snd_pcm
snd                    27904  4 snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
soundcore               3680  1 snd
usb_storage            19232  0=20
scsi_mod               73132  1 usb_storage
ohci_hcd               11680  0=20
usbcore                65332  4 usb_storage,ohci_hcd
ohci1394               22720  0=20
ieee1394               42376  1 ohci1394

lsusb:

Bus 002 Device 001: ID 0000:0000 =20
Bus 001 Device 002: ID 054c:0069 Sony Corp. Memorystick MSC-U03 Reader
Bus 001 Device 001: ID 0000:0000 =20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+02JUUaz2rXW+gJcRAn0SAKCgu7EUxl07FEIhnW8VlbD76c15hwCgwTqe
v5n731qbkhNYcWtMKoXTbs4=
=m0in
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
