Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSKZM7V>; Tue, 26 Nov 2002 07:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSKZM7V>; Tue, 26 Nov 2002 07:59:21 -0500
Received: from comm-ext2.hcsd.de ([217.146.142.51]:4560 "EHLO
	comm-ext2.hcsd.de") by vger.kernel.org with ESMTP
	id <S264962AbSKZM7N>; Tue, 26 Nov 2002 07:59:13 -0500
From: Stephan Austermuehle <au@hcsd.de>
Date: Tue, 26 Nov 2002 14:06:29 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PCI Device not accessible (resource collisions)
Message-ID: <20021126130629.GA16298@hcsd.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I cannot load the driver modul aic7xxx for my onboard SCSI controller:

Nov 26 13:52:52 hopper kernel: PCI: Device 04:03.1 not available because of=
 resource collisions
Nov 26 13:52:52 hopper kernel: PCI: Device 04:03.0 not available because of=
 resource collisions

The SCSI controller is included on my Supermicro P4DL6 mainboard equiped
with 2 Intel Xeon processors.

System version information:

	Linux hopper 2.4.19-xfs #8 SMP Sat Nov 23 09:47:01 CET 2002 i686 Intel(R) =
XEON(TM) CPU 1.80GHz GenuineIntel GNU/Linux
	=20
	Gnu C                  2.95.4
	Gnu make               3.79.1
	util-linux             2.11n
	mount                  2.11n
	modutils               2.4.19
	e2fsprogs              1.30-WIP
	isdn4k-utils           3.1pre4
	Linux C Library        2.3.1
	Dynamic linker (ldd)   2.3.1
	Procps                 2.0.7
	Net-tools              1.60
	Console-tools          0.2.3
	Sh-utils               4.5.2
	Modules Loaded         nfsd lockd sunrpc serial isa-pnp parport_pc lp parp=
ort loop eepro100 ipv6 usb-ohci usbcore

Output of lspci -vvv:

	00:00.0 Host bridge: ServerWorks: Unknown device 0012 (rev 13)
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-

	00:00.1 Host bridge: ServerWorks: Unknown device 0012
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-

	00:00.2 Host bridge: ServerWorks: Unknown device 0000
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-

	00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (=
prog-if 00 [VGA])
		Subsystem: ATI Technologies Inc Rage XL
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing+ SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Latency: 64 (2000ns min), cache line size 10
		Interrupt: pin A routed to IRQ 29
		Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
		Region 1: I/O ports at a800 [size=3D256]
		Region 2: Memory at fe7ff000 (32-bit, non-prefetchable) [size=3D4K]
		Expansion ROM at fe7c0000 [disabled] [size=3D128K]
		Capabilities: [5c] Power Management version 2
			Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

	00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev=
 0d)
		Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Latency: 64 (2000ns min, 14000ns max), cache line size 10
		Interrupt: pin A routed to IRQ 30
		Region 0: Memory at fe7fd000 (32-bit, non-prefetchable) [size=3D4K]
		Region 1: I/O ports at af00 [size=3D64]
		Region 2: Memory at fe7a0000 (32-bit, non-prefetchable) [size=3D128K]
		Expansion ROM at fe7e0000 [disabled] [size=3D64K]
		Capabilities: [dc] Power Management version 2
			Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3co=
ld+)
			Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

	00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
		Subsystem: Unknown device d915:5538
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
		Latency: 64

	00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8=
a [Master SecP PriP])
		Subsystem: ServerWorks CSB5 IDE Controller
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Latency: 64, cache line size 08
		Region 0: I/O ports at 01f0 [size=3D8]
		Region 1: I/O ports at 03f4
		Region 2: I/O ports at 0170 [size=3D8]
		Region 3: I/O ports at 0374
		Region 4: I/O ports at ffa0 [size=3D16]

	00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05) (pro=
g-if 10 [OHCI])
		Subsystem: ServerWorks OSB4/CSB5 USB Controller
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR+
		Latency: 64 (20000ns max)
		Interrupt: pin A routed to IRQ 10
		Region 0: Memory at fe7fe000 (32-bit, non-prefetchable) [size=3D4K]

	00:0f.3 Host bridge: ServerWorks: Unknown device 0225
		Subsystem: Unknown device d915:5538
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Latency: 0

	00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
		Capabilities: [60] PCI-X non-bridge device.
			Command: DPERE- ERO- RBC=3D0 OST=3D4
			Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, =
DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
	00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
		Capabilities: [60] PCI-X non-bridge device.
			Command: DPERE- ERO- RBC=3D0 OST=3D4
			Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, =
DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
	00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
		Capabilities: [60] PCI-X non-bridge device.
			Command: DPERE- ERO- RBC=3D0 OST=3D4
			Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, =
DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
	00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
		Capabilities: [60] PCI-X non-bridge device.
			Command: DPERE- ERO- RBC=3D0 OST=3D4
			Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, =
DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
	01:03.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabi=
t Ethernet (rev 15)
		Subsystem: BROADCOM Corporation: Unknown device 1644
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Latency: 64 (16000ns min), cache line size 10
		Interrupt: pin A routed to IRQ 31
		Region 0: Memory at fe8f0000 (64-bit, non-prefetchable) [size=3D64K]
		Expansion ROM at fe8e0000 [disabled] [size=3D64K]
		Capabilities: [40] PCI-X non-bridge device.
			Command: DPERE- ERO+ RBC=3D0 OST=3D0
			Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple, =
DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-	Capabilities: [48] Power Managemen=
t version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3co=
ld+)
			Status: D0 PME-Enable+ DSel=3D0 DScale=3D1 PME-
		Capabilities: [50] Vital Product Data
		Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/3 Enabl=
e-
			Address: 6d73cb20ae86b01c  Data: 9201

	03:02.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT 6128R=
S/6528RS/6628RS
		Subsystem: ICP Vortex Computersysteme GmbH GDT 6128RS/6528RS/6628RS
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Latency: 64, cache line size 10
		Interrupt: pin A routed to IRQ 18
		Region 0: Memory at fc5fc000 (32-bit, prefetchable) [size=3D16K]
		Expansion ROM at feaf0000 [disabled] [size=3D32K]
		Capabilities: [80] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

	04:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
		Subsystem: Super Micro Computer Inc: Unknown device 9005
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Interrupt: pin A routed to IRQ 16
		BIST result: 00
		Region 0: I/O ports at <unassigned> [disabled]
		Region 1: Memory at <unassigned> (64-bit, non-prefetchable) [disabled]
		Capabilities: [dc] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

	04:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
		Subsystem: Super Micro Computer Inc: Unknown device 9005
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
		Interrupt: pin B routed to IRQ 17
		BIST result: 00
		Region 0: I/O ports at <unassigned> [disabled]
		Region 1: Memory at <unassigned> (64-bit, non-prefetchable) [disabled]
		Capabilities: [dc] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

There's a another SCSI controller in the system:

	Attached devices:=20
	Host: scsi0 Channel: 00 Id: 00 Lun: 00
	  Vendor: ICP      Model: Host Drive  #00  Rev:    =20
	  Type:   Direct-Access                    ANSI SCSI revision: 02
	Host: scsi0 Channel: 00 Id: 01 Lun: 00
	  Vendor: ICP      Model: Host Drive  #01  Rev:    =20
	  Type:   Direct-Access                    ANSI SCSI revision: 02

The problem is present in 2.4.18-xfs-1.1 as well.

What can I do to get the aic7xxx driver running so I can do backups of
my system?

Please let me know if I forgot to include any information.

Thanks for your help,

Stephan

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE943HV+QMu5be4tHkRAoLSAJ9V35lec88Pc0LDpCvWK/lkLRCR6gCffWQF
9/sqjbThUMjh7Ouy+XzYJR0=
=OpwH
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
