Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273610AbRIQNHr>; Mon, 17 Sep 2001 09:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273609AbRIQNH3>; Mon, 17 Sep 2001 09:07:29 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:22533 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S273603AbRIQNHJ>; Mon, 17 Sep 2001 09:07:09 -0400
Message-ID: <2CE33F05597DD411AAE800D0B769587C04EA05FA@sryoung.lss.emc.com>
From: "conway, heather" <conway_heather@emc.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: v2.4.9 and sequential scan
Date: Mon, 17 Sep 2001 09:07:25 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C13F79.B2094830"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C13F79.B2094830
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Alan,
I tried two separate hosts, one with the aic7xxx driver using the AHA-2944UW
and one with the qla2x00 driver, both running v2.4.9 attached to external
storage.  Both hosts are set to 128 for the max # of SCSI disks top be
laoded as modules and the kernel has been compiled, but no other patches or
tweaks were applied to the kernel.  Both hosts panicked upon boot when
trying to scan the external bus.  
The host attached to the external storage via SCSI (aic7xxx) has The host
attached via FC with the qla2x00 has only 24 devices assigned to it.  The
qla2x00 driver reports trying to scan up to LUN 509 before timing out and
panicking.  I have tried this a few times and I've seen the host scan up to
LUN 814 with the qla2x00 driver.  I obtained a serial console trace from
both hosts and have enclosed them.
Any thoughts?  
Thanks for the help.
Heather

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Thursday, September 06, 2001 8:20 AM
To: conway, heather
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.4.9 and sequential scan


> panicking because it times out trying to scan for all of the LUNs.  Same
> thing goes for another host using the Qlogic qla2x00 driver.  
> Is there any timeframe for a change from sequential scanning in v2.4.x or
is
> there a work around so the hosts don't panic if they're attached to
external
> storage?

It shouldnt be panicing. Scanning is a legal scsi operation. If someone
wants to test and provide proper report luns code I'll be happy to test it
out in the -ac series then feed it on to Linus once stable


------_=_NextPart_000_01C13F79.B2094830
Content-Type: application/octet-stream;
	name="70qlogic"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="70qlogic"

