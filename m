Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVIYWA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVIYWA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVIYWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:00:58 -0400
Received: from pool-151-202-105-53.ny325.east.verizon.net ([151.202.105.53]:60827
	"EHLO blaze.homeip.net") by vger.kernel.org with ESMTP
	id S932309AbVIYWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:00:57 -0400
Date: Sun, 25 Sep 2005 18:00:37 -0400
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Carlo Calica <ccalica@gmail.com>, xorg@lists.freedesktop.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050925220037.GA8776@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org
X-Operating-System: Slackware 10.2.0
X-Kernel-Version: Linux blaze 2.6.14-rc2-mm1 i686
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Folks,

Upon quick testing the latest mm kernel it appears there's some kind of
race condition when using dual core cpu esp when using XORG and USB
(although PS2 has same issue) kebyboard rate being too fast.

The same behaviour happens on vanilla 2.6.13 kernel. Reporting this also
to XORG list in hopes to help debug this issue.

The platform is nForce4 SLI from ASUS (A8N-SLI Premium) with dual core
X2 Athlon 3800+ processor.

XORG version is 6.8.2 under Slackware 10.2.

uname -a reports: Linux blaze 2.6.14-rc2-mm1 #1 SMP Sun Sep 25 17:03:22
EDT 2005 i686 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
AuthenticAMD GNU/Linux

kernel config, dmesg output and lspci -vvv will be attached below.

I have confirmed this with another fellow who is using the same setup
and is having the same issue. Also worth noting is that the SATA
performance is very poor, the hdparm results give ~33mb/s where on
nforce2 previously the rates would be in ~58mb/s range. In comparison
SCSI rates are in ~52mb/s range. This both happens on sata_nv and
sata_sil controllers on this mainboard.

One of the workarounds for me is to turn the keyboard rate in
gnome-keybaord tools which helps. Also when browsing websites the USB
mouse has problems with scrolling and the window painting seems very
slow, like when typing www. in url bar can take up to 10 seconds before
the bar shows previously entered urls. Playing mp3 makes the music
skip very badly. I had not tried to use UP kernel but from the
reports i've read the issue is gone when using X. As noted here
http://lists.freedesktop.org/archives/xorg/2005-September/010148.html

I can help debugging this and if more info is needed please CC the
responses.

Best Regards,

Paul B.

