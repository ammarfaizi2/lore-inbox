Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264980AbSKFLmN>; Wed, 6 Nov 2002 06:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSKFLmN>; Wed, 6 Nov 2002 06:42:13 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:4371 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S264980AbSKFLmM>;
	Wed, 6 Nov 2002 06:42:12 -0500
Date: Wed, 6 Nov 2002 12:43:24 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: ohci no devices after suspend/resume
Message-ID: <20021106114324.GA22313@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am having the problem that sometimes after suspend/resume on a
Sony Vaio C1MHP the ohci usb driver does not discover new devices
anymore. I unload the module before suspend so i did not expect any
problems.

Linux paradigm 2.4.19 #1 Thu Oct 31 13:37:56 CET 2002 i586 unknown

2.4.19 + swsusp + acpi backport


dmesg output from loading the driver after a suspend:
usb-ohci.c: USB OHCI at membase 0xc00e0000, IRQ 9
usb-ohci.c: usb-00:14.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller (#=
2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF ca2fe2a0, numif 1
usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: c00e0000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface ca2fe2a0
usb.c: kusbd: /sbin/hotplug add 1


/proc/bus/usb/devices
T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB OHCI Root Hub
S:  SerialNumber=3Dc00e0000
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB OHCI Root Hub
S:  SerialNumber=3Dd005e000
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms

lspci -vv
[...]
00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (pr=
og-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80ec
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8016000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
[...]
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


Multiple remove/insert loops dont solve the problem. Something seems to
stay uninitialized ..

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9yQBcUaz2rXW+gJcRAn1SAKDSvvrHGV5pWv7l5r+mnSUVB8VpWwCfRHDD
Qew6MMhpTT47UlvE3rgO3w0=
=QDnj
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
