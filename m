Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVLFLT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVLFLT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLFLT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:19:28 -0500
Received: from mbox2.netikka.net ([213.250.81.203]:16594 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S1750747AbVLFLTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:19:24 -0500
From: Thomas Backlund <tmb@mandriva.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: greatly improve DMA handling
Date: Tue, 6 Dec 2005 13:19:15 +0200
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20051203200438.GA3770@havoc.gtf.org> <dn297e$aip$1@sea.gmane.org> <439554A3.7000305@pobox.com>
In-Reply-To: <439554A3.7000305@pobox.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zOXlDNpvw20tbLu"
Message-Id: <200512061319.15687.tmb@mandriva.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zOXlDNpvw20tbLu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

tisdag 06 december 2005 11:06 skrev Jeff Garzik:
> Thomas Backlund wrote:
> > Jeff Garzik wrote:
> >>To make it easy for others to test, since there are merge conflicts,
> >>I've combined the two previous sata_sil patches into a single patch.
> >>
> >>Verified here on my 3112 (Adaptec 1210SA).
> >>
> >>I'm especially interested to hear from anyone willing to test on a
> >>SI 3114 (4-port).
> >
> > Please cc me as I'm not subscribed....
> >
> >
> > ASUS K8N-E-Deluxe, nForce3 250Gb chipset, AMD Athlon64 3200+ running
> > x86_64
> >
> > Sil 3114A with 3 Maxtor MaxLine III+ 250GBSATA disks running in linux
> > raid1, linux raid0 and linux LVM2
> >
> > Boots and runs without problem with 2.6.15-rc5-git1,
> >
> > Applying this patch lets it boot, but I cant login either locally or with
> > ssh, no output on VT12 or in the logs, but the hd led is lit all the
> > time...
>
> Thanks for testing.
>
> > only way to reboot is the reset button...
> >
> >
> > Distribution is Mandriva Linux 2006 x86_64, gcc 4.0.1
> >
> > attached are config and /var/log/messages parts that got logged
>
> Didn't receive any attachments...
>
> 	Jeff

Sorry, my misstake ....
Here they are...
-- 
--
Regards

Thomas

--Boundary-00=_zOXlDNpvw20tbLu
Content-Type: text/plain;
  charset="iso-8859-1";
  name="messages"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="messages"

Dec  5 21:34:49 tmb syslogd 1.4.1: restart.
Dec  5 21:34:49 tmb kernel: klogd 1.4.1, log source =3D /proc/kmsg started.
Dec  5 21:34:49 tmb kernel: Inspecting /boot/System.map-2.6.15-rc5-git1.sil
Dec  5 21:34:49 tmb partmon: Kontrollerar om partitioner har tillr=E4ckligt=
 med diskutrymme:=20
Dec  5 21:34:49 tmb kernel: Loaded 19027 symbols from /boot/System.map-2.6.=
15-rc5-git1.sil.
Dec  5 21:34:49 tmb kernel: Symbols match kernel version 2.6.15.
Dec  5 21:34:49 tmb kernel: No module symbols loaded - kernel modules not e=
nabled.=20
Dec  5 21:34:49 tmb kernel: Bootdata ok (command line is BOOT_IMAGE=3D2615r=
c5-git1sil root=3D903)
Dec  5 21:34:49 tmb kernel: Linux version 2.6.15-rc5-git1.sil (thomas@tmb.h=
omelinux.net) (gcc version 4.0.1 (4.0.1-5mdk for Mandriva Linux release 200=
6.0)) #2 Mon Dec 5 19:46:52 EET 2005
Dec  5 21:34:49 tmb kernel: BIOS-provided physical RAM map:
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00=
 (usable)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000=
 (reserved)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000=
 (reserved)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 0000000000100000 - 000000003ffc0000=
 (usable)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 000000003ffc0000 - 000000003ffd0000=
 (ACPI data)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 000000003ffd0000 - 0000000040000000=
 (ACPI NVS)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000=
 (reserved)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000=
 (reserved)
Dec  5 21:34:49 tmb kernel:  BIOS-e820: 00000000ff7c0000 - 0000000100000000=
 (reserved)
Dec  5 21:34:49 tmb kernel: Nvidia board detected. Ignoring ACPI timer over=
ride.
Dec  5 21:34:49 tmb kernel: ACPI: PM-Timer IO Port: 0x4008
Dec  5 21:34:49 tmb kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabl=
ed)
Dec  5 21:34:49 tmb kernel: Processor #0 15:4 APIC version 16
Dec  5 21:34:49 tmb kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_=
base[0])
Dec  5 21:34:49 tmb kernel: IOAPIC[0]: apic_id 1, version 17, address 0xfec=
00000, GSI 0-23
Dec  5 21:34:49 tmb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2=
 dfl dfl)
Dec  5 21:34:49 tmb kernel: ACPI: BIOS IRQ0 pin2 override ignored.
Dec  5 21:34:49 tmb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9=
 high level)
Dec  5 21:34:49 tmb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq =
14 high edge)
Dec  5 21:34:49 tmb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq =
15 high edge)
Dec  5 21:34:49 tmb kernel: Setting APIC routing to flat
Dec  5 21:34:49 tmb kernel: Using ACPI (MADT) for SMP configuration informa=
tion
Dec  5 21:34:49 tmb kernel: Allocating PCI resources starting at 50000000 (=
gap: 40000000:bec00000)
Dec  5 21:34:49 tmb kernel: Checking aperture...
Dec  5 21:34:49 tmb kernel: CPU 0: aperture @ f8000000 size 64 MB
Dec  5 21:34:49 tmb kernel: Built 1 zonelists
Dec  5 21:34:49 tmb kernel: Kernel command line: BOOT_IMAGE=3D2615rc5-git1s=
il root=3D903
Dec  5 21:34:49 tmb kernel: Initializing CPU#0
Dec  5 21:34:49 tmb kernel: PID hash table entries: 4096 (order: 12, 131072=
 bytes)