--cWoXeonUoKmBZSoM
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
ny/yxmPX/wEAwriAPY4AAA==

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dm-mm.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.14-rc2-mm1 (root@blaze) (gcc version 3.3.6) #1 SMP Sun Se=
p 25 17:03:22 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000f5a30
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 126960 pages, LIFO batch:64
  HighMem zone: 0 pages, LIFO batch:2
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7dc0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff30c0
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x1fff9900
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff9a00
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Kernel command line: root=3D/dev/sda1 ro vmalloc=3D256M console=3DttyS0,576=
00n8 console=3Dtty0 rootflags=3Dquota elevator=3Dcfq vga=3D795
CPU 0 irqstacks, hard=3Dc043e000 soft=3Dc043c000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2352.758 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515152k/524224k available (2390k kernel code, 8560k reserved, 662k =
data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4708.36 BogoMIPS (lpj=3D23=
54180)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 0000=
0001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000=
001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000010 00000001 00=
000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... <7>spurious 8259A interrupt: IRQ7.
done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=3Dc043f000 soft=3Dc043d000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4704.69 BogoMIPS (lpj=3D23=
52349)
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 0000=
0001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000=
001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000010 00000001 00=
000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Total of 2 processors activated (9413.05 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D0 pin2=3D-1
checking TSC synchronization across 2 CPUs:=20
CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 3.00 entry at 0xf2740, last bus=3D5
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: 8000-afff
  MEM window: d0000000-d1ffffff
  PREFETCH window: 30000000-300fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: c8000000-cfffffff
  PREFETCH window: c0000000-c7ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
vesafb: framebuffer at 0xc0000000, mapped to 0xe0880000, using 10240k, tota=
l 131072k
vesafb: mode is 1280x1024x32, linelength=3D5120, pages=3D0
vesafb: protected mode interface info at c000:d620
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: Thermal Zone [THRM] (40 C)
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -=
> IRQ 16
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Ending Domain Validation
  Vendor: IBM       Model: IC35L036UWD210-0  Rev: S5CQ
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous.
 target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding 506008k swap on /dev/sda7.  Priority:-1 extents:1 across:506008k
Linux agpgart interface v0.101 (c) Dave Jones
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.41.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -=
> IRQ 17
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
eth0: no link during initialization.
eth0: link up.
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -=
> IRQ 18
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -=
> IRQ 18
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level, low) -=
> IRQ 16
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[16]  MMIO=3D[d100f000-d100f=
7ff]  Max Packet=3D[2048]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -=
> IRQ 19
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=3D[19]  MMIO=3D[d100d000-d100d=
7ff]  Max Packet=3D[2048]
gameport: EMU10K1 is pci0000:05:07.1/gameport0, io 0x8400, speed 1193kHz
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -=
> IRQ 18
Installing spdif_bug patch: Audigy 2 Platinum [SB0240P]
libata version 1.12 loaded.
sata_nv version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -=
> IRQ 20
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 20
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 20
ata1: no device found (phy stat 00000000)
scsi1 : sata_nv
ata2: no device found (phy stat 00000000)
scsi2 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -=
> IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091065c55]
ata3: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:=
407f
ata3: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/133
scsi3 : sata_nv
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
ata4: no device found (phy stat 00000000)
scsi4 : sata_nv
  Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
 sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdb1 sdb2
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0
PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCJ] -> GSI 20 (level, low) -=
> IRQ 22
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 51749 usecs
intel8x0: clocking to 46867
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 23 (level, low) -=
> IRQ 17
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 17, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, low) -=
> IRQ 20
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 20, io mem 0xd2004000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 1-2: new high speed USB device using ehci_hcd and address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ohci_hcd 0000:00:02.0: wakeup
usb 2-3: new full speed USB device using ohci_hcd and address 2
hub 2-3:1.0: USB hub found
hub 2-3:1.0: 3 ports detected
usb 2-4: new low speed USB device using ohci_hcd and address 3
usb 2-3.1: new low speed USB device using ohci_hcd and address 4
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with Intelli=
Eye(TM)] on usb-0000:00:02.0-4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on usb-0000:=
00:02.0-3.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on usb-0000:00=
:02.0-3.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Real Time Clock Driver v1.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
gameport: NS558 PnP Gameport is pnp00:0b/gameport0, io 0x201, speed 903kHz
USB Universal Host Controller Interface driver v2.3
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pciout.txt"

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a801]

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e400 [size=32]
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at d2004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2098]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at 1000 [size=256]
	Region 2: Memory at d2003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 815a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at 09f0 [size=8]
	Region 1: I/O ports at 0bf0 [size=4]
	Region 2: I/O ports at 0970 [size=8]
	Region 3: I/O ports at 0b70 [size=4]
	Region 4: I/O ports at d800 [size=16]
	Region 5: Memory at d2002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at 09e0 [size=8]
	Region 1: I/O ports at 0be0 [size=4]
	Region 2: I/O ports at 0960 [size=8]
	Region 3: I/O ports at 0b60 [size=4]
	Region 4: I/O ports at c400 [size=16]
	Region 5: Memory at d2001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
	I/O behind bridge: 00008000-0000afff
	Memory behind bridge: d0000000-d1ffffff
	Prefetchable memory behind bridge: 30000000-300fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at d2000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 08
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 08
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: c8000000-cfffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c7f00000
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 GT] (rev a2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c8000000 (32-bit, non-prefetchable) [size=64M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=128M]
	Region 3: Memory at cc000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at cd000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

05:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs: Unknown device 1002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 8000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
	Subsystem: Creative Labs: Unknown device 0060
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 8400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 0: Memory at d100f000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d1000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

05:08.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	BIST result: 00
	Region 0: I/O ports at 8800 [disabled] [size=256]
	Region 1: Memory at d100e000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at 30080000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8167
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 8c00 [size=8]
	Region 1: I/O ports at 9000 [size=4]
	Region 2: I/O ports at 9400 [size=8]
	Region 3: I/O ports at 9800 [size=4]
	Region 4: I/O ports at 9c00 [size=16]
	Region 5: Memory at d100c000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 30000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at d100d000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d1004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5750ns min, 7750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at d1008000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at a000 [size=256]
	Expansion ROM at 300a0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data


--cWoXeonUoKmBZSoM--

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDNx4Fwu5Nmh3PsiMRAn4lAJ9crYRKyRBjka2Actv9+fPhCkPoAACfcP4V
DrEiP0fiz0iKXA5/JbjHf1g=
=cCKG
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