Linux version 2.4.9 (root@l82bc070.lss.emc.com) (gcc version 2.96 =
20000731 (Red Hat Linux 7.0)) #1 SMP Thu Sep 13 13:13:34 EDT 2001=0A=
=0DBIOS-provided physical RAM map:=0A=
=0D BIOS-e820: 0000000000000000 - 000000000009f000 (usable)=0A=
=0D BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)=0A=
=0D BIOS-e820: 00000000000e8800 - 0000000000100000 (reserved)=0A=
=0D BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)=0A=
=0D BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)=0A=
=0D BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)=0A=
=0D BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)=0A=
=0D BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)=0A=
=0D BIOS-e820: 00000000fffe8800 - 0000000100000000 (reserved)=0A=
=0DScan SMP from c0000000 for 1024 bytes.=0A=
=0DScan SMP from c009fc00 for 1024 bytes.=0A=
=0DScan SMP from c00f0000 for 65536 bytes.=0A=
=0Dfound SMP MP-table at 000f6e10=0A=
=0Dhm, page 000f6000 reserved twice.=0A=
=0Dhm, page 000f7000 reserved twice.=0A=
=0Dhm, page 0009f000 reserved twice.=0A=
=0Dhm, page 000a0000 reserved twice.=0A=
=0DOn node 0 totalpages: 65520=0A=
=0Dzone(0): 4096 pages.=0A=
=0Dzone(1): 61424 pages.=0A=
=0Dzone(2): 0 pages.=0A=
=0DIntel MultiProcessor Specification v1.4=0A=
=0D    Virtual Wire compatibility mode.=0A=
=0DOEM ID: HP       Product ID: LH 4         APIC at: 0xFEE00000=0A=
=0DProcessor #1 Pentium(tm) Pro APIC version 17=0A=
=0D    Floating point unit present.=0A=
=0D    Machine Exception supported.=0A=
=0D    64 bit compare & exchange supported.=0A=
=0D    Internal APIC present.=0A=
=0D    SEP present.=0A=
=0D    MTRR  present.=0A=
=0D    PGE  present.=0A=
=0D    MCA  present.=0A=
=0D    CMOV  present.=0A=
=0D    PAT  present.=0A=
=0D    PSE  present.=0A=
=0D    PSN  present.=0A=
=0D    MMX  present.=0A=
=0D    FXSR  present.=0A=
=0D    XMM  present.=0A=
=0D    Bootup CPU=0A=
=0DProcessor #0 Pentium(tm) Pro APIC version 17=0A=
=0D    Floating point unit present.=0A=
=0D    Machine Exception supported.=0A=
=0D    64 bit compare & exchange supported.=0A=
=0D    Internal APIC present.=0A=
=0D    SEP present.=0A=
=0D    MTRR  present.=0A=
=0D    PGE  present.=0A=
=0D    MCA  present.=0A=
=0D    CMOV  present.=0A=
=0D    PAT  present.=0A=
=0D    PSE  present.=0A=
=0D    PSN  present.=0A=
=0D    MMX  present.=0A=
=0D    FXSR  present.=0A=
=0D    XMM  present.=0A=
=0DBus #0 is PCI   =0A=
=0DBus #1 is PCI   =0A=
=0DBus #2 is PCI   =0A=
=0DBus #3 is ISA   =0A=
=0DI/O APIC #2 Version 17 at 0xFEC00000.=0A=
=0DInt: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID 2, APIC INT 00=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 01, APIC ID 2, APIC INT 01=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 00, APIC ID 2, APIC INT 02=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 03, APIC ID 2, APIC INT 03=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 04, APIC ID 2, APIC INT 04=0A=
=0DInt: type 0, pol 1, trig 3, bus 3, IRQ 05, APIC ID 2, APIC INT 05=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 06, APIC ID 2, APIC INT 06=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 07, APIC ID 2, APIC INT 07=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 08, APIC ID 2, APIC INT 08=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 09, APIC ID 2, APIC INT 09=0A=
=0DInt: type 0, pol 1, trig 3, bus 3, IRQ 0a, APIC ID 2, APIC INT 0a=0A=
=0DInt: type 0, pol 1, trig 3, bus 3, IRQ 0b, APIC ID 2, APIC INT 0b=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 0c, APIC ID 2, APIC INT 0c=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 0d, APIC ID 2, APIC INT 0d=0A=
=0DInt: type 0, pol 1, trig 1, bus 3, IRQ 0e, APIC ID 2, APIC INT 0e=0A=
=0DInt: type 0, pol 1, trig 3, bus 3, IRQ 0f, APIC ID 2, APIC INT 0f=0A=
=0DInt: type 0, pol 1, trig 3, bus 0, IRQ 08, APIC ID 2, APIC INT 0a=0A=
=0DInt: type 0, pol 1, trig 3, bus 0, IRQ 10, APIC ID 2, APIC INT 0b=0A=
=0DInt: type 0, pol 1, trig 3, bus 1, IRQ 08, APIC ID 2, APIC INT 0b=0A=
=0DInt: type 0, pol 1, trig 3, bus 1, IRQ 0c, APIC ID 2, APIC INT 0b=0A=
=0DInt: type 0, pol 1, trig 3, bus 1, IRQ 18, APIC ID 2, APIC INT 0f=0A=
=0DInt: type 0, pol 1, trig 3, bus 1, IRQ 1c, APIC ID 2, APIC INT 0f=0A=
=0DInt: type 0, pol 1, trig 3, bus 2, IRQ 08, APIC ID 2, APIC INT 05=0A=
=0DLint: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID ff, APIC LINT =
00=0A=
=0DLint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT =
01=0A=
=0DProcessors: 2=0A=
=0Dmapped APIC to ffffe000 (fee00000)=0A=
=0Dmapped IOAPIC to ffffd000 (fec00000)=0A=
=0DKernel command line: BOOT_IMAGE=3Dlinux-2.4.9 ro root=3D801 =
BOOT_FILE=3D/boot/vmlinuz-2.4.9 console=3DttyS0,115200=0A=
=0DInitializing CPU#0=0A=
=0DDetected 550.042 MHz processor.=0A=
=0DConsole: colour VGA+ 80x25=0A=
=0DCalibrating delay loop... 1097.72 BogoMIPS=0A=
=0DMemory: 254216k/262080k available (1393k kernel code, 7476k =
reserved, 525k data, 236k init, 0k highmem)=0A=
=0DDentry-cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
=0DInode-cache hash table entries: 16384 (order: 5, 131072 bytes)=0A=
=0DMount-cache hash table entries: 4096 (order: 3, 32768 bytes)=0A=
=0DBuffer-cache hash table entries: 16384 (order: 4, 65536 bytes)=0A=
=0DPage-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0A=
=0DCPU: L2 cache: 512K=0A=
=0DIntel machine check architecture supported.=0A=
=0DIntel machine check reporting enabled on CPU#0.=0A=
=0DCPU serial number disabled.=0A=
=0DEnabling fast FPU save and restore... done.=0A=
=0DEnabling unmasked SIMD FPU exception support... done.=0A=
=0DChecking 'hlt' instruction... OK.=0A=
=0DPOSIX conformance testing by UNIFIX=0A=
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0A=
=0DCPU: L2 cache: 512K=0A=
=0DIntel machine check reporting enabled on CPU#0.=0A=
=0DCPU0: Intel Pentium III (Katmai) stepping 03=0A=
=0Dper-CPU timeslice cutoff: 1462.55 usecs.=0A=
=0DGetting VERSION: 40011=0A=
=0DGetting VERSION: 40011=0A=
=0DGetting ID: 1000000=0A=
=0DGetting ID: e000000=0A=
=0DGetting LVT0: 700=0A=
=0DGetting LVT1: 400=0A=
=0Denabled ExtINT on CPU#0=0A=
=0DESR value before enabling vector: 00000000=0A=
=0DESR value after enabling vector: 00000000=0A=
=0DCPU present map: 3=0A=
=0DBooting processor 1/0 eip 2000=0A=
=0DSetting warm reset code and vector.=0A=
=0D1.=0A=
=0D2.=0A=
=0D3.=0A=
=0DAsserting INIT.=0A=
=0DWaiting for send to finish...=0A=
=0D+Deasserting INIT.=0A=
=0DWaiting for send to finish...=0A=
=0D+#startup loops: 2.=0A=
=0DSending STARTUP #1.=0A=
=0DAfter apic_write.=0A=
=0DInitializing CPU#1=0A=
=0DStartup point 1.=0A=
=0DCPU#1 (phys ID: 0) waiting for CALLOUT=0A=
=0DWaiting for send to finish...=0A=
=0D+Sending STARTUP #2.=0A=
=0DAfter apic_write.=0A=
=0DStartup point 1.=0A=
=0DWaiting for send to finish...=0A=
=0D+After Startup.=0A=
=0DBefore Callout 1.=0A=
=0DAfter Callout 1.=0A=
=0DCALLIN, before setup_local_APIC().=0A=
=0Dmasked ExtINT on CPU#1=0A=
=0DESR value before enabling vector: 00000000=0A=
=0DESR value after enabling vector: 00000000=0A=
=0DCalibrating delay loop... 1097.72 BogoMIPS=0A=
=0DStack at about c1457fb8=0A=
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0A=
=0DCPU: L2 cache: 512K=0A=
=0DIntel machine check reporting enabled on CPU#1.=0A=
=0DCPU serial number disabled.=0A=
=0DOK.=0A=
=0DCPU1: Intel Pentium III (Katmai) stepping 03=0A=
=0DCPU has booted.=0A=
=0DBefore bogomips.=0A=
=0DTotal of 2 processors activated (2195.45 BogoMIPS).=0A=
=0DBefore bogocount - setting activated=3D1.=0A=
=0DBoot done.=0A=
=0DENABLING IO-APIC IRQs=0A=
=0D...changing IO-APIC physical APIC ID to 2 ... ok.=0A=
=0DSynchronizing Arb IDs.=0A=
=0D..TIMER: vector=3D31 pin1=3D2 pin2=3D0=0A=
=0D..MP-BIOS bug: 8254 timer not connected to IO-APIC=0A=
=0D...trying to set up timer (IRQ0) through the 8259A ... =0A=
=0D..... (found pin 0) ...works.=0A=
=0Dtesting the IO APIC.......................=0A=