Dec  5 21:34:49 tmb kernel: time.c: Using 3.579545 MHz PM timer.
Dec  5 21:34:49 tmb kernel: time.c: Detected 2009.821 MHz processor.
Dec  5 21:34:49 tmb kernel: time.c: Using PIT/TSC based timekeeping.
Dec  5 21:34:49 tmb kernel: Console: colour dummy device 80x25
Dec  5 21:34:49 tmb kernel: Dentry cache hash table entries: 131072 (order:=
 8, 1048576 bytes)
Dec  5 21:34:49 tmb kernel: Inode-cache hash table entries: 65536 (order: 7=
, 524288 bytes)
Dec  5 21:34:49 tmb kernel: Memory: 1028060k/1048320k available (2032k kern=
el code, 19776k reserved, 750k data, 184k init)
Dec  5 21:34:49 tmb kernel: Calibrating delay using timer specific routine.=
=2E 4023.89 BogoMIPS (lpj=3D8047781)
Dec  5 21:34:49 tmb kernel: Mount-cache hash table entries: 256
Dec  5 21:34:49 tmb kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 6=
4K (64 bytes/line)
Dec  5 21:34:49 tmb kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Dec  5 21:34:49 tmb kernel: mtrr: v2.0 (20020519)
Dec  5 21:34:49 tmb kernel: CPU: AMD Athlon(tm) 64 Processor 3200+ stepping=
 0a
Dec  5 21:34:49 tmb kernel: Using local APIC timer interrupts.
Dec  5 21:34:49 tmb kernel: Detected 12.561 MHz APIC timer.
Dec  5 21:34:49 tmb kernel: testing NMI watchdog ... OK.
Dec  5 21:34:49 tmb kernel: checking if image is initramfs...it isn't (no c=
pio magic); looks like an initrd
Dec  5 21:34:49 tmb kernel: NET: Registered protocol family 16
Dec  5 21:34:49 tmb kernel: ACPI: bus type pci registered
Dec  5 21:34:49 tmb kernel: PCI: Using configuration type 1
Dec  5 21:34:49 tmb kernel: ACPI: Subsystem revision 20050902
Dec  5 21:34:49 tmb kernel: ACPI: Interpreter enabled
Dec  5 21:34:49 tmb kernel: ACPI: Using IOAPIC for interrupt routing
Dec  5 21:34:49 tmb kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Dec  5 21:34:49 tmb kernel: ACPI: Power Resource [ISAV] (on)
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 =
19) *0, disabled.
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 =
19) *10
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 =
19) *11
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 =
19) *10
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 =
19) *11
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22)=
 *10
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22)=
 *9
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22)=
 *10
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22)=
 *11
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22)=
 *11
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22)=
 *0, disabled.
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22)=
 *0, disabled.
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22)=
 *0
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22)=
 *0, disabled.
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22)=
 *14
Dec  5 21:34:49 tmb kernel: PCI: Using ACPI for IRQ routing
Dec  5 21:34:49 tmb kernel: PCI: If a device doesn't work, try "pci=3Droute=
irq".  If it helps, post a report
Dec  5 21:34:49 tmb kernel: agpgart: Detected AGP bridge 0
Dec  5 21:34:49 tmb kernel: agpgart: Setting up Nforce3 AGP.
Dec  5 21:34:49 tmb kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Dec  5 21:34:49 tmb kernel: PCI-DMA: Disabling IOMMU.
Dec  5 21:34:49 tmb kernel: PCI: Bridge: 0000:00:0b.0
Dec  5 21:34:49 tmb kernel:   IO window: disabled.
Dec  5 21:34:49 tmb kernel:   MEM window: fc800000-fe8fffff
Dec  5 21:34:49 tmb kernel:   PREFETCH window: e4700000-f46fffff
Dec  5 21:34:49 tmb kernel: PCI: Bridge: 0000:00:0e.0
Dec  5 21:34:49 tmb kernel:   IO window: a000-bfff
Dec  5 21:34:49 tmb kernel:   MEM window: fe900000-feafffff
Dec  5 21:34:49 tmb kernel:   PREFETCH window: disabled.
Dec  5 21:34:49 tmb kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/2=
4 13:02:28 ak Exp $
Dec  5 21:34:49 tmb kernel: audit: initializing netlink socket (disabled)
Dec  5 21:34:49 tmb kernel: audit(1133818468.288:1): initialized
Dec  5 21:34:49 tmb kernel: VFS: Disk quotas dquot_6.5.1
Dec  5 21:34:49 tmb kernel: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
Dec  5 21:34:49 tmb kernel: Initializing Cryptographic API
Dec  5 21:34:49 tmb kernel: io scheduler noop registered
Dec  5 21:34:49 tmb kernel: io scheduler anticipatory registered
Dec  5 21:34:49 tmb kernel: io scheduler deadline registered
Dec  5 21:34:49 tmb kernel: io scheduler cfq registered
Dec  5 21:34:49 tmb kernel: vesafb: framebuffer at 0xe8000000, mapped to 0x=
ffffc20000080000, using 3072k, total 32768k
Dec  5 21:34:49 tmb kernel: vesafb: mode is 1024x768x16, linelength=3D2048,=
 pages=3D0
