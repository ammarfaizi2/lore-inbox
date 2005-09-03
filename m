Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVICApS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVICApS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVICApS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:45:18 -0400
Received: from postman4.arcor-online.net ([151.189.20.158]:28119 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S932249AbVICApQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:45:16 -0400
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Organization: Embedded Systems and Applications Group, Tech. Univ. Darmstadt, Germany
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13: Crash in Yenta initialization
Date: Sat, 3 Sep 2005 02:45:08 +0200
User-Agent: KMail/1.8.1
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de>
In-Reply-To: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2330984.pKnAAu6tZ7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509030245.12610.koch@esa.informatik.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2330984.pKnAAu6tZ7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

As a follow-up to my previous mail, I collected a boot log of the working=20
kernel 2.6.12-rc6 with Ivan's bridge initialization patches below. The=20
crucial part seem to be the different bridge initialization sections:

2.6.12-rc6 + Ivan's patches:

          PCI: Bridge: 0000:00:01.0
            IO window: 2000-2fff
            MEM window: c8100000-c81fffff
            PREFETCH window: d0000000-d7ffffff
          PCI: Bridge: 0000:00:1c.0
            IO window: disabled.
            MEM window: disabled.
            PREFETCH window: disabled.
          PCI: Bridge: 0000:00:1c.1
            IO window: disabled.
            MEM window: disabled.
            PREFETCH window: disabled.
          PCI: Bus 4, cardbus bridge: 0000:03:05.0
            IO window: 00003000-00003fff
            IO window: 00004000-00004fff
            PREFETCH window: 80000000-81ffffff
            MEM window: 88000000-89ffffff
          PCI: Bridge: 0000:02:00.0
            IO window: 3000-5fff
            MEM window: 88000000-8affffff
            PREFETCH window: 80000000-81ffffff
          PCI: Bridge: 0000:00:1c.2
            IO window: 3000-5fff
            MEM window: 88000000-8affffff
            PREFETCH window: 80000000-81ffffff
          PCI: Bus 7, cardbus bridge: 0000:06:09.0
            IO window: 00006000-00006fff
            IO window: 00007000-00007fff
            PREFETCH window: 82000000-83ffffff
            MEM window: 8c000000-8dffffff
          PCI: Bus 11, cardbus bridge: 0000:06:09.1
            IO window: 00008000-00008fff
            IO window: 00009000-00009fff
            PREFETCH window: 84000000-85ffffff
            MEM window: 8e000000-8fffffff
          PCI: Bus 15, cardbus bridge: 0000:06:09.3
            IO window: 0000a000-0000afff
            IO window: 0000b000-0000bfff
            PREFETCH window: 86000000-87ffffff
            MEM window: 90000000-91ffffff
          PCI: Bridge: 0000:00:1e.0
            IO window: 6000-bfff
            MEM window: c8400000-c84fffff
            PREFETCH window: 82000000-87ffffff

=2E.. Versus the much shorter output from 2.6.13

          PCI: Bridge: 0000:00:01.0
            IO window: 2000-2fff
            MEM window: c8100000-c81fffff
            PREFETCH window: d0000000-d7ffffff
          PCI: Bridge: 0000:00:1c.0
            IO window: disabled.
            MEM window: disabled.
            PREFETCH window: disabled.
          PCI: Bridge: 0000:00:1c.1
            IO window: disabled.
            MEM window: disabled.
            PREFETCH window: disabled.
          PCI: Bus 4, cardbus bridge: 0000:03:05.0
            IO window: 00003000-000030ff
            IO window: 00003400-000034ff
            PREFETCH window: 80000000-81ffffff
            MEM window: 84000000-85ffffff
          PCI: Bridge: 0000:02:00.0
            IO window: 3000-3fff
            MEM window: 84000000-86ffffff
            PREFETCH window: 80000000-81ffffff
          PCI: Bridge: 0000:00:1c.2
            IO window: 3000-3fff
            MEM window: 84000000-86ffffff
            PREFETCH window: 80000000-81ffffff
          PCI: Bus 7, cardbus bridge: 0000:06:09.0
            IO window: 00004000-000040ff
            IO window: 00004400-000044ff
            PREFETCH window: 82000000-83ffffff
            MEM window: 88000000-89ffffff
          PCI: Bridge: 0000:00:1e.0
            IO window: 4000-4fff
            MEM window: c8400000-c84fffff
            PREFETCH window: 82000000-83ffffff
         =20
Below the full boot log for the working 2.6.12-rc6+IvanPatches

I hope this additional info helps to bring this part of 2.6.13 up to the=20
earlier capability.

Andreas Koch

Linux version 2.6.12-rc6 (root@meneldor) (gcc version 3.3.5-20050130 (Gento=
o=20
Linux 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #11 Sat Sep 3=
=20
01:09:47 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe80000 (usable)
 BIOS-e820: 000000007fe80000 - 000000007fe89000 (ACPI data)
 BIOS-e820: 000000007fe89000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 523904
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294528 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f68d0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7fe80e14
ACPI: FADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88e8a
ACPI: MADT (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88efe
ACPI: HPET (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88f64
ACPI: MCFG (v001 INTEL  ALVISO   0x06040000 LOHR 0x0000005f) @ 0x7fe88f9c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7fe88fd8
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030224) @ 0x7fe81249
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x7fe81071
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0x7fe80e58
ACPI: DSDT (v001 INTEL  ALVISO   0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec20000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec20000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: root=3D/dev/ram0 lvm2root=3D/dev/vg0/root
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec20000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1995.318 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069132k/2095616k available (3516k kernel code, 25232k reserved, 15=
84k=20
data, 220k init, 1178112k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3923.96 BogoMIPS (lpj=3D1961984)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000=20
00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000=
180=20
00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180=20
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
checking if image is initramfs...it isn't (no cpio magic); looks like an=20
initrd
=46reeing initrd memory: 2107k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd6ce, last bus=3D8
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node dfdc6160 start_node dfdc6160 return_node 00000000
    ACPI-0352: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node dfdc6da0 start_node dfdc6da0 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.1
PCI: Cannot allocate resource region 0 of device 0000:03:02.2
PCI: Cannot allocate resource region 4 of device 0000:03:03.0
PCI: Cannot allocate resource region 4 of device 0000:03:03.1
PCI: Cannot allocate resource region 0 of device 0000:03:03.2
PCI: Cannot allocate resource region 0 of device 0000:03:04.0
PCI: Cannot allocate resource region 1 of device 0000:03:04.0
PCI: Cannot allocate resource region 0 of device 0000:03:05.0
PCI: Cannot allocate resource region 0 of device 0000:03:06.0
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8100000-c81fffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 4, cardbus bridge: 0000:03:05.0
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 80000000-81ffffff
  MEM window: 88000000-89ffffff
PCI: Bridge: 0000:02:00.0
  IO window: 3000-5fff
  MEM window: 88000000-8affffff
  PREFETCH window: 80000000-81ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-5fff
  MEM window: 88000000-8affffff
  PREFETCH window: 80000000-81ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: 82000000-83ffffff
  MEM window: 8c000000-8dffffff
PCI: Bus 11, cardbus bridge: 0000:06:09.1
  IO window: 00008000-00008fff
  IO window: 00009000-00009fff
  PREFETCH window: 84000000-85ffffff
  MEM window: 8e000000-8fffffff
PCI: Bus 15, cardbus bridge: 0000:06:09.3
  IO window: 0000a000-0000afff
  IO window: 0000b000-0000bfff
  PREFETCH window: 86000000-87ffffff
  MEM window: 90000000-91ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-bfff
  MEM window: c8400000-c84fffff
  PREFETCH window: 82000000-87ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Device 0000:00:1c.1 not available because of resource collisions
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Enabling device 0000:00:1c.2 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:02:00.0 to 64
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Enabling device 0000:06:09.3 (0080 -> 0083)
ACPI: PCI Interrupt 0000:06:09.3[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:06:09.3 to 64
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1125709926.697:0): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
Evaluate _OSC Set fails. Status =3D 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (55 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 32 (level, low) -> IRQ 32
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
tg3.c:v3.29 (May 23, 2005)
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit)=20
10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap=
[1]=20
eth0: dma_rwctrl[763f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH6M: IDE controller at PCI slot 0000:00:1f.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ICH6M: chipset revision 4
ICH6M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x18a8-0x18af, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK1032GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GMA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 195371568 sectors (100030 MB), CHS=3D16383/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 30 (level, low) -> IRQ 30
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[30]  MMIO=3D[8a005000-8a005=
7ff] =20
Max Packet=3D[2048]
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=3D[19]  MMIO=3D[c8415000-c8415=
7ff] =20
Max Packet=3D[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 31
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
yenta 0000:03:05.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:03:05.0: no resource of type 1200 available, trying to continue.=
=2E.
yenta 0000:03:05.0: Preassigned resource 1 busy, reconfiguring...
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:05.0, mfunc 0x00521d22, devctl 0x66
Yenta: ISA IRQ mask 0x0000, PCI irq 31
Socket status: 30000006
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
yenta 0000:06:09.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:06:09.0: no resource of type 1200 available, trying to continue.=
=2E.
yenta 0000:06:09.0: Preassigned resource 1 busy, reconfiguring...
Yenta O2: res at 0x94/0xD4: ea/00
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ACPI: PCI Interrupt 0000:06:09.1[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.1 [1025:0070]
yenta 0000:06:09.1: Preassigned resource 1 busy, reconfiguring...
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000006
ACPI: PCI Interrupt 0000:06:09.3[A] -> GSI 18 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:06:09.3 [1025:0070]
yenta 0000:06:09.3: Preassigned resource 1 busy, reconfiguring...
Yenta: ISA IRQ mask 0x0438, PCI irq 18
Socket status: 30000410
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f0000507951]
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
)=20
USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xc8004000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[00c09f000038d11c]
ACPI: PCI Interrupt 0000:03:02.2[C] -> GSI 26 (level, low) -> IRQ 26
ehci_hcd 0000:03:02.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:03:02.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:03:02.2: irq 26, io mem 0x8a005800
ehci_hcd 0000:03:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:03:03.2[C] -> GSI 29 (level, low) -> IRQ 29
ehci_hcd 0000:03:03.2: VIA Technologies, Inc. USB 2.0 (#2)
ehci_hcd 0000:03:03.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:03:03.2: irq 29, io mem 0x8a005900
ehci_hcd 0000:03:03.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
)=20
USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
)=20
USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
)=20
USB UHCI #3
usb 2-3: new high speed USB device using ehci_hcd and address 2
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family=
)=20
USB UHCI #4
hub 2-3:1.0: USB hub found
hub 2-3:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 24 (level, low) -> IRQ 24
uhci_hcd 0000:03:02.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller
uhci_hcd 0000:03:02.0: new USB bus registered, assigned bus number 8
uhci_hcd 0000:03:02.0: irq 24, io base 0x00005040
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 25 (level, low) -> IRQ 25
uhci_hcd 0000:03:02.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (#2)
uhci_hcd 0000:03:02.1: new USB bus registered, assigned bus number 9
uhci_hcd 0000:03:02.1: irq 25, io base 0x00005060
hub 9-0:1.0: USB hub found
hub 9-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 27 (level, low) -> IRQ 27
uhci_hcd 0000:03:03.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (#3)
uhci_hcd 0000:03:03.0: new USB bus registered, assigned bus number 10
uhci_hcd 0000:03:03.0: irq 27, io base 0x00005080
hub 10-0:1.0: USB hub found
hub 10-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:03:03.1[B] -> GSI 28 (level, low) -> IRQ 28
uhci_hcd 0000:03:03.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (#4)
uhci_hcd 0000:03:03.1: new USB bus registered, assigned bus number 11
uhci_hcd 0000:03:03.1: irq 28, io base 0x000050a0
hub 11-0:1.0: USB hub found
hub 11-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usbcore: registered new driver auerswald
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. =20
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:=20
AZAL RP01 RP02 RP04 USB1 USB2 USB3 USB4 USB7 LANC=20
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
usb 2-3.1: new high speed USB device using ehci_hcd and address 4
input: AT Translated Set 2 keyboard on isa0060/serio0
VFS: Mounted root (ext2 filesystem) readonly.
=46reeing unused kernel memory: 220k freed
hub 2-3.1:1.0: USB hub found
hub 2-3.1:1.0: 4 ports detected
usb 2-3.2: new high speed USB device using ehci_hcd and address 5
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
usb 9-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech Trackball] on usb-0000:03:02.1-2
usb 10-2: new full speed USB device using uhci_hcd and address 2
input: USB HID v1.00 Device [USB Audio] on usb-0000:03:03.0-2
  Vendor: SMSC      Model: 223 U HS-CF       Rev: 3.60
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block=
=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
Adding 2097144k swap on /dev/vg0/swap.  Priority:-1 extents:1
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block=
=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
NTFS volume version 3.1.
ReiserFS: dm-3: found reiserfs format "3.6" with standard journal
ReiserFS: dm-3: using ordered data mode
ReiserFS: dm-3: journal params: device dm-3, size 8192, journal first block=
=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-3: checking transaction log (dm-3)
ReiserFS: dm-3: Using r5 hash to sort names
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, 1.0.3
ieee80211: Copyright (C) 2004-2005 Intel Corporation=20
<jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.6
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 17 (level, low) -> IRQ 17
ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
ipw2200: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
usbcore: registered new driver snd-usb-audio
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xe0000-0xfff=
ff
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

--nextPart2330984.pKnAAu6tZ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBDGPIYk5ta2EV7DowRAochAJ0TkXzFNiCKLB65kr5AHpkGp53AFQCY+t/S
4bQOZnPtorpZDzvrg6dUKw==
=SUhW
-----END PGP SIGNATURE-----

--nextPart2330984.pKnAAu6tZ7--
