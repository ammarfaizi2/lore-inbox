Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVEUIV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVEUIV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 04:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVEUIV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 04:21:57 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:3765 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261704AbVEUIUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 04:20:18 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: vgoyal@in.ibm.com
Subject: Re: kexec?
Date: Sat, 21 May 2005 10:20:35 +0200
User-Agent: KMail/1.7.2
Cc: maneesh@in.ibm.com, coywolf@lovecn.org,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
References: <20050508202050.GB13789@charite.de> <200505180958.03570.petkov@uni-muenster.de> <20050520105259.GC3637@in.ibm.com>
In-Reply-To: <20050520105259.GC3637@in.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T9ujCogujYQrMIy"
Message-Id: <200505211020.35982.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_T9ujCogujYQrMIy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<snip>
> Second kernel did not have serial console output enabled in config file. Is
> it possible to test it out once again with serial console enabled. May be
> disable kgdb in first kernel.
>
> With --console-serial option enabled while loading panic kernel (kexec -p)
> I am expecting at least following message on serial console after Sysrq-c.
>
> "I am in purgatory".
>
HI Vivek,

well kgdb was the offending problem here. After disabling it and booting into 
the first kernel, everything worked just fine. I even got to 
save /proc/vmcore successfully so kdump works also :) Log attached.

Regards,
Boris.

--Boundary-00=_T9ujCogujYQrMIy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="minicom.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="minicom.cap"