Dec  5 21:34:49 tmb kernel: vesafb: scrolling: redraw
Dec  5 21:34:49 tmb kernel: vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11=
:5:0
Dec  5 21:34:49 tmb kernel: vesafb: Mode is not VGA compatible
Dec  5 21:34:49 tmb kernel: Console: switching to colour frame buffer devic=
e 128x48
Dec  5 21:34:49 tmb kernel: fb0: VESA VGA frame buffer device
Dec  5 21:34:49 tmb kernel: Real Time Clock Driver v1.12
Dec  5 21:34:49 tmb kernel: Linux agpgart interface v0.101 (c) Dave Jones
Dec  5 21:34:49 tmb kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Dec  5 21:34:49 tmb kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec  5 21:34:49 tmb kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 p=
orts, IRQ sharing enabled
Dec  5 21:34:49 tmb kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a=
 16550A
Dec  5 21:34:49 tmb kernel: serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a=
 16550A
Dec  5 21:34:49 tmb kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a=
 16550A
Dec  5 21:34:49 tmb kernel: serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a=
 16550A
Dec  5 21:34:49 tmb kernel: RAMDISK driver initialized: 16 RAM disks of 320=
00K size 1024 blocksize
Dec  5 21:34:49 tmb kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@s=
use.de) and petero2@telia.com
Dec  5 21:34:49 tmb kernel: Uniform Multi-Platform E-IDE driver Revision: 7=
=2E00alpha2
Dec  5 21:34:49 tmb kernel: ide: Assuming 33MHz system bus speed for PIO mo=
des; override with idebus=3Dxx
Dec  5 21:34:49 tmb kernel: NFORCE3-250: IDE controller at PCI slot 0000:00=
:08.0
Dec  5 21:34:49 tmb kernel: NFORCE3-250: chipset revision 162
Dec  5 21:34:49 tmb kernel: NFORCE3-250: not 100%% native mode: will probe =
irqs later
Dec  5 21:34:49 tmb kernel: NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 cont=
roller
Dec  5 21:34:49 tmb kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS setting=
s: hda:pio, hdb:pio
Dec  5 21:34:49 tmb kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS setting=
s: hdc:DMA, hdd:pio
Dec  5 21:34:49 tmb kernel: hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM=
 drive
Dec  5 21:34:49 tmb kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  5 21:34:49 tmb kernel: mice: PS/2 mouse device common for all mice
Dec  5 21:34:49 tmb kernel: md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_D=
ISKS=3D27
Dec  5 21:34:49 tmb kernel: md: bitmap version 4.39
Dec  5 21:34:49 tmb kernel: NET: Registered protocol family 2
Dec  5 21:34:49 tmb kernel: input: AT Translated Set 2 keyboard as /class/i=
nput/input0
Dec  5 21:34:49 tmb kernel: IP route cache hash table entries: 32768 (order=
: 6, 262144 bytes)
Dec  5 21:34:49 tmb kernel: TCP established hash table entries: 131072 (ord=
er: 8, 1048576 bytes)
Dec  5 21:34:49 tmb kernel: TCP bind hash table entries: 65536 (order: 7, 5=
24288 bytes)
Dec  5 21:34:49 tmb kernel: TCP: Hash tables configured (established 131072=
 bind 65536)