=0D.................................... done.=0A=
=0Dcalibrating APIC timer ...=0A=
=0D..... CPU clock speed is 550.0507 MHz.=0A=
=0D..... host bus clock speed is 100.0089 MHz.=0A=
=0Dcpu: 0, clocks: 1000089, slice: 333363=0A=
=0DCPU0<T0:1000080,T1:666704,D:13,S:333363,C:1000089>=0A=
=0Dcpu: 1, clocks: 1000089, slice: 333363=0A=
=0DCPU1<T0:1000080,T1:333344,D:10,S:333363,C:1000089>=0A=
=0Dchecking TSC synchronization across CPUs: passed.=0A=
=0DSetting commenced=3D1, go go go=0A=
=0DPCI: PCI BIOS revision 2.10 entry at 0xfdab2, last bus=3D2=0A=
=0DPCI: Using configuration type 1=0A=
=0DPCI: Probing PCI hardware=0A=
=0DPCI: Searching for i450NX host bridges on 00:10.0=0A=
=0DUnknown bridge resource 2: assuming transparent=0A=
=0DUnknown bridge resource 2: assuming transparent=0A=
=0DPCI: Using IRQ router PIIX [8086/7110] at 00:0f.0=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:2, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B0,I2,P0) -> 10=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:4, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B0,I4,P0) -> 11=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:15, pin:3.=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:2, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I2,P0) -> 11=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:3, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I3,P0) -> 11=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:6, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I6,P0) -> 15=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:7, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I7,P0) -> 15=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:2, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I2,P0) -> 11=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:3, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I3,P0) -> 11=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:6, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I6,P0) -> 15=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:7, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B1,I7,P0) -> 15=0A=
=0Dquerying PCI -> IRQ mapping bus:2, slot:2, pin:0.=0A=
=0DPCI->APIC IRQ transform: (B2,I2,P0) -> 5=0A=
=0DPCI: Cannot allocate resource region 0 of device 01:02.0=0A=
=0DPCI: Cannot allocate resource region 1 of device 01:02.0=0A=
=0DPCI: Cannot allocate resource region 0 of device 01:03.0=0A=
=0DPCI: Cannot allocate resource region 1 of device 01:03.0=0A=
=0DPCI: Cannot allocate resource region 0 of device 01:06.0=0A=
=0DPCI: Cannot allocate resource region 1 of device 01:06.0=0A=
=0DPCI: Cannot allocate resource region 2 of device 01:06.0=0A=
=0DPCI: Cannot allocate resource region 0 of device 01:07.0=0A=
=0DPCI: Cannot allocate resource region 1 of device 01:07.0=0A=
=0DPCI: Cannot allocate resource region 2 of device 01:07.0=0A=
=0D  got res[1400:14ff] for resource 0 of Adaptec AHA-294x / =
AIC-7884U=0A=
=0D  got res[10000000:10000fff] for resource 1 of Adaptec AHA-294x / =
AIC-7884U=0A=
=0D  got res[1800:18ff] for resource 0 of Adaptec AHA-294x / AIC-7884U =
(#2)=0A=
=0D  got res[10001000:10001fff] for resource 1 of Adaptec AHA-294x / =
AIC-7884U (#2)=0A=
=0D  got res[1c00:1cff] for resource 0 of Symbios Logic Inc. (formerly =
NCR) 53c895=0A=
=0D  got res[10002000:100020ff] for resource 1 of Symbios Logic Inc. =
(formerly NCR) 53c895=0A=
=0D  got res[10003000:10003fff] for resource 2 of Symbios Logic Inc. =
(formerly NCR) 53c895=0A=
=0D  got res[2000:20ff] for resource 0 of Symbios Logic Inc. (formerly =
NCR) 53c895 (#2)=0A=
=0D  got res[10002100:100021ff] for resource 1 of Symbios Logic Inc. =
(formerly NCR) 53c895 (#2)=0A=
=0D  got res[10004000:10004fff] for resource 2 of Symbios Logic Inc. =
(formerly NCR) 53c895 (#2)=0A=
=0Disapnp: Scanning for PnP cards...=0A=
=0Disapnp: No Plug & Play device found=0A=
=0DLinux NET4.0 for Linux 2.4=0A=
=0DBased upon Swansea University Computer Society NET3.039=0A=
=0DStarting kswapd v1.8=0A=
=0Dpty: 256 Unix98 ptys configured=0A=
=0DSerial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI ISAPNP enabled=0A=
=0DttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0A=
=0DttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0A=
=0Dblock: 128 slots per queue, batch=3D16=0A=
=0DRAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize=0A=
=0DUniform Multi-Platform E-IDE driver Revision: 6.31=0A=
=0Dide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
=0DPIIX4: IDE controller on PCI bus 00 dev 79=0A=
=0DPIIX4: chipset revision 1=0A=
=0DPIIX4: not 100% native mode: will probe irqs later=0A=
=0D    ide0: BM-DMA at 0x9420-0x9427, BIOS settings: hda:pio, =
hdb:pio=0A=
=0DPIIX4: IDE controller on PCI bus 00 dev 80=0A=
=0DPIIX4: device not capable of full native PCI mode=0A=
=0DPIIX4: device disabled (BIOS)=0A=
=0Dhda: HITACHI CDR-8435, ATAPI CD/DVD-ROM drive=0A=
=0Dide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
=0Dhda: ATAPI 32X CD-ROM drive, 128kB Cache, DMA=0A=
=0DUniform CD-ROM driver Revision: 3.12=0A=
=0DFloppy drive(s): fd0 is 1.44M=0A=
=0DFDC 0 is a National Semiconductor PC87306=0A=
=0Dloop: loaded (max 8 devices)=0A=
=0Deepro100.c:v1.09j-t 9/29/99 Donald Becker =
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html=0A=
=0Deepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. =
Savochkin <saw@saw.sw.com.sg> and others=0A=
=0Deth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:3E:46:DA, IRQ =
5.=0A=
=0D  Board assembly 733470-004, Physical connectors present: RJ45=0A=
=0D  Primary interface chip i82555 PHY #1.=0A=
=0D  General self-test: passed.=0A=
=0D  Serial sub-system self-test: passed.=0A=
=0D  Internal registers self-test: passed.=0A=
=0D  ROM checksum self-test: passed (0x04f4518b).=0A=
=0DLinux agpgart interface v0.99 (c) Jeff Hartmann=0A=
=0Dagpgart: Maximum main memory to use for agp memory: 203M=0A=
=0D[drm] Initialized tdfx 1.0.0 20010216 on minor 0=0A=
=0D[drm] Initialized radeon 1.1.1 20010405 on minor 1=0A=
=0DSCSI subsystem driver Revision: 1.00=0A=
=0Dsym53c8xx: at PCI bus 1, device 6, function 0=0A=
=0Dsym53c8xx: 53c895 detected =0A=
=0Dsym53c8xx: at PCI bus 1, device 7, function 0=0A=
=0Dsym53c8xx: 53c895 detected =0A=
=0Dsym53c895-0: rev 0x1 on pci bus 1 device 6 function 0 irq 15=0A=
=0Dsym53c895-0: ID 7, Fast-40, Parity Checking=0A=
=0DCACHE TEST FAILED: reg dstat-sstat2 readback ffffffff.=0A=
=0DCACHE INCORRECTLY CONFIGURED.=0A=
=0Dsym53c895-0: giving up ...=0A=
=0Dsym53c895-0: rev 0x1 on pci bus 1 device 7 function 0 irq 15=0A=
=0Dsym53c895-0: ID 7, Fast-40, Parity Checking=0A=
=0DCACHE TEST FAILED: reg dstat-sstat2 readback ffffffff.=0A=
=0DCACHE INCORRECTLY CONFIGURED.=0A=
=0Dsym53c895-0: giving up ...=0A=
=0Drequest_module[scsi_hostadapter]: Root fs not mounted=0A=
=0Drequest_module[scsi_hostadapter]: Root fs not mounted=0A=
=0Drequest_module[scsi_hostadapter]: Root fs not mounted=0A=
=0Drequest_module[scsi_hostadapter]: Root fs not mounted=0A=
=0Drequest_module[scsi_hostadapter]: Root fs not mounted=0A=
=0DNET4: Linux TCP/IP 1.0 for NET4.0=0A=
=0DIP Protocols: ICMP, UDP, TCP, IGMP=0A=
=0DIP: routing cache hash table of 2048 buckets, 16Kbytes=0A=
=0DTCP: Hash tables configured (established 16384 bind 16384)=0A=
=0DNET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
=0DRAMDISK: Compressed image found at block 0=0A=
=0DFreeing initrd memory: 627k freed=0A=
=0DVFS: Mounted root (ext2 filesystem).=0A=
=0DLoading aic7xxx module
aic7xxx: PCI Device 1:2:0 failed memory mapped test=0A=
=0Dahc_pci:1:2:0: No SCB space found=0A=
=0DTrying to free free IRQ11=0A=
=0Daic7xxx: PCI Device 1:3:0 failed memory mapped test=0A=
=0Dahc_pci:1:3:0: No SCB space found=0A=
=0DTrying to free free IRQ11=0A=
=0DPCI: Enabling device 01:02.0 (0155 -> 0157)=0A=
=0Daic7xxx: PCI Device 1:2:0 failed memory mapped test=0A=
=0Dahc_pci:1:2:0: No SCB space found=0A=
=0DTrying to free free IRQ11=0A=
=0DPCI: Enabling device 01:03.0 (0155 -> 0157)=0A=
=0Daic7xxx: PCI Device 1:3:0 failed memory mapped test=0A=
=0Dahc_pci:1:3:0: No SCB space found=0A=
=0DTrying to free free IRQ11=0A=
=0D/lib/aic7xxx.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, =
including invalid IO or IRQ parameters
Loading qla2x00 module
qla2x00: detect() found an HBA=0A=
=0Dqla2x00: VID=3D1077 DID=3D2200 SSVID=3D1077 SSDID=3D2=0A=
=0D(scsi): Found a QLA2200  @ bus 0, device 0x4, irq 11, iobase =
0x9000=0A=
=0Dscsi(0): Configure NVRAM parameters...=0A=
=0Dscsi(0): Verifying loaded RISC code...=0A=
=0Dscsi(0): Verifying chip...=0A=
=0Dscsi(0): Waiting for LIP to complete...=0A=
=0Dscsi(0): LOOP UP detected=0A=
=0Dscsi0: Topology - (F_Port), Host Loop address  0xffff=0A=
=0Dscsi(0): Waiting for LIP to complete...=0A=
=0Dscsi0: Topology - (F_Port), Host Loop address  0xffff=0A=
=0Dscsi-qla0-adapter-node=3D200000e08b019d84;=0A=
=0Dscsi-qla0-adapter-port=3D210000e08b019d84;=0A=
=0Dscsi-qla0-target-0=3D50060482c3a0842b;=0A=
=0Dscsi0 : QLogic QLA2200 PCI to Fibre Channel Host Adapter: bus 0 =
device 4 irq 11=0A=
=0D        Firmware version:  2.01.34, Driver version 4.31.12=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5568=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 255 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 256 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 257 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 258 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 259 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 260 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 261 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 262 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 263 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 264 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 265 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 266 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 267 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 268 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 269 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 270 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 271 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 272 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 273 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 274 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 275 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 276 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 277 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 278 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 279 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 280 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 281 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 282 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 283 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 284 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 285 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 286 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 287 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 288 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 289 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 290 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 291 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 292 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 293 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 294 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 295 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 296 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 297 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 298 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 299 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 300 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 301 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 302 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 303 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 304 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 305 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 306 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 307 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 308 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 309 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 310 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 311 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 312 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 313 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 314 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 315 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 316 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 317 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 318 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 319 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 320 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 321 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 322 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 323 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 324 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 325 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 326 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 327 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 328 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 329 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 330 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 331 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 332 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 333 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 334 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 335 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 336 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 337 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 338 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 339 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 340 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 341 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 342 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 343 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 344 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 345 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 346 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 347 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 348 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 349 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 350 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 351 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 352 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 353 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 354 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 355 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 356 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 357 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 358 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 359 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 360 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 361 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 362 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 363 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 364 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 365 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 366 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 367 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 368 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 369 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 370 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 371 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 372 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 373 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 374 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 375 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 376 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 377 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 378 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 379 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 380 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 381 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 382 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 383 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 384 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 385 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 386 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 387 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 388 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 389 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 390 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 391 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 392 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 393 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 394 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 395 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 396 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 397 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 398 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 399 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 400 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 401 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 402 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 403 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 404 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 405 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 406 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 407 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 408 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 409 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 410 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 411 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 412 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 413 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 414 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 415 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 416 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 417 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 418 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 419 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 420 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 421 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 422 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 423 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 424 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 425 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 426 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 427 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 428 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 429 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 430 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 431 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 432 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 433 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 434 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 435 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 436 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 437 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 438 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 439 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 440 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 441 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 442 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 443 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 444 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 445 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 446 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 447 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 448 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 449 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 450 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 451 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 452 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 453 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 454 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 455 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 456 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 457 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 458 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 459 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 460 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 461 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 462 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 463 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 464 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 465 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 466 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 467 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 468 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 469 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 470 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 471 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 472 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 473 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 474 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 475 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 476 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 477 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 478 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 479 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 480 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 481 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 482 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 483 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 484 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 485 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 486 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 487 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 488 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 489 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 490 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 491 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 492 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 493 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 494 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 495 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 496 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 497 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 498 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 499 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 500 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 501 Inquiry a0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 502 Inquiry c0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 503 Inquiry e0 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 504 Inquiry 00 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 505 Inquiry 20 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 506 Inquiry 40 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 507 Inquiry 60 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 508 Inquiry 80 00 00 ff 00 =0A=
=0Dscsi : aborting command due to timeout : pid 0, scsi0, channel 0, id =
0, lun 509 Inquiry a0 00 00 ff 00 =0A=
=0DUnable to handle kernel NULL pointer dereference at virtual address =
0000000c=0A=
=0D printing eip:=0A=
=0Dd082ada8=0A=
=0D*pde =3D 00000000=0A=
=0DOops: 0000=0A=
=0DCPU:    1=0A=
=0DEIP:    0010:[<d082ada8>]=0A=
=0DEFLAGS: 00010046=0A=
=0Deax: 00000010   ebx: cfbf007c   ecx: 00000401   edx: 00000004=0A=
=0Desi: cfb5f350   edi: cfb5f200   ebp: 00000000   esp: c1515c0c=0A=
=0Dds: 0018   es: 0018   ss: 0018=0A=
=0DProcess insmod (pid: 11, stackpage=3Dc1515000)=0A=
=0DStack: 000001fe 00000000 00000246 cff219f4 cfbf0000 cfb5f200 =
c01d828e cfb5f200 =0A=
=0D       c01dd4e0 00000000 cfb5f200 cff219f4 cfb5f2ac cff219f4 =
c01deda3 cfb5f200 =0A=
=0D       cfb5f200 00000000 cfbf0000 cfba7a00 cff219a0 c01deaa0 =
00000286 c1515cc4 =0A=
=0DCall Trace: [<c01d828e>] [<c01dd4e0>] [<c01deda3>] [<c01deaa0>] =
[<c01de1ee>] =0A=
=0D   [<c01de24a>] [<c01d8364>] [<c01d7db0>] [<c01e1cb3>] [<c01deaa0>] =
[<c01a3c06>] =0A=
=0D   [<c01a5310>] [<c01a5460>] [<c01e1ad6>] [<c010f270>] [<c0114345>] =
[<d0871c40>] =0A=
=0D   [<c01d9343>] [<d0833017>] [<d0871c40>] [<d0871c40>] [<c0115165>] =
[<d0828060>] =0A=
=0D   [<c0107107>] =0A=

=0DCode: f6 42 08 04 74 12 56 53 e8 2b 13 00 00 5d 31 c0 5a eb 5d 90 =
=0A=
=0Dpid 11: killed by signal 11
kmod: failed to exec /sbin/modprobe -s -k block-major-8, errno =3D 2=0A=
=0DVFS: Cannot open root device "801" or 08:01=0A=
=0DPlease append a correct "root=3D" boot option=0A=
=0DKernel panic: VFS: Unable to mount root fs on 08:01=0A=

------_=_NextPart_000_01C13F79.B2094830
Content-Type: application/octet-stream;
	name="67capt2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="67capt2"

Linux version 2.4.9 (root@l82bc067.lss.emc.com) (gcc version =
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 SMP Wed Sep 12 =
17:47:02 EDT 2001=0A=
=0DBIOS-provided physical RAM map:=0A=
=0D BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
=0D BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
=0D BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)=0A=
=0D BIOS-e820: 0000000000100000 - 0000000020000000 (usable)=0A=
=0D BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)=0A=
=0D BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)=0A=
=0DScan SMP from c0000000 for 1024 bytes.=0A=
=0DScan SMP from c009fc00 for 1024 bytes.=0A=
=0DScan SMP from c00f0000 for 65536 bytes.=0A=
=0Dfound SMP MP-table at 000fdb90=0A=
=0Dhm, page 000fd000 reserved twice.=0A=
=0Dhm, page 000fe000 reserved twice.=0A=
=0Dhm, page 0009f000 reserved twice.=0A=
=0Dhm, page 000a0000 reserved twice.=0A=
=0DOn node 0 totalpages: 131072=0A=
=0Dzone(0): 4096 pages.=0A=
=0Dzone(1): 126976 pages.=0A=
=0Dzone(2): 0 pages.=0A=
=0DIntel MultiProcessor Specification v1.4=0A=
=0D    Virtual Wire compatibility mode.=0A=
=0DOEM ID: SNI D992 Product ID: PRIMERGY     APIC at: 0xFEE00000=0A=
=0DProcessor #1 Pentium(tm) Pro APIC version 17=0A=
=0D    Floating point unit present.=0A=
=0D    Machine Exception supported.=0A=
=0D    64 bit compare & exchange supported.=0A=
=0D    Internal APIC present.=0A=
=0D    SEP present.=0A=
=0D    MTRR  present.=0A=
=0D    PGE  present.=0A=
=0D    MCA  present.=0A=
=0D    CMOV  present.=0A=
=0D    MMX  present.=0A=
=0D    Bootup CPU=0A=
=0DProcessor #0 Pentium(tm) Pro APIC version 17=0A=
=0D    Floating point unit present.=0A=
=0D    Machine Exception supported.=0A=
=0D    64 bit compare & exchange supported.=0A=
=0D    Internal APIC present.=0A=
=0D    SEP present.=0A=
=0D    MTRR  present.=0A=
=0D    PGE  present.=0A=
=0D    MCA  present.=0A=
=0D    CMOV  present.=0A=
=0D    MMX  present.=0A=
=0DBus #0 is PCI   =0A=
=0DBus #1 is PCI   =0A=
=0DBus #2 is ISA   =0A=
=0DI/O APIC #2 Version 17 at 0xFEC00000.=0A=
=0DInt: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID 2, APIC INT 00=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e=0A=
=0DInt: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f=0A=
=0DLint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT =
00=0A=
=0DLint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT =
01=0A=
=0DProcessors: 2=0A=
=0Dmapped APIC to ffffe000 (fee00000)=0A=
=0Dmapped IOAPIC to ffffd000 (fec00000)=0A=
=0DKernel command line: BOOT_IMAGE=3Dlinux-2.4.9 ro root=3D801 =
console=3DttyS0,115200 aic7xxx=3Dverbose=0A=
=0DInitializing CPU#0=0A=
=0DDetected 299.154 MHz processor.=0A=
=0DConsole: colour VGA+ 80x25=0A=
=0DCalibrating delay loop... 596.37 BogoMIPS=0A=
=0DMemory: 512196k/524288k available (1481k kernel code, 11704k =
reserved, 557k data, 236k init, 0k highmem)=0A=
=0DDentry-cache hash table entries: 65536 (order: 7, 524288 bytes)=0A=
=0DInode-cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
=0DMount-cache hash table entries: 8192 (order: 4, 65536 bytes)=0A=
=0DBuffer-cache hash table ender: 7, 524288 bytes)=0A=
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0A=
=0DCPU: L2 cache: 512K=0A=
=0DIntel machine check architecture supported.=0A=
=0DIntel machine check reporting enabled on CPU#0.=0A=
=0DChecking 'hlt' instruction... OK.=0A=
=0DPOSIX conformance testing by UNIFIX=0A=
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0A=
=0DCPU: L2 cache: 512K=0A=
=0DIntel machine check reporting enabled on CPU#0.=0A=
=0DCPU0: Intel Pentium II (Klamath) stepping 04=0A=
=0Dper-CPU timeslice cutoff: 1462.89 usecs.=0A=
=0DGetting VERSION: 40011=0A=
=0DGetting VERSION: 40011=0A=
=0DGetting ID: 1000000=0A=
=0DGetting ID: e000000=0A=
=0DGetting LVT0: 700=0A=
=0DGetting LVT1: 400=0A=
=0Denabled ExtINT on CPU#0=0A=
=0DESR value before enabling vector: 00000000=0A=
=0DESR value after enabling vector: 00000000=0A=
=0DCPU present map: 3=0A=
=0DBooting processor 1/0 eip 2000=0A=
=0DSetting warm reset code and vector.=0A=
=0D1.=0A=
=0D2.=0A=
=0D3.=0A=
=0DAsserting INIT.=0A=
=0DWaiting for send to finish...=0A=
=0D+Deasserting INIT.=0A=
=0DWaiting for send to finish...=0A=
=0D+#startup loops: 2.=0A=
=0DSending STARTUP #1.=0A=
=0DAfter apic_write.=0A=
=0DInitializing CPU#1=0A=
=0DStartup point 1.=0A=
=0DCPU#1 (phys ID: 0) waiting for CALLOUT=0A=
=0DWaiting for send to finish...=0A=
=0D+Sending STARTUP #2.=0A=
=0DAfter apic_write.=0A=
=0DStartup point 1.=0A=
=0DWaiting for send to finish...=0A=
=0D+After Startup.=0A=
=0DBefore Callout 1.=0A=
=0DAfter Callout 1.=0A=
=0DCALLIN, before setup_local_APIC().=0A=
=0Dmasked ExtINT on CPU#1=0A=
=0DESR value before enabling vector: 00000000=0A=
=0DESR value after enabling vector: 00000000=0A=
=0DCalibrating delay loop... 598.01 BogoMIPS=0A=
=0DStack at about dfffdfbc=0A=
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0A=
=0DCPU: L2 cache: 512K=0A=
=0DIntel machine check reporting enabled on CPU#1.=0A=
=0DOK.=0A=
=0DCPU1: Intel Pentium II (Klamath) stepping 04=0A=
=0DCPU has booted.=0A=
=0DBefore bogomips.=0A=
=0DTotal of 2 processors activated (1194.39 BogoMIPS).=0A=
=0DBefore bogocount - setting activated=3D1.=0A=
=0DBoot done.=0A=
=0DENABLING IO-APIC IRQs=0A=
=0D...changing IO-APIC physical APIC ID to 2 ... ok.=0A=
=0DSynchronizing Arb IDs.=0A=
=0D..TIMER: vector=3D31 pin1=3D2 pin2=3D0=0A=
=0Dtesting the IO APIC.......................=0A=

=0D.................................... done.=0A=
=0Dcalibrating APIC timer ...=0A=
=0D..... CPU clock speed is 299.1577 MHz.=0A=
=0D..... host bus clock speed is 66.4793 MHz.=0A=
=0Dcpu: 0, clocks: 664793, slice: 221597=0A=
=0DCPU0<T0:664784,T1:443184,D:3,S:221597,C:664793>=0A=
=0Dcpu: 1, clocks: 664793, slice: 221597=0A=
=0DCPU1<T0:664784,T1:221584,D:6,S:221597,C:664793>=0A=
=0Dchecking TSC synchronization across CPUs: passed.=0A=
=0DSetting commenced=3D1, go go go=0A=
=0DPCI: PCI BIOS revision 2.10 entry at 0xf6893, last bus=3D1=0A=
=0DPCI: Using configuration type 1=0A=
=0DPCI: Probing PCI hardware=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:13, pin:0.=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:1, pin:0.=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:3, pin:1.=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:8, pin:0.=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:3, pin:0.=0A=
=0Dquerying PCI -> IRQ mapping bus:1, slot:9, pin:0.=0A=
=0Dquerying PCI -> IRQ mapping bus:0, slot:3, pin:1.=0A=
=0DPCI: Cannot allocate resource region 0 of device 00:02.0=0A=
=0DPCI: Error while updating region 00:02.0/0 (20000000 !=3D =
fec00000)=0A=
=0D  got res[20000000:200003ff] for resource 0 of PCI device 110a:0015 =
(Siemens Nixdorf AG)=0A=
=0DLimiting direct PCI/PCI transfers.=0A=
=0DActivating ISA DMA hang workarounds.=0A=
=0Disapnp: Scanning for PnP cards...=0A=
=0Disapnp: Card 'Adaptec AHA-1510B'=0A=
=0Disapnp: 1 Plug & Play card detected total=0A=
=0DLinux NET4.0 for Linux 2.4=0A=
=0DBased upon Swansea University Computer Society NET3.039=0A=
=0DStarting kswapd v1.8=0A=
=0Dpty: 256 Unix98 ptys configured=0A=
=0DSerial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI ISAPNP enabled=0A=
=0DttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0A=
=0DttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0A=
=0Dblock: 128 slots per queue, batch=3D16=0A=
=0DRAMDISK driver initialized: 16 RAM disks of 4096K size 1024 =
blocksize=0A=
=0DUniform Multi-Platform E-IDE driver Revision: 6.31=0A=
=0Dide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
=0DPIIX3: IDE controller on PCI bus 00 dev 09=0A=
=0DPIIX3: chipset revision 0=0A=
=0DPIIX3: not 100% native mode: will probe irqs later=0A=
=0D    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:pio, =
hdb:pio=0A=
=0DFloppy drive(s): fd0 is 1.44M=0A=
=0DFDC 0 is a post-1991 82077=0A=
=0Dloop: loaded (max 8 devices)=0A=
=0Deepro100.c:v1.09j-t 9/29/99 Donald Becker =
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html=0A=
=0Deepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. =
Savochkin <saw@saw.sw.com.sg> and others=0A=
=0Deth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:8A:0F:98, IRQ =
15.=0A=
=0D  Receiver lock-up bug exists -- enabling work-around.=0A=
=0D  Board assembly 697680-002, Physical connectors present: RJ45=0A=
=0D  Primary interface chip i82555 PHY #1.=0A=
=0D  General self-test: passed.=0A=
=0D  Serial sub-system self-test: passed.=0A=
=0D  Internal registers self-test: passed.=0A=
=0D  ROM checksum self-test: passed (0x24c9f043).=0A=
=0D  Receiver lock-up workaround activated.=0A=
=0DLinux agpgart interface v0.99 (c) Jeff Hartmann=0A=
=0Dagpgart: Maximum main memory to use for agp memory: 440M=0A=
=0D[drm] Initialized tdfx 1.0.0 20010216 on minor 0=0A=
=0D[drm] Initialized radeon 1.1.1 20010405 on minor 1=0A=
=0DSCSI subsystem driver Revision: 1.00=0A=
=0Dahc_pci:1:1:0: Reading SEEPROM...checksum error=0A=
=0Dahc_pci:1:1:0: No SEEPROM available.=0A=
=0Dahc_pci:1:1:0: Using left over BIOS settings=0A=
=0Dahc_pci:1:1:0: Downloading Sequencer Program... 439 instructions =
downloaded=0A=
=0Dahc_pci:1:8:0: Reading SEEPROM...done.=0A=
=0Dahc_pci:1:8:0: internal 50 cable not present, internal 68 cable not =
present=0A=
=0Dahc_pci:1:8:0: external cable is present=0A=
=0Dahc_pci:1:8:0: BIOS eeprom is present=0A=
=0Dahc_pci:1:8:0: High byte termination Enabled=0A=
=0Dahc_pci:1:8:0: Low byte termination Enabled=0A=
=0Dahc_pci:1:8:0: Downloading Sequencer Program... 431 instructions =
downloaded=0A=
=0Dahc_pci:1:9:0: Reading SEEPROM...checksum error=0A=
=0Dahc_pci:1:9:0: No SEEPROM available.=0A=
=0Dahc_pci:1:9:0: Host Adapter Bios disabled.  Using default SCSI =
device parameters=0A=
=0Dahc_pci:1:9:0: Downloading Sequencer Program... 439 instructions =
downloaded=0A=
=0Dscsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.2=0A=
=0D        <Adaptec aic7880 Ultra SCSI adapter>=0A=
=0D        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/255 SCBs=0A=

=0Dscsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.2=0A=
=0D        <Adaptec 2944 Ultra SCSI adapter>=0A=
=0D        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/255 SCBs=0A=

=0Dscsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.2=0A=
=0D        <Adaptec 2944 Ultra SCSI adapter>=0A=
=0D        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/255 SCBs=0A=

=0D  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.91=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D(scsi0:A:0:1): Sending WDTR 1=0A=
=0D(scsi0:A:0:1): Received WDTR 1 filtered to 1=0A=
=0D(scsi0:A:0): 6.600MB/s transfers (16bit)=0A=
=0Dscsi0: target 0 using 16bit transfers=0A=
=0D(scsi0:A:0:1): Sending SDTR period 19, offset 8=0A=
=0D(scsi0:A:0:1): Received SDTR period 19, offset 8=0A=
=0D	Filtered to period 19, offset 8=0A=
=0D(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)=0A=
=0Dscsi0: target 0 synchronous at 10.0MHz, offset =3D 0x8=0A=
=0D  Vendor: SDR       Model: GEM200            Rev: 2   =0A=
=0D  Type:   Processor                          ANSI SCSI revision: =
02=0A=
=0D(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)=0A=
=0Dscsi0:A:0:0: Tagged Queuing enabled.  Depth 8=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D(scsi1:A:0:1): Sending WDTR 1=0A=
=0D(scsi1:A:0:1): Received WDTR 1 filtered to 1=0A=
=0D(scsi1:A:0): 6.600MB/s transfers (16bit)=0A=
=0Dscsi1: target 0 using 16bit transfers=0A=
=0D(scsi1:A:0:1): Sending SDTR period c, offset 8=0A=
=0D(scsi1:A:0:1): Received SDTR period c, offset 8=0A=
=0D	Filtered to period c, offset 8=0A=
=0D(scsi1:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)=0A=
=0Dscsi1: target 0 synchronous at 20.0MHz, offset =3D 0x8=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0D  Vendor: EMC       Model: SYMMETRIX         Rev: 5268=0A=
=0D  Type:   Direct-Access                      ANSI SCSI revision: =
02=0A=
=0DUnable to handle kernel NULL pointer dereference at virtual address =
00000016=0A=
=0D printing eip:=0A=
=0Dc01e3a79=0A=
=0D*pde =3D 00000000=0A=
=0DOops: 0000=0A=
=0DCPU:    0=0A=
=0DEIP:    0010:[<c01e3a79>]=0A=
=0DEFLAGS: 00010006=0A=
=0Deax: dff79800   ebx: dff57400   ecx: 00000000   edx: 0000000a=0A=
=0Desi: dffcf200   edi: 00000000   ebp: 00000042   esp: dfff7c60=0A=
=0Dds: 0018   es: 0018   ss: 0018=0A=
=0DProcess swapper (pid: 1, stackpage=3Ddfff7000)=0A=
=0DStack: 00000212 dff83ef4 dff57400 dffbd7a0 00000000 00000082 =
c01d7f8a dff57400 =0A=
=0D       c01d85f4 dff57400 dff83ef4 dffbd7a0 dff83ef4 00000000 =
c01df4bf dff57400 =0A=
=0D       dff57400 00000286 dff57618 dfff7dbc dffbd7a0 00000000 =
dffbd7a0 dff57600 =0A=
=0DCall Trace: [<c01d7f8a>] [<c01d85f4>] [<c01df4bf>] [<c01de8d6>] =
[<c01de926>] =0A=
=0D   [<c01d8271>] [<c01d811c>] [<c01d79f8>] [<c01e219c>] [<c01a00ff>] =
[<c01a3700>] =0A=
=0D   [<c01a4fb0>] [<c01a50ec>] [<c01a510c>] [<c01e1eeb>] [<c0108955>] =
[<c0106ffc>] =0A=
=0D   [<c01e38a6>] [<c01d963a>] [<c0105000>] [<c01d9e6d>] [<c0105285>] =
[<c0105000>] =0A=
=0D   [<c0105763>] =0A=

=0DCode: 8b 42 0c 89 83 64 01 00 00 8b 42 0c 89 18 81 c3 60 01 00 00 =
=0A=
=0DKernel panic: Attempted to kill init!=0A=

------_=_NextPart_000_01C13F79.B2094830--