[4294667.296000] Linux version 2.6.12-rc3-mm3 (boris@zmei) (gcc version 3.3.6 (Debian 1:3.3.6-5)) #15 SMP Sat May 21 09:31:23 CEST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000ce000 - 00000000000d60ac (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[4294667.296000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[4294667.296000] 511MB LOWMEM available.
[4294667.296000] found SMP MP-table at 000fbad0
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:2 APIC version 20
[4294667.296000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[4294667.296000] Processor #1 15:2 APIC version 20
[4294667.296000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: root=/dev/hda1 vga=0 crashkernel=64M@16M console=ttyS0,115200 console=tty0
[4294667.296000] CPU 0 irqstacks, hard=c04a4000 soft=c04a2000
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 2606.778 MHz processor.
[   29.152157] Using tsc for high-res timesource
[   29.153086] Console: colour VGA+ 80x25
[   29.382716] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   29.391290] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   29.408168] Memory: 449292k/524224k available (2245k kernel code, 74444k reserved, 1259k data, 188k init, 0k highmem)
[   29.419819] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   29.488724] Calibrating delay using timer specific routine.. 5216.98 BogoMIPS (lpj=2608494)
[   29.497995] Security Framework v1.0.0 initialized
[   29.503168] Capability LSM initialized
[   29.507319] Mount-cache hash table entries: 512
[   29.512525] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   29.518196] CPU: L2 cache: 512K
[   29.521655] CPU: Physical Processor ID: 0
[   29.526072] Enabling fast FPU save and restore... done.
[   29.531838] Enabling unmasked SIMD FPU exception support... done.
[   29.538536] Checking 'hlt' instruction... OK.
[   29.570651] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[   29.577539] Booting processor 1/1 eip 2000
[   29.582366] CPU 1 irqstacks, hard=c04a5000 soft=c04a3000
[   29.599008] Initializing CPU#1
[   29.659283] Calibrating delay using timer specific routine.. 5211.17 BogoMIPS (lpj=2605585)
[   29.659309] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   29.659312] CPU: L2 cache: 512K
[   29.659314] CPU: Physical Processor ID: 0
[   29.659419] CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[   29.693310] Total of 2 processors activated (10428.15 BogoMIPS).
[   29.700267] ENABLING IO-APIC IRQs
[   29.704241] ..TIMER: vector=0x31 pin1=2 pin2=-1
[   29.820874] checking TSC synchronization across 2 CPUs: passed.
[    0.001146] softlockup thread 0 started up.
[    0.007040] Brought up 2 CPUs
[    0.007042] softlockup thread 1 started up.
[    0.016618] NET: Registered protocol family 16
[    0.021922] ACPI: bus type pci registered
[    0.033190] PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=3
[    0.040690] PCI: Using configuration type 1
[    0.045647] mtrr: v2.0 (20020519)
[    0.055316] ACPI: Subsystem revision 20050408
[    0.078076] ACPI: Interpreter enabled
[    0.082308] ACPI: Using IOAPIC for interrupt routing
[    0.089019] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.094679] PCI: Probing PCI hardware (bus 00)
[    0.099870] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[    0.110827] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.150983] ACPI: Power Resource [URP1] (off)
[    0.156137] ACPI: Power Resource [URP2] (off)
[    0.161460] ACPI: Power Resource [FDDP] (off)
[    0.166783] ACPI: Power Resource [LPTP] (off)
[    0.173624] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.182589] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *6 7 10 11 12 14 15)
[    0.191555] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.200633] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.209524] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.219778] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.230273] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.240761] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.249428] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.255964] pnp: PnP ACPI init
[    0.266152] pnp: PnP ACPI: found 10 devices
[    0.271406] usbcore: registered new driver usbfs
[    0.276939] usbcore: registered new driver hub
[    0.282340] PCI: Using ACPI for IRQ routing
[    0.287161] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.305977] Initializing Cryptographic API
[    0.316346] Linux agpgart interface v0.101 (c) Dave Jones
[    0.322882] agpgart: Detected an Intel 845G Chipset.
[    0.331033] agpgart: AGP aperture is 64M @ 0xe0000000
[    0.337047] [drm] Initialized drm 1.0.0 20040925
[    0.342362] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[    0.351262] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
[    0.362502] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.373374] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.379377] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.385247] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[    0.394640] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.401629] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.407853] parport: PnPBIOS parport detected.
[    0.413089] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
[    0.420879] io scheduler noop registered
[    0.425439] io scheduler anticipatory registered
[    0.430856] io scheduler deadline registered
[    0.435905] io scheduler cfq registered
[    0.440571] 8139too Fast Ethernet driver 0.9.27
[    0.445948] ACPI: PCI Interrupt 0000:03:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
[    0.454614] eth0: RealTek RTL8139 at 0xe080ef00, 00:0c:6e:aa:a2:81, IRQ 17
[    0.462567] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    0.470028] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.479259] ICH4: IDE controller at PCI slot 0000:00:1f.1
[    0.485560] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[    0.493958] ICH4: chipset revision 2
[    0.498179] ICH4: not 100% native mode: will probe irqs later
[    0.504636]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
[    0.513069]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
[    0.786131] hda: QUANTUM FIREBALLlct10 20, ATA DISK drive
[    1.047794] hdb: IC35L120AVV207-0, ATA DISK drive
[    1.105683] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    1.782518] hdc: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
[    2.043831] hdd: Maxtor 6Y160P0, ATA DISK drive
[    2.101246] ide1 at 0x170-0x177,0x376 on irq 15
[    4.154186] hda: max request size: 128KiB
[    4.163476] hda: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(33)
[    4.172897] hda: cache flushes not supported
[    4.178676]  hda: hda1 hda2 hda3
[    4.188475] hdb: max request size: 1024KiB
[    4.201334] hdb: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
[    4.211386] hdb: cache flushes supported
[    4.216465]  hdb: hdb1
[    4.224338] hdd: max request size: 1024KiB
[    4.229885] hdd: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(33)
[    4.239817] hdd: cache flushes supported
[    4.244461]  hdd: hdd1
[    4.253378] hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[    4.261224] Uniform CD-ROM driver Revision: 3.20
[    7.194905] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
[    7.203618] ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
[    7.214312] ehci_hcd 0000:00:1d.7: debug port 1
[    7.219537] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    7.228274] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xdffffc00
[    7.238877] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[    7.248197] usb usb1: Product: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
[    7.258483] usb usb1: Manufacturer: Linux 2.6.12-rc3-mm3 ehci_hcd
[    7.265509] usb usb1: SerialNumber: 0000:00:1d.7
[    7.270949] hub 1-0:1.0: USB hub found
[    7.275377] hub 1-0:1.0: 6 ports detected
[    7.302020] USB Universal Host Controller Interface driver v2.3
[    7.309186] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
[    7.317966] uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[    7.329980] uhci_hcd 0000:00:1d.0: detected 2 ports
[    7.335729] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    7.344460] uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e400
[    7.351178] usb usb2: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
[    7.362472] usb usb2: Manufacturer: Linux 2.6.12-rc3-mm3 uhci_hcd
[    7.369438] usb usb2: SerialNumber: 0000:00:1d.0
[    7.374788] hub 2-0:1.0: USB hub found
[    7.379331] hub 2-0:1.0: 2 ports detected
[    7.386800] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[    7.395460] uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[    7.407457] uhci_hcd 0000:00:1d.1: detected 2 ports
[    7.413193] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    7.421953] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e800
[    7.428849] usb usb3: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
[    7.440358] usb usb3: Manufacturer: Linux 2.6.12-rc3-mm3 uhci_hcd
[    7.447574] usb usb3: SerialNumber: 0000:00:1d.1
[    7.453172] hub 3-0:1.0: USB hub found
[    7.457623] hub 3-0:1.0: 2 ports detected
[    7.465583] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[    7.474293] uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[    7.486319] uhci_hcd 0000:00:1d.2: detected 2 ports
[    7.492041] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    7.500607] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ec00
[    7.507507] usb usb4: Product: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
[    7.518941] usb usb4: Manufacturer: Linux 2.6.12-rc3-mm3 uhci_hcd
[    7.525906] usb usb4: SerialNumber: 0000:00:1d.2
[    7.531466] hub 4-0:1.0: USB hub found
[    7.535913] hub 4-0:1.0: 2 ports detected
[    7.543534] mice: PS/2 mouse device common for all mice
[    7.549746] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
[    7.561635] ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 17 (level, low) -> IRQ 17
[    7.589578] input: AT Translated Set 2 keyboard on isa0060/serio0
[    7.751269] ALSA device list:
[    7.754669]   #0: Yamaha DS-XG (YMF724) at 0xdfef8000, irq 17
[    7.761568] NET: Registered protocol family 2
[    7.776758] IP: routing cache hash table of 2048 buckets, 32Kbytes
[    7.784381] TCP established hash table entries: 32768 (order: 7, 524288 bytes)
[    7.793266] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    7.801688] TCP: Hash tables configured (established 32768 bind 32768)
[    7.809372] NET: Registered protocol family 1
[    7.814547] NET: Registered protocol family 17
[    7.819865] Starting balanced_irq
[    7.826744] VFS: Mounted root (ext2 filesystem) readonly.
[    7.833076] Freeing unused kernel memory: 188k freed
[    7.859710] logips2pp: Detected unknown logitech mouse model 1
[    8.002033] input: PS/2 Logitech Mouse on isa0060/serio1
[   11.992280] Adding 976744k swap on /dev/hda2.  Priority:-1 extents:1
[   15.049056] Real Time Clock Driver v1.12
[   15.303095] kjournald starting.  Commit interval 5 seconds
[   15.309286] EXT3 FS on hda3, internal journal
[   15.309294] EXT3-fs: mounted filesystem with ordered data mode.
[   15.337127] kjournald starting.  Commit interval 5 seconds
[   15.337143] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[   15.343603] EXT3 FS on hdb1, internal journal
[   15.343609] EXT3-fs: mounted filesystem with ordered data mode.
[   15.378777] kjournald starting.  Commit interval 5 seconds
[   15.378794] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[   15.385251] EXT3 FS on hdd1, internal journal
[   15.385257] EXT3-fs: mounted filesystem with ordered data mode.
[   17.661267] hw_random: RNG not detected
[   17.951103] Linux video capture interface: v1.00
[   19.872678] input: PC Speaker
[   20.181694] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[  202.914568] SysRq : HELP : loglevel0-8 reBoot Crashdump tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
[  208.817716] SysRq : Emergency Sync
[  218.157484] SysRq : HELP : loglevel0-8 reBoot Crashdump tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
[  222.164005] SysRq : Emergency Remount R/O
[  229.161781] SysRq : HELP : loglevel0-8 reBoot Crashdump tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
[  230.274406] SysRq : Trigger a crashdump
I'm in purgatory
Linux version 2.6.12-rc3-mm3-kdump (boris@zmei) (gcc version 3.3.6 (Debian 1:3.3.6-5)) #3 Sat May 21 09:25:41 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d60ac (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 0000000001449000 (usable)
 user: 00000000014e9400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