Dec  5 21:34:49 tmb kernel: TCP reno registered
Dec  5 21:34:49 tmb kernel: TCP bic registered
Dec  5 21:34:49 tmb kernel: NET: Registered protocol family 1
Dec  5 21:34:49 tmb kernel: ACPI wakeup devices:=20
Dec  5 21:34:49 tmb kernel: PS2K PS2M UAR1 UAR2 USB0  MAC USB1 USB2 P0P1=20
Dec  5 21:34:49 tmb kernel: ACPI: (supports S0 S1 S3 S4 S5)
Dec  5 21:34:49 tmb kernel: BIOS EDD facility v0.16 2004-Jun-25, 3 devices =
found
Dec  5 21:34:49 tmb kernel: md: Autodetecting RAID arrays.
Dec  5 21:34:49 tmb kernel: md: autorun ...
Dec  5 21:34:49 tmb kernel: md: ... autorun DONE.
Dec  5 21:34:49 tmb kernel: RAMDISK: Compressed image found at block 0
Dec  5 21:34:49 tmb kernel: VFS: Mounted root (ext2 filesystem).
Dec  5 21:34:49 tmb kernel: md: raid1 personality registered as nr 3
Dec  5 21:34:49 tmb kernel: SCSI subsystem initialized
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ =
19
Dec  5 21:34:49 tmb kernel: GSI 16 sharing vector 0xB1 and IRQ 16
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [LN=
KC] -> GSI 19 (level, low) -> IRQ 177
Dec  5 21:34:49 tmb kernel: ata1: SATA max UDMA/100 cmd 0xFFFFC20000004880 =
ctl 0xFFFFC2000000488A bmdma 0xFFFFC20000004810 irq 177
Dec  5 21:34:49 tmb kernel: ata2: SATA max UDMA/100 cmd 0xFFFFC200000048C0 =
ctl 0xFFFFC200000048CA bmdma 0xFFFFC20000004818 irq 177
Dec  5 21:34:49 tmb kernel: ata3: SATA max UDMA/100 cmd 0xFFFFC20000004A80 =
ctl 0xFFFFC20000004A8A bmdma 0xFFFFC20000004A10 irq 177
Dec  5 21:34:49 tmb kernel: ata4: SATA max UDMA/100 cmd 0xFFFFC20000004AC0 =
ctl 0xFFFFC20000004ACA bmdma 0xFFFFC20000004A18 irq 177
Dec  5 21:34:49 tmb kernel: logips2pp: Detected unknown logitech mouse mode=
l 85
Dec  5 21:34:49 tmb kernel: input: ImPS/2 Logitech Wheel Mouse as /class/in=
put/input1
Dec  5 21:34:49 tmb kernel: ata1: dev 0 ATA-7, max UDMA/133, 490234752 sect=
ors: LBA48
Dec  5 21:34:49 tmb kernel: ata1: dev 0 configured for UDMA/100
Dec  5 21:34:49 tmb kernel: scsi0 : sata_sil
Dec  5 21:34:49 tmb kernel: ata2: dev 0 ATA-7, max UDMA/133, 490234752 sect=
ors: LBA48
Dec  5 21:34:49 tmb kernel: ata2: dev 0 configured for UDMA/100
Dec  5 21:34:49 tmb kernel: scsi1 : sata_sil
Dec  5 21:34:49 tmb kernel: ata3: dev 0 ATA-7, max UDMA/133, 490234752 sect=
ors: LBA48
Dec  5 21:34:49 tmb kernel: ata3: dev 0 configured for UDMA/100
Dec  5 21:34:49 tmb kernel: scsi2 : sata_sil
Dec  5 21:34:49 tmb kernel: ata4: no device found (phy stat 00000000)
Dec  5 21:34:49 tmb kernel: scsi3 : sata_sil
Dec  5 21:34:49 tmb kernel:   Vendor: ATA       Model: Maxtor 7L250S0    Re=
v: BANC
Dec  5 21:34:49 tmb kernel:   Type:   Direct-Access                      AN=
SI SCSI revision: 05
Dec  5 21:34:49 tmb kernel:   Vendor: ATA       Model: Maxtor 7L250S0    Re=
v: BANC
Dec  5 21:34:49 tmb kernel:   Type:   Direct-Access                      AN=
SI SCSI revision: 05
Dec  5 21:34:49 tmb kernel:   Vendor: ATA       Model: Maxtor 7L250S0    Re=
v: BANC
Dec  5 21:34:49 tmb kernel:   Type:   Direct-Access                      AN=
SI SCSI revision: 05
Dec  5 21:34:49 tmb kernel: SCSI device sda: 490234752 512-byte hdwr sector=
s (251000 MB)
Dec  5 21:34:49 tmb kernel: SCSI device sda: drive cache: write back
Dec  5 21:34:49 tmb kernel: SCSI device sda: 490234752 512-byte hdwr sector=
s (251000 MB)
Dec  5 21:34:49 tmb kernel: SCSI device sda: drive cache: write back
Dec  5 21:34:49 tmb kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda1=
0 >
Dec  5 21:34:49 tmb kernel: sd 0:0:0:0: Attached scsi disk sda
Dec  5 21:34:49 tmb kernel: SCSI device sdb: 490234752 512-byte hdwr sector=
s (251000 MB)
Dec  5 21:34:49 tmb kernel: SCSI device sdb: drive cache: write back
Dec  5 21:34:49 tmb kernel: SCSI device sdb: 490234752 512-byte hdwr sector=
s (251000 MB)
Dec  5 21:34:49 tmb kernel: SCSI device sdb: drive cache: write back
Dec  5 21:34:49 tmb kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb1=
0 >
Dec  5 21:34:49 tmb kernel: sd 1:0:0:0: Attached scsi disk sdb
Dec  5 21:34:49 tmb kernel: SCSI device sdc: 490234752 512-byte hdwr sector=
s (251000 MB)
Dec  5 21:34:49 tmb kernel: SCSI device sdc: drive cache: write back
Dec  5 21:34:49 tmb kernel: SCSI device sdc: 490234752 512-byte hdwr sector=
s (251000 MB)
Dec  5 21:34:49 tmb kernel: SCSI device sdc: drive cache: write back
Dec  5 21:34:49 tmb kernel:  sdc: sdc1
Dec  5 21:34:49 tmb kernel: sd 2:0:0:0: Attached scsi disk sdc
Dec  5 21:34:49 tmb kernel: md: md3 stopped.
Dec  5 21:34:49 tmb kernel: md: bind<sdb7>
Dec  5 21:34:49 tmb kernel: md: bind<sda7>
Dec  5 21:34:49 tmb kernel: raid1: raid set md3 active with 2 out of 2 mirr=
ors
Dec  5 21:34:49 tmb kernel: kjournald starting.  Commit interval 5 seconds
Dec  5 21:34:49 tmb kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  5 21:34:49 tmb kernel: Freeing unused kernel memory: 184k freed
Dec  5 21:34:49 tmb kernel: usbcore: registered new driver usbfs
Dec  5 21:34:49 tmb kernel: usbcore: registered new driver hub
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LUS0] enabled at IRQ =
22
Dec  5 21:34:49 tmb kernel: GSI 17 sharing vector 0xB9 and IRQ 17
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LU=
S0] -> GSI 22 (level, low) -> IRQ 185
Dec  5 21:34:49 tmb kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
Dec  5 21:34:49 tmb kernel: ohci_hcd 0000:00:02.0: new USB bus registered, =
assigned bus number 1
Dec  5 21:34:49 tmb kernel: ohci_hcd 0000:00:02.0: irq 185, io mem 0xfebfd0=
00
Dec  5 21:34:49 tmb kernel: hub 1-0:1.0: USB hub found
Dec  5 21:34:49 tmb kernel: hub 1-0:1.0: 4 ports detected
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LUS1] enabled at IRQ =
21
Dec  5 21:34:49 tmb kernel: GSI 18 sharing vector 0xC1 and IRQ 18
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LU=
S1] -> GSI 21 (level, low) -> IRQ 193
Dec  5 21:34:49 tmb kernel: ohci_hcd 0000:00:02.1: OHCI Host Controller
Dec  5 21:34:49 tmb kernel: ohci_hcd 0000:00:02.1: new USB bus registered, =
assigned bus number 2
Dec  5 21:34:49 tmb kernel: ohci_hcd 0000:00:02.1: irq 193, io mem 0xfebfe0=
00
Dec  5 21:34:49 tmb kernel: hub 2-0:1.0: USB hub found
Dec  5 21:34:49 tmb kernel: hub 2-0:1.0: 4 ports detected
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LUS2] enabled at IRQ =
20
Dec  5 21:34:49 tmb kernel: GSI 19 sharing vector 0xC9 and IRQ 19
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LU=
S2] -> GSI 20 (level, low) -> IRQ 201
Dec  5 21:34:49 tmb kernel: ehci_hcd 0000:00:02.2: EHCI Host Controller
Dec  5 21:34:49 tmb kernel: ehci_hcd 0000:00:02.2: debug port 1
Dec  5 21:34:49 tmb kernel: ehci_hcd 0000:00:02.2: new USB bus registered, =
assigned bus number 3
Dec  5 21:34:49 tmb kernel: ehci_hcd 0000:00:02.2: irq 201, io mem 0xfebffc=
00
Dec  5 21:34:49 tmb kernel: ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.=
00, driver 10 Dec 2004
Dec  5 21:34:49 tmb kernel: hub 3-0:1.0: USB hub found
Dec  5 21:34:49 tmb kernel: hub 3-0:1.0: 8 ports detected
Dec  5 21:34:49 tmb kernel: ts: Compaq touchscreen protocol output
Dec  5 21:34:49 tmb kernel: ACPI: Power Button (FF) [PWRF]
Dec  5 21:34:49 tmb kernel: ACPI: Power Button (CM) [PWRB]
Dec  5 21:34:49 tmb kernel: ibm_acpi: ec object not found
Dec  5 21:34:49 tmb kernel: EXT3 FS on md3, internal journal
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LTID] BIOS reported I=
RQ 0, using IRQ 22
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LTID] enabled at IRQ =
22
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LT=
ID] -> GSI 22 (level, low) -> IRQ 185
Dec  5 21:34:49 tmb kernel: ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmd=
ma 0xC800 irq 185
Dec  5 21:34:49 tmb kernel: ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmd=
ma 0xC808 irq 185
Dec  5 21:34:49 tmb kernel: ata5: no device found (phy stat 00000000)
Dec  5 21:34:49 tmb kernel: scsi4 : sata_nv
Dec  5 21:34:49 tmb kernel: ata6: no device found (phy stat 00000000)
Dec  5 21:34:49 tmb kernel: scsi5 : sata_nv
Dec  5 21:34:49 tmb kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initial=
ised: dm-devel@redhat.com
Dec  5 21:34:49 tmb kernel: md: md0 stopped.
Dec  5 21:34:49 tmb kernel: md: bind<sdb1>
Dec  5 21:34:49 tmb kernel: md: bind<sda1>
Dec  5 21:34:49 tmb kernel: md: raid0 personality registered as nr 2
Dec  5 21:34:49 tmb kernel: md0: setting max_sectors to 128, segment bounda=
ry to 32767
Dec  5 21:34:49 tmb kernel: raid0: looking at sda1
Dec  5 21:34:49 tmb kernel: raid0:   comparing sda1(10233280) with sda1(102=
33280)
Dec  5 21:34:49 tmb kernel: raid0:   END
Dec  5 21:34:49 tmb kernel: raid0:   =3D=3D> UNIQUE
Dec  5 21:34:49 tmb kernel: raid0: 1 zones
Dec  5 21:34:49 tmb kernel: raid0: looking at sdb1
Dec  5 21:34:49 tmb kernel: raid0:   comparing sdb1(10233280) with sda1(102=
33280)
Dec  5 21:34:49 tmb kernel: raid0:   EQUAL
Dec  5 21:34:49 tmb kernel: raid0: FINAL 1 zones
Dec  5 21:34:49 tmb kernel: raid0: done.
Dec  5 21:34:49 tmb kernel: raid0 : md_size is 20466560 blocks.
Dec  5 21:34:49 tmb kernel: raid0 : conf->hash_spacing is 20466560 blocks.
Dec  5 21:34:49 tmb kernel: raid0 : nb_zone is 1.
Dec  5 21:34:49 tmb kernel: raid0 : Allocating 8 bytes for hash.
Dec  5 21:34:49 tmb kernel: md: md1 stopped.
Dec  5 21:34:49 tmb kernel: md: bind<sdb5>
Dec  5 21:34:49 tmb kernel: md: bind<sda5>
Dec  5 21:34:49 tmb kernel: raid1: raid set md1 active with 2 out of 2 mirr=
ors
Dec  5 21:34:49 tmb kernel: md: md2 stopped.
Dec  5 21:34:49 tmb kernel: md: bind<sdb6>
Dec  5 21:34:49 tmb kernel: md: bind<sda6>
Dec  5 21:34:49 tmb kernel: raid1: raid set md2 active with 2 out of 2 mirr=
ors
Dec  5 21:34:49 tmb kernel: md: md4 stopped.
Dec  5 21:34:49 tmb kernel: md: bind<sdb8>
Dec  5 21:34:49 tmb kernel: md: bind<sda8>
Dec  5 21:34:49 tmb kernel: raid1: raid set md4 active with 2 out of 2 mirr=
ors
Dec  5 21:34:49 tmb kernel: md: md5 stopped.
Dec  5 21:34:49 tmb kernel: md: bind<sdb9>
Dec  5 21:34:49 tmb kernel: md: bind<sda9>
Dec  5 21:34:49 tmb kernel: raid1: raid set md5 active with 2 out of 2 mirr=
ors
Dec  5 21:34:49 tmb kernel: kjournald starting.  Commit interval 5 seconds
Dec  5 21:34:49 tmb kernel: EXT3 FS on md2, internal journal
Dec  5 21:34:49 tmb kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  5 21:34:49 tmb kernel: kjournald starting.  Commit interval 5 seconds
Dec  5 21:34:49 tmb kernel: EXT3 FS on md4, internal journal
Dec  5 21:34:49 tmb kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  5 21:34:49 tmb kernel: SGI XFS with ACLs, large block/inode numbers, n=
o debug enabled
Dec  5 21:34:49 tmb kernel: SGI XFS Quota Management subsystem
Dec  5 21:34:49 tmb kernel: XFS mounting filesystem dm-0
Dec  5 21:34:49 tmb kernel: kjournald starting.  Commit interval 5 seconds
Dec  5 21:34:49 tmb kernel: EXT3 FS on md5, internal journal
Dec  5 21:34:49 tmb kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  5 21:34:49 tmb kernel: kjournald starting.  Commit interval 5 seconds
Dec  5 21:34:49 tmb kernel: EXT3 FS on md0, internal journal
Dec  5 21:34:49 tmb kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  5 21:34:49 tmb kernel: loop: loaded (max 8 devices)
Dec  5 21:34:49 tmb kernel: Adding 1020024k swap on /dev/md1.  Priority:-1 =
extents:1 across:1020024k
Dec  5 21:34:49 tmb kernel: ohci1394: $Rev: 1313 $ Ben Collins <bcollins@de=
bian.org>
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ =
18
Dec  5 21:34:49 tmb kernel: GSI 20 sharing vector 0xD1 and IRQ 20
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [LN=
KB] -> GSI 18 (level, low) -> IRQ 209
Dec  5 21:34:49 tmb kernel: PCI: Via IRQ fixup for 0000:02:0b.0, from 10 to=
 1