DMI 2.3 present.
Allocating PCI resources starting at 05000000 (gap: 05000000:fb000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda1 console=tty0 console=ttyS0,115200 init 1 memmap=exactmap memmap=640K@0K memmap=4388K@16384K memmap=60507K@21413K elfcorehdr=21412K
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 2606.033 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Unknown interrupt or fault at EIP 00000292 00000060 c13e59c0
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 60268k/81920k available (2853k kernel code, 5088k reserved, 1078k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5216.50 BogoMIPS (lpj=2608250)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e68)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *6 7 10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10), disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
audit: initializing netlink socket (disabled)
audit(1116670046.359:0): initialized
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:03:0a.0[A] -> Link [LNKB] -> GSI 6 (level, low) -> IRQ 6
eth0: RealTek RTL8139 at 0xd800, 00:0c:6e:aa:a2:81, IRQ 6
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct10 20, ATA DISK drive
hdb: IC35L120AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
hdd: Maxtor 6Y160P0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=39560/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: max request size: 1024KiB
hdb: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdd: max request size: 1024KiB
hdd: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(33)
hdd: cache flushes supported
 hdd: hdd1
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugs is not available
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 10, io mem 0xdffffc00
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000e400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 3, io base 0x0000e800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x0000ec00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.1 (640 buckets, 5120 max) - 212 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
USB1 USB2 USB3 EHCI ICHB PS2M PS2K UAR1  MC9 
ACPI: (supports S0 S1 S4 S4bios S5)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 172k freed
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
INIT: version 2.86 booting
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
Setting parameters of disc: (none).
Activating swap.
Adding 976744k swap on /dev/hda2.  Priority:-1 extents:1
Checking root file system...
fsck 1.38-WIP (09-May-2005)
/: clean, 149577/1831424 files, 1195690/3662056 blocks
System time was Sat May 21 08:07:38 UTC 2005.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Sat May 21 10:07:40 CEST 2005.
Cleaning up ifupdown...done.
Calculating module dependencies... done.
Loading modules...
    ide-cd