Dec  5 21:34:49 tmb kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D=
[209]  MMIO=3D[feaff000-feaff7ff]  Max Packet=3D[2048]
Dec  5 21:34:49 tmb kernel: hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA=
(33)
Dec  5 21:34:49 tmb kernel: Uniform CD-ROM driver Revision: 3.20
Dec  5 21:34:49 tmb kernel: ip_conntrack version 2.4 (4095 buckets, 32760 m=
ax) - 312 bytes per conntrack
Dec  5 21:34:49 tmb kernel: ip_tables: (C) 2000-2002 Netfilter core team
Dec  5 21:34:49 tmb kernel: NET: Registered protocol family 17
Dec  5 21:34:49 tmb kernel: forcedeth.c: Reverse Engineered nForce ethernet=
 driver. Version 0.47.
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LKLN] enabled at IRQ =
21
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LK=
LN] -> GSI 21 (level, low) -> IRQ 193
Dec  5 21:34:49 tmb kernel: eth0: forcedeth.c: subsystem: 01043:80a7 bound =
to 0000:00:05.0
Dec  5 21:34:49 tmb kernel: eth0: no link during initialization.
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ =
17
Dec  5 21:34:49 tmb kernel: GSI 21 sharing vector 0xD9 and IRQ 21
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LN=
KD] -> GSI 17 (level, low) -> IRQ 217
Dec  5 21:34:49 tmb kernel: 3c59x: Donald Becker and others. www.scyld.com/=
network/vortex.html
Dec  5 21:34:49 tmb kernel: 0000:02:09.0: 3Com PCI 3c905C Tornado at ffffc2=
0000462c00. Vers LK1.1.19
Dec  5 21:34:49 tmb kernel: ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LN=
KD] -> GSI 17 (level, low) -> IRQ 217
Dec  5 21:34:49 tmb kernel: eth0: link up.

--Boundary-00=_zOXlDNpvw20tbLu
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc5-git1.sil
# Mon Dec  5 19:39:46 2005
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=m
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=m

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
CONFIG_IP_ROUTE_MULTIPATH_RR=m
CONFIG_IP_ROUTE_MULTIPATH_RANDOM=m
CONFIG_IP_ROUTE_MULTIPATH_WRANDOM=m
CONFIG_IP_ROUTE_MULTIPATH_DRR=m
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_NETBIOS_NS is not set
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_PPTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
# CONFIG_IP_NF_MATCH_DCCP is not set
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_CONNMARK=m
# CONFIG_IP_NF_MATCH_CONNBYTES is not set
CONFIG_IP_NF_MATCH_HASHLIMIT=m
# CONFIG_IP_NF_MATCH_STRING is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_TARGET_NFQUEUE is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_PPTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_CONNMARK=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_PHYSDEV=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
# CONFIG_IP6_NF_TARGET_REJECT is not set
# CONFIG_IP6_NF_TARGET_NFQUEUE is not set
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_RAW=m

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_ULOG=m

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_HMAC_NONE=y
# CONFIG_SCTP_HMAC_SHA1 is not set
# CONFIG_SCTP_HMAC_MD5 is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=m
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_ESTIMATOR=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_MCP2120_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m
CONFIG_ACT200L_DONGLE=m

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m
CONFIG_VIA_FIR=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=m
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=m
# CONFIG_RFD_FTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_AMDSTD_RETRY=0
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0x4000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PNC2000=m
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
CONFIG_MTD_TS5500=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_DILNETPC=m
CONFIG_MTD_DILNETPC_BOOTSIZE=0x80000
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLKMTD=m
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=m
CONFIG_MTD_DOC2001=m
CONFIG_MTD_DOC2001PLUS=m
CONFIG_MTD_DOCPROBE=m
CONFIG_MTD_DOCECC=m
CONFIG_MTD_DOCPROBE_ADVANCED=y
CONFIG_MTD_DOCPROBE_ADDRESS=0x0000
CONFIG_MTD_DOCPROBE_HIGH=y
CONFIG_MTD_DOCPROBE_55AA=y

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
CONFIG_MTD_NAND_IDS=m
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
# CONFIG_MTD_NAND_NANDSIM is not set