FATAL: Module ide_cd not found.
    ide-generic
FATAL: Module ide_generic not found.
    rtc
FATAL: Module rtc not found.
All modules loaded.
Checking all file systems...
fsck 1.38-WIP (09-May-2005)
/home: clean, 14509/539616 files, 341093/1078308 blocks (check after next mount)
Setting kernel variables ...
... done.
Mounting local filesystems...
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
/dev/hda3 on /home type ext3 (rw)
/dev/hdb1 on /mnt/istorage tyEXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
pe ext3 (rw)
/dev/hdd1 on /mnt/mstorage type ext3 (rw)
Cleaning /tmp /var/run /var/lock.
Detecting hardware: i810_rng i810_tco 8139too piix ymfpci usb_uhci ehci_hcd
Skipping unavailable/built-in i810_rng module.
Skipping unavailable/built-in i810_tco module.
Skipping unavailable/built-in 8139too module.
Skipping unavailable/built-in piix module.
ymfpci disabled in configuration.
Skipping unavailable/built-in uhci_hcd module.
Skipping unavailable/built-in ehci_hcd module.
Running 0dns-down to make sure resolv.conf is ok...done.
Setting up networking...done.
Cleaning up /var/run/pppX-up files that might have been left by pppstatus .
Starting hotplug subsystem:
   pci     
     ignoring pci display device 01:00.0
   pci      [success]
   usb     
   usb      [success]
   isapnp  
   isapnp   [success]
   ide     
   ide      [success]
   input   
   input    [success]
   scsi    
   scsi     [success]
done.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
done.
Starting portmap daemon: portmap.
Starting portmapper...Mounting remote filesystems...
NFSv3 not supported!
mount: wrong fs type, bad option, bad superblock on 192.168.45.67:/root/zmei,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

NFSv3 not supported!
mount: wrong fs type, bad option, bad superblock on 192.168.45.67:/var/cache/apt/archives,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

Loading the saved-state of the serial devices... 

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Sat May 21 10:07:48 CEST 2005