#
# OneNAND Flash Device Drivers
#
# CONFIG_MTD_ONENAND is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_NOT_PC=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=32000
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=m
# CONFIG_BLK_DEV_CY82C693 is not set
CONFIG_BLK_DEV_CS5520=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=y
CONFIG_HPT34X_AUTODMA=y
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT821X=m
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_SATA=m
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_MV is not set
CONFIG_SCSI_SATA_NV=m
# CONFIG_SCSI_PDC_ADMA is not set
CONFIG_SCSI_SATA_QSTOR=m
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
CONFIG_SCSI_SATA_SIL24=m
CONFIG_SCSI_SATA_SIS=m
CONFIG_SCSI_SATA_ULI=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
CONFIG_SCSI_SATA_INTEL_COMBINED=y
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA2XXX=m
CONFIG_SCSI_QLA21XX=m
CONFIG_SCSI_QLA22XX=m
CONFIG_SCSI_QLA2300=m
CONFIG_SCSI_QLA2322=m
CONFIG_SCSI_QLA6312=m
# CONFIG_SCSI_QLA24XX is not set
CONFIG_SCSI_LPFC=m
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_EMC=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_EXT_ADAPTEC_DMA64=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
# CONFIG_I2O_BUS is not set
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m

#
# ARCnet devices
#
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
# CONFIG_ULI526X is not set
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_HP100=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
# CONFIG_AMD8111E_NAPI is not set
CONFIG_ADAPTEC_STARFIRE=m
# CONFIG_ADAPTEC_STARFIRE_NAPI is not set
CONFIG_B44=m
CONFIG_FORCEDETH=m
CONFIG_DGRS=m
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
# CONFIG_R8169_NAPI is not set
# CONFIG_R8169_VLAN is not set
CONFIG_SIS190=m
# CONFIG_SKGE is not set
CONFIG_SK98LIN=m
CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m
CONFIG_BNX2=m

#
# Ethernet (10000 Mbit)
#
CONFIG_CHELSIO_T1=m
CONFIG_IXGB=m
# CONFIG_IXGB_NAPI is not set
CONFIG_S2IO=m
# CONFIG_S2IO_NAPI is not set

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMOL=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_ABYSS=m

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=m
CONFIG_PCMCIA_WAVELAN=m
CONFIG_PCMCIA_NETWAVE=m

#
# Wireless 802.11 Frequency Hopping cards support
#
CONFIG_PCMCIA_RAYCS=m

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IPW2100=m
CONFIG_IPW2100_MONITOR=y
# CONFIG_IPW_DEBUG is not set
CONFIG_IPW2200=m
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
# CONFIG_NORTEL_HERMES is not set
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_PCMCIA_SPECTRUM is not set
CONFIG_AIRO_CS=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_PCMCIA_WL3501=m

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m
CONFIG_ARCNET_COM20020_CS=m

#
# Wan interfaces
#
CONFIG_WAN=y
# CONFIG_DSCC4 is not set
# CONFIG_LANMEDIA is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=y
CONFIG_HDLC_RAW_ETH=y
CONFIG_HDLC_CISCO=y
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y
CONFIG_HDLC_X25=y
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300=m
# CONFIG_PC300_MLPPP is not set
CONFIG_FARSYNC=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_WAN_ROUTER_DRIVERS=y
CONFIG_CYCLADES_SYNC=m
CONFIG_CYCLOMX_X25=y
# CONFIG_LAPBETHER is not set
# CONFIG_X25_ASY is not set
CONFIG_SBNI=m
CONFIG_SBNI_MULTILINE=y

#
# ATM drivers
#
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
# CONFIG_ATM_AMBASSADOR is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_USE_TASKLET=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_MPPE is not set
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_FC=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
# CONFIG_IPPP_FILTER is not set
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
# CONFIG_ISDN_X25 is not set

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
CONFIG_HISAX_DEBUG=y

#
# HiSax PCMCIA card service modules
#
CONFIG_HISAX_SEDLBAUER_CS=m
CONFIG_HISAX_ELSA_CS=m
CONFIG_HISAX_AVM_A1_CS=m
CONFIG_HISAX_TELES_CS=m

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=m
CONFIG_HISAX_HFCUSB=m
CONFIG_HISAX_HFC4S8S=m
CONFIG_HISAX_FRITZ_PCIPNP=m
CONFIG_HISAX_HDLC=y

#
# Active cards
#
CONFIG_HYSDN=m
# CONFIG_HYSDN_CAPI is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
# CONFIG_ISDN_DRV_AVMB1_B1PCIV4 is not set
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m

#
# Active Eicon DIVA Server cards
#
CONFIG_CAPI_EICON=y
CONFIG_ISDN_DIVAS=m
CONFIG_ISDN_DIVAS_BRIPCI=y
CONFIG_ISDN_DIVAS_PRIPCI=y
CONFIG_ISDN_DIVAS_DIVACAPI=m
CONFIG_ISDN_DIVAS_USERIDI=m
CONFIG_ISDN_DIVAS_MAINT=m

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_PHONE_IXJ_PCMCIA=m

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
# CONFIG_SPECIALIX_RTSCTS is not set
CONFIG_SX=m
# CONFIG_RIO is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_TIPAR=m

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_I8XX_TCO=m
CONFIG_SC1200_WDT=m
CONFIG_60XX_WDT=m
# CONFIG_SBC8360_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_APPLICOM=m

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=m
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
# CONFIG_DRM_I830 is not set
CONFIG_DRM_I915=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
CONFIG_TCG_TPM=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
# CONFIG_I2C_I810 is not set
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_STUB=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m

#
# Miscellaneous I2C Chip support
#
CONFIG_SENSORS_DS1337=m
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
# CONFIG_SENSORS_PCA9539 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
CONFIG_W1=m
CONFIG_W1_MATROX=m
CONFIG_W1_DS9490=m
CONFIG_W1_DS9490_BRIDGE=m
CONFIG_W1_THERM=m
CONFIG_W1_SMEM=m
# CONFIG_W1_DS2433 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
CONFIG_IBM_ASM=m

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_BT848_DVB is not set
# CONFIG_VIDEO_SAA6588 is not set
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5246A=m
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
CONFIG_VIDEO_STRADIS=m
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DPC=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_HEXIUM_GEMINI=m
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_EM28XX is not set
CONFIG_VIDEO_OVCAMCHIP=m
# CONFIG_VIDEO_AUDIO_DECODER is not set
# CONFIG_VIDEO_DECODER is not set

#
# Radio Adapters
#
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=y
CONFIG_DVB_CORE=m

#
# Supported SAA7146 based PCI Adapters
#
CONFIG_DVB_AV7110=m
# CONFIG_DVB_AV7110_FIRMWARE is not set
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m

#
# Supported USB Adapters
#
# CONFIG_DVB_USB is not set
CONFIG_DVB_TTUSB_BUDGET=m
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_DVB_CINERGYT2=m
# CONFIG_DVB_CINERGYT2_TUNING is not set

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_DEBUG is not set

#
# Supported BT878 Adapters
#
CONFIG_DVB_BT8XX=m

#
# Supported Pluto2 Adapters
#
# CONFIG_DVB_PLUTO2 is not set

#
# Supported DVB Frontends
#

#
# Customise DVB Frontends
#

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_STV0299=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA80XX=m
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_S5H1420=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_ATMEL_AT76C651=m
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terresterial DTV) frontends
#
CONFIG_DVB_NXT2002=m
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
# CONFIG_FB_HGA_ACCEL is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_MATROX_MAVEN is not set
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_RADEON_OLD=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY_XL_INIT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_CYBLA is not set
CONFIG_FB_TRIDENT=m
# CONFIG_FB_TRIDENT_ACCEL is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_GX1=m
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_GENERIC_DRIVER=y

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
CONFIG_SND_ALI5451=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_CA0106=m
CONFIG_SND_KORG1212=m
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VX222=m
CONFIG_SND_HDA_INTEL=m

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m

#
# PCMCIA devices
#

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_OBSOLETE_OSS_DRIVER is not set
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
# CONFIG_PSS_MIXER is not set
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0x0
CONFIG_AEDSP16_MSS=y
# CONFIG_AEDSP16_SBPRO is not set
CONFIG_AEDSP16_MPU401=y
# CONFIG_SOUND_TVMIXER is not set
CONFIG_SOUND_KAHLUA=m

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_ACECAD=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
# CONFIG_USB_ITMTOUCH is not set
CONFIG_USB_EGALAX=m
# CONFIG_USB_YEALINK is not set
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_SE401=m
CONFIG_USB_SN9C102=m
CONFIG_USB_STV680=m
CONFIG_USB_W9968CF=m
CONFIG_USB_PWC=m

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=m
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_ZD1201=m
CONFIG_USB_MON=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRPRIME=m
# CONFIG_USB_SERIAL_ANYDATA is not set
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_PHIDGETKIT=m
CONFIG_USB_PHIDGETSERVO=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_SISUSBVGA_CON is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TEST=m

#
# USB DSL modem support
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
# CONFIG_USB_CXACRU is not set
# CONFIG_USB_XUSBATM is not set

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_SELECTED=y
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_FILE_STORAGE=m
# CONFIG_USB_FILE_STORAGE_TEST is not set
CONFIG_USB_G_SERIAL=m

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_WBSD=m

#
# InfiniBand support
#
CONFIG_INFINIBAND=m
# CONFIG_INFINIBAND_USER_MAD is not set
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
# CONFIG_INFINIBAND_SRP is not set

#
# SN Devices
#

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_JFFS_PROC_FS=y
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=y
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
# CONFIG_NCPFS_IOCTL_LOCKING is not set
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_AES_X86_64 is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y

--Boundary-00=_zOXlDNpvw20tbLu--