Running ntpdate to synchronize clockError : Temporary failure in name resolution
.
Initializing random number generator...done.
Optimizing hardware...
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
INIT: Entering runlevel: 1
Sending all processes the TERM signal...done.
Sending all processes the KILL signal...done.
Entering single-user mode...
Going single user
INIT: Sending processes the TERM signal
Give root password for maintenance
(or type Control-D to continue): 
[root@zmei:10:08:21:~:502)->  cp /proc/vmcore .
cp: overwrite `./vmcore'? y
`/proc/vmcore' -> `./vmcore'
[root@zmei:10:08:58:~:503)->  d
total 449M
drwx------  3 root root 4.0K Oct 23  2004 Desktop
-rw-r--r--  1 root root 3.4K Mar 21 11:40 XF86Config.new
-rw-r--r--  1 root root  182 Dec  2 19:15 apt.conf
drwxr-xr-x  2 root root 4.0K May 16 08:48 bin
drwxr-xr-x  2 root root 4.0K May 16 08:48 cdrecord
-rw-r--r--  1 root root  180 Oct 22  2004 dbootstrap_settings
-rwxr-xr-x  1 root root  149 Mar 25 14:54 fw.sh
-rw-r--r--  1 root root 1.4K Oct 22  2004 install-report.template
-rw-r--r--  1 root root  190 May 21 10:06 kexec.log
-rw-r-----  1 root root    0 May 18 09:31 lock
-rw-r--r--  1 root root  107 Mar 17 12:03 minicom.log
drwxr-xr-x  4 root root 4.0K Oct 22  2004 old
drwxr-xr-x  2 root root 4.0K May 20 21:56 tmp
-r--------  1 root root 448M May 21 10:08 vmcore
[root@zmei:10:09:03:~:504)->  mknod /dev/oldmem c 1 12
mknod: `/dev/oldmem': File exists
[root@zmei:10:09:26:~:505)->  dd if=/dev/ild   oldmen m of=oldmem.001
1048456+0 records in
1048456+0 records out
536809472 bytes transferred in 28.358408 seconds (18929464 bytes/sec)
[root@zmei:10:10:12:~:506)->  d
total 961M
drwx------  3 root root 4.0K Oct 23  2004 Desktop
-rw-r--r--  1 root root 3.4K Mar 21 11:40 XF86Config.new
-rw-r--r--  1 root root  182 Dec  2 19:15 apt.conf
drwxr-xr-x  2 root root 4.0K May 16 08:48 bin
drwxr-xr-x  2 root root 4.0K May 16 08:48 cdrecord
-rw-r--r--  1 root root  180 Oct 22  2004 dbootstrap_settings
-rwxr-xr-x  1 root root  149 Mar 25 14:54 fw.sh
-rw-r--r--  1 root root 1.4K Oct 22  2004 install-report.template
-rw-r--r--  1 root root  190 May 21 10:06 kexec.log
-rw-r-----  1 root root    0 May 18 09:31 lock
-rw-r--r--  1 root root  107 Mar 17 12:03 minicom.log
drwxr-xr-x  4 root root 4.0K Oct 22  2004 old
-rw-r--r--  1 root root 512M May 21 10:10 oldmem.001
drwxr-xr-x  2 root root 4.0K May 20 21:56 tmp
-r--------  1 root root 448M May 21 10:08 vmcore
[root@zmei:10:10:17:~:508)->  reboot
INIT: Switching to runlevel: 6
[root@zmei:10:10:37:~:509)->  INIT: Sending processes the TERM signal
INIT: K01kdm: exit 0 1l
Stopping X display manager: xdm not running (/var/run/xdm.pid not found)
.
Stopping periodic command scheduler: cron.
Stopping apt-proxy.
K20dictd: exit 0 1l
Stopping DirMngr: dirmngr.
Stopping MTA: exim4.
Stopping internet superserver: inetd.
K20postgresql: exit 0 on 1L
Stopping OpenBSD Secure Shell server: sshd.
Stopping Network Traffic Monitoring Programs: tleds.
Stopping udftools packet writing:
/dev/pktcdvd/dvdwriter=/dev/hdc FATAL: Module pktcdvd not found.
Can't find pktcdvd character device
ctl open: No such file or directory
ERROR: Module pktcdvd does not exist in /proc/modules
Stopping X font server: xfs not running (/var/run/xfs.pid not found)
.
Stopping Xprint servers: Xprt.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Sat May 21 10:10:46 CEST 2005.
Shutting down ALSA...done.
Stopping NFS common utilities: statd.
Stopping NFS kernel daemon: mountd nfsd.
Unexporting directories for NFS kernel daemon...done.
Stopping deferred execution scheduler: atd.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Stopping web server: Apache2 ... no pidfile found! not running?.
/etc/init.d/rc: line 30: /etc/rc6.d/K91hsf: Permission denied
Sending all processes the TERM signal...done.
Sending all processes the KILL signal...done.
Saving random seed...done.
Unmounting remote and non-toplevel virtual filesystems...done.
Stopping portmap daemon: portmap.
Deconfiguring network interfaces...done.
Deactivating swap...umount: none busy - remounted read-only
done.
Unmounting local filesystems...umount: none busy - remounted read-only
done.
Rebooting... Restarting system.

--Boundary-00=_T9ujCogujYQrMIy--
