Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVCKTyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVCKTyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCKTuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:50:13 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:1993 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261557AbVCKTfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:35:40 -0500
Date: Fri, 11 Mar 2005 20:36:13 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
In-Reply-To: <1110559685.4822.15.camel@eeyore>
Message-ID: <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net>
References: <20050304234622.63e8a335.akpm@osdl.org> 
 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net> <1110559685.4822.15.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your prompt anwser.


On Fri, 11 Mar 2005, Bjorn Helgaas wrote:
> On Fri, 2005-03-11 at 00:08 +0100, Grzegorz Kulewski wrote:
>> Anything new about it?
>>
>> Can I provide more usefull info?
>
> Can you check to see whether there are any BIOS updates available
> for your box?  It looks to me like your USB controllers are wired
> to IRQ9, and that's how the BIOS is leaving them configured.

Unfortunatelly its 3 years ABIT KG7-Lite. I was begging ABIT for update 
(to fix some other problems with new CPUs) some time ago but they refused 
to make new BIOS for this board. And I have the newset release.

And if this is a BIOS issue then why it worked for 3 years with all 
kernels up to at least 2.6.9 (only -mm kernels had some problems with USB 
and other subsystems since I think 2.6.3-mm? or something like that - I 
stopped using them soon after)?

BTW. My mainboard manual says: "PCI-4 and USB controllers share an IRQ" 
(the manual is on www.abit.com.tw so you can check it).


> But ACPI is telling us they're on IRQ10, which seems like a BIOS
> bug.

Maybe this is just some off-by-one in recent kernels? ;-)


> Can you also post the complete dmesg log without "acpi=off"?  There
> might be an ACPI interrupt link device for the USB controller, and
> maybe there's something wrong there.

Ok, here it goes:

Mar  2 23:36:56 kangur syslog-ng[10153]: syslog-ng version 1.6.4 starting
Mar  2 23:36:56 kangur syslog-ng[10153]: Changing permissions on special 
file /dev/tty12
Mar  2 23:36:56 kangur Linux version 2.6.11-cko1 (root@kangur) (gcc 
version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 
Wed Mar 2 20:48:19 CET 2005
Mar  2 23:36:56 kangur BIOS-provided physical RAM map:
Mar  2 23:36:56 kangur BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Mar  2 23:36:56 kangur BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Mar  2 23:36:56 kangur BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Mar  2 23:36:56 kangur BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Mar  2 23:36:56 kangur BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Mar  2 23:36:56 kangur BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Mar  2 23:36:56 kangur BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Mar  2 23:36:56 kangur 511MB LOWMEM available.
Mar  2 23:36:56 kangur On node 0 totalpages: 131056
Mar  2 23:36:56 kangur DMA zone: 4096 pages, LIFO batch:1
Mar  2 23:36:56 kangur Normal zone: 126960 pages, LIFO batch:16
Mar  2 23:36:56 kangur HighMem zone: 0 pages, LIFO batch:1
Mar  2 23:36:56 kangur DMI 2.2 present.
Mar  2 23:36:56 kangur ACPI: RSDP (v000 761686 
) @ 0x000f6a70
Mar  2 23:36:56 kangur ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
Mar  2 23:36:56 kangur ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
Mar  2 23:36:56 kangur ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
Mar  2 23:36:56 kangur ACPI: PM-Timer IO Port: 0x4008
Mar  2 23:36:56 kangur Allocating PCI resources starting at 20000000 (gap: 
20000000:dfff0000)
Mar  2 23:36:56 kangur Built 1 zonelists
Mar  2 23:36:56 kangur Kernel command line: ro root=/dev/hdb4
Mar  2 23:36:56 kangur Local APIC disabled by BIOS -- you can enable it 
with "lapic"
Mar  2 23:36:56 kangur mapped APIC to ffffd000 (01402000)
Mar  2 23:36:56 kangur Initializing CPU#0
Mar  2 23:36:56 kangur CPU 0 irqstacks, hard=b0476000 soft=b0475000
Mar  2 23:36:56 kangur PID hash table entries: 2048 (order: 11, 32768 
bytes)
Mar  2 23:36:56 kangur Detected 1203.036 MHz processor.
Mar  2 23:36:56 kangur Using pmtmr for high-res timesource
Mar  2 23:36:56 kangur Console: colour VGA+ 80x25
Mar  2 23:36:56 kangur Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Mar  2 23:36:56 kangur Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Mar  2 23:36:56 kangur Memory: 514944k/524224k available (2543k kernel 
code, 8728k reserved, 815k data, 156k init, 0k highmem)
Mar  2 23:36:56 kangur Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Mar  2 23:36:56 kangur Calibrating delay loop... 2375.68 BogoMIPS 
(lpj=1187840)
Mar  2 23:36:56 kangur Security Framework v1.0.0 initialized
Mar  2 23:36:56 kangur Capability LSM initialized
Mar  2 23:36:56 kangur Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Mar  2 23:36:56 kangur CPU: After generic identify, caps: 0383f9ff 
c1cbf9ff 00000000 00000000 00000000 00000000 00000000Mar  2 23:36:56 
kangur CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 
00000000 00000000 00000000 00000000
Mar  2 23:36:56 kangur CPU: CLK_CTL MSR was 60071263. Reprogramming to 
20071263
Mar  2 23:36:56 kangur CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Mar  2 23:36:56 kangur CPU: L2 Cache: 512K (64 bytes/line)
Mar  2 23:36:56 kangur CPU: After all inits, caps: 0383f9ff c1cbf9ff 
00000000 00000020 00000000 00000000 00000000
Mar  2 23:36:56 kangur Intel machine check architecture supported.
Mar  2 23:36:56 kangur Intel machine check reporting enabled on CPU#0.
Mar  2 23:36:56 kangur CPU: AMD Unknown CPU Type stepping 00
Mar  2 23:36:56 kangur Enabling fast FPU save and restore... done.
Mar  2 23:36:56 kangur Enabling unmasked SIMD FPU exception support... 
done.
Mar  2 23:36:56 kangur Checking 'hlt' instruction... OK.
Mar  2 23:36:56 kangur ACPI: setting ELCR to 0800 (from 0e20)
Mar  2 23:36:56 kangur NET: Registered protocol family 16
Mar  2 23:36:56 kangur PCI: PCI BIOS revision 2.10 entry at 0xfb690, last 
bus=1
Mar  2 23:36:56 kangur PCI: Using configuration type 1
Mar  2 23:36:56 kangur mtrr: v2.0 (20020519)
Mar  2 23:36:56 kangur ACPI: Subsystem revision 20050211
Mar  2 23:36:56 kangur ACPI: Interpreter enabled
Mar  2 23:36:56 kangur ACPI: Using PIC for interrupt routing
Mar  2 23:36:56 kangur ACPI: PCI Root Bridge [PCI0] (00:00)
Mar  2 23:36:56 kangur PCI: Probing PCI hardware (bus 00)
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 11 12 14 15) *9
Mar  2 23:36:56 kangur Linux Plug and Play Support v0.97 (c) Adam Belay
Mar  2 23:36:56 kangur pnp: PnP ACPI init
Mar  2 23:36:56 kangur pnp: PnP ACPI: found 12 devices
Mar  2 23:36:56 kangur SCSI subsystem initialized
Mar  2 23:36:56 kangur PCI: Using ACPI for IRQ routing
Mar  2 23:36:56 kangur ** PCI interrupts are no longer routed 
automatically.  If this
Mar  2 23:36:56 kangur ** causes a device to stop working, it is probably 
because the
Mar  2 23:36:56 kangur ** driver failed to call pci_enable_device().  As a 
temporary
Mar  2 23:36:56 kangur ** workaround, the "pci=routeirq" argument restores 
the old
Mar  2 23:36:56 kangur ** behavior.  If this argument makes the device 
work again,
Mar  2 23:36:56 kangur ** please email the output of "lspci" to 
bjorn.helgaas@hp.com
Mar  2 23:36:56 kangur ** so I can fix the driver.
Mar  2 23:36:56 kangur pnp: the driver 'system' has been registered
Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:00' and 
the driver 'system'
Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:01' and 
the driver 'system'
Mar  2 23:36:56 kangur Total HugeTLB memory allocated, 0
Mar  2 23:36:56 kangur VFS: Disk quotas dquot_6.5.1
Mar  2 23:36:56 kangur Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Mar  2 23:36:56 kangur SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Mar  2 23:36:56 kangur SGI XFS Quota Management subsystem
Mar  2 23:36:56 kangur Initializing Cryptographic API
Mar  2 23:36:56 kangur inotify device minor=63
Mar  2 23:36:56 kangur ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 
0x64, irq 1
Mar  2 23:36:56 kangur ACPI: PS/2 Mouse Controller [PS2M] at irq 12
Mar  2 23:36:56 kangur serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  2 23:36:56 kangur serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  2 23:36:56 kangur io scheduler noop registered
Mar  2 23:36:56 kangur io scheduler anticipatory registered
Mar  2 23:36:56 kangur io scheduler deadline registered
Mar  2 23:36:56 kangur io scheduler cfq registered
Mar  2 23:36:56 kangur 8139too Fast Ethernet driver 0.9.27
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Mar  2 23:36:56 kangur PCI: setting IRQ 11 as level-triggered
Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar  2 23:36:56 kangur eth0: RealTek RTL8139 at 0xec00, 00:06:4f:00:73:8b, 
IRQ 11
Mar  2 23:36:56 kangur eth0:  Identified 8139 chip type 'RTL-8139C'
Mar  2 23:36:56 kangur Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Mar  2 23:36:56 kangur ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Mar  2 23:36:56 kangur VP_IDE: IDE controller at PCI slot 0000:00:07.1
Mar  2 23:36:56 kangur VP_IDE: chipset revision 6
Mar  2 23:36:56 kangur VP_IDE: not 100% native mode: will probe irqs later
Mar  2 23:36:56 kangur VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Mar  2 23:36:56 kangur ide0: BM-DMA at 0xc400-0xc407, BIOS settings: 
hda:pio, hdb:DMA
Mar  2 23:36:56 kangur ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: 
hdc:pio, hdd:DMA
Mar  2 23:36:56 kangur Probing IDE interface ide0...
Mar  2 23:36:56 kangur hdb: SAMSUNG SV3063H, ATA DISK drive
Mar  2 23:36:56 kangur ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  2 23:36:56 kangur Probing IDE interface ide1...
Mar  2 23:36:56 kangur hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
Mar  2 23:36:56 kangur ide1 at 0x170-0x177,0x376 on irq 15
Mar  2 23:36:56 kangur pnp: the driver 'ide' has been registered
Mar  2 23:36:56 kangur hdb: max request size: 128KiB
Mar  2 23:36:56 kangur hdb: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Mar  2 23:36:56 kangur hdb: cache flushes not supported
Mar  2 23:36:56 kangur hdb: hdb1 hdb2 hdb3 hdb4
Mar  2 23:36:56 kangur libata version 1.10 loaded.
Mar  2 23:36:56 kangur sata_sil version 0.8
Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar  2 23:36:56 kangur ata1: SATA max UDMA/100 cmd 0xD0802080 ctl 
0xD080208A bmdma 0xD0802000 irq 11
Mar  2 23:36:56 kangur ata2: SATA max UDMA/100 cmd 0xD08020C0 ctl 
0xD08020CA bmdma 0xD0802008 irq 11
Mar  2 23:36:56 kangur ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 
85:3469 86:3c41 87:4003 88:207f
Mar  2 23:36:56 kangur ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: 
lba48
Mar  2 23:36:56 kangur ata1: dev 0 configured for UDMA/100
Mar  2 23:36:56 kangur scsi0 : sata_sil
Mar  2 23:36:56 kangur ata2: no device found (phy stat 00000000)
Mar  2 23:36:56 kangur scsi1 : sata_sil
Mar  2 23:36:56 kangur Vendor: ATA       Model: WDC WD1600JD-00H  Rev: 
08.0
Mar  2 23:36:56 kangur Type:   Direct-Access                      ANSI 
SCSI revision: 05
Mar  2 23:36:56 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar  2 23:36:56 kangur SCSI device sda: drive cache: write back
Mar  2 23:36:56 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar  2 23:36:56 kangur SCSI device sda: drive cache: write back
Mar  2 23:36:56 kangur sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 
sda10 sda11 sda12 sda13 sda14 sda15 >
Mar  2 23:36:56 kangur Attached scsi disk sda at scsi0, channel 0, id 0, 
lun 0
Mar  2 23:36:56 kangur mice: PS/2 mouse device common for all mice
Mar  2 23:36:56 kangur input: AT Translated Set 2 keyboard on 
isa0060/serio0
Mar  2 23:36:56 kangur NET: Registered protocol family 2
Mar  2 23:36:56 kangur IP: routing cache hash table of 4096 buckets, 
32Kbytes
Mar  2 23:36:56 kangur TCP established hash table entries: 32768 (order: 
6, 262144 bytes)
Mar  2 23:36:56 kangur TCP bind hash table entries: 32768 (order: 5, 
131072 bytes)
Mar  2 23:36:56 kangur TCP: Hash tables configured (established 32768 bind 
32768)
Mar  2 23:36:56 kangur ip_conntrack version 2.1 (4095 buckets, 32760 max) 
- 216 bytes per conntrack
Mar  2 23:36:56 kangur ip_tables: (C) 2000-2002 Netfilter core team
Mar  2 23:36:56 kangur ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Mar  2 23:36:56 kangur arp_tables: (C) 2002 David S. Miller
Mar  2 23:36:56 kangur NET: Registered protocol family 17
Mar  2 23:36:56 kangur ACPI wakeup devices:
Mar  2 23:36:56 kangur SLPB PCI0 USB0 USB1
Mar  2 23:36:56 kangur ACPI: (supports S0 S1 S4 S5)
Mar  2 23:36:56 kangur kjournald starting.  Commit interval 5 seconds
Mar  2 23:36:56 kangur EXT3-fs: mounted filesystem with ordered data mode.
Mar  2 23:36:56 kangur VFS: Mounted root (ext3 filesystem) readonly.
Mar  2 23:36:56 kangur Freeing unused kernel memory: 156k freed
Mar  2 23:36:56 kangur NET: Registered protocol family 1
Mar  2 23:36:56 kangur EXT3 FS on hdb4, internal journal
Mar  2 23:36:56 kangur CSLIP: code copyright 1989 Regents of the 
University of California
Mar  2 23:36:56 kangur PPP generic driver version 2.4.2
Mar  2 23:36:56 kangur PPP Deflate Compression module registered
Mar  2 23:36:56 kangur NET: Registered protocol family 8
Mar  2 23:36:56 kangur NET: Registered protocol family 20
Mar  2 23:36:56 kangur input: PS/2 Generic Mouse on isa0060/serio1
Mar  2 23:36:56 kangur ACPI: Power Button (FF) [PWRF]
Mar  2 23:36:56 kangur ACPI: Sleep Button (CM) [SLPB]
Mar  2 23:36:56 kangur ACPI: Processor [CPU0] (supports 2 throttling 
states)
Mar  2 23:36:56 kangur input: PC Speaker
Mar  2 23:36:56 kangur Floppy drive(s): fd0 is 1.44M
Mar  2 23:36:56 kangur FDC 0 is a post-1991 82077
Mar  2 23:36:56 kangur loop: loaded (max 8 devices)
Mar  2 23:36:56 kangur Non-volatile memory driver v1.2
Mar  2 23:36:56 kangur BIOS EDD facility v0.16 2004-Jun-25, 2 devices 
found
Mar  2 23:36:56 kangur vesafb: NVidia Corporation, NV15 Reference Board, 
Chip Rev A0 (OEM: NVidia)
Mar  2 23:36:56 kangur vesafb: VBE version: 3.0
Mar  2 23:36:56 kangur vesafb: protected mode interface info at c000:0f03
Mar  2 23:36:56 kangur vesafb: pmi: set display start = b00c0f3c, set 
palette = b00c0fb2
Mar  2 23:36:56 kangur vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 
3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
Mar  2 23:36:56 kangur vesafb: hardware supports DCC2 transfers
Mar  2 23:36:56 kangur vesafb: monitor limits: vf = 85 Hz, hf = 64 kHz, 
clk = 108 MHz
Mar  2 23:36:56 kangur vesafb: scrolling: redraw
Mar  2 23:36:56 kangur vesafb: framebuffer at 0xe8000000, mapped to 
0xd0900000, using 6144k, total 65536k
Mar  2 23:36:56 kangur fb0: VESA VGA frame buffer device
Mar  2 23:36:56 kangur Console: switching to colour frame buffer device 
128x48
Mar  2 23:36:56 kangur device-mapper: 4.4.0-ioctl (2005-01-12) 
initialised: dm-devel@redhat.com
Mar  2 23:36:56 kangur NTFS driver 2.1.22 [Flags: R/O MODULE].
Mar  2 23:36:56 kangur NTFS volume version 3.1.
Mar  2 23:36:56 kangur NTFS volume version 3.1.
Mar  2 23:36:56 kangur usbcore: registered new driver usbfs
Mar  2 23:36:56 kangur usbcore: registered new driver hub
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Mar  2 23:36:56 kangur PCI: setting IRQ 10 as level-triggered
Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar  2 23:36:56 kangur parport_pc: VIA 686A/8231 detected
Mar  2 23:36:56 kangur parport_pc: probing current configuration
Mar  2 23:36:56 kangur parport_pc: Current parallel port base: 0x378
Mar  2 23:36:56 kangur parport_pc: Strange, can't probe VIA parallel port: 
io=0x378, irq=7, dma=-1
Mar  2 23:36:56 kangur pnp: the driver 'parport_pc' has been registered
Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:09' and 
the driver 'parport_pc'
Mar  2 23:36:56 kangur parport: PnPBIOS parport detected.
Mar  2 23:36:56 kangur parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
Mar  2 23:36:56 kangur USB Universal Host Controller Interface driver v2.2
Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 
(level, low) -> IRQ 10
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0xc800
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Mar  2 23:36:56 kangur hub 1-0:1.0: USB hub found
Mar  2 23:36:56 kangur hub 1-0:1.0: 2 ports detected
Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 
(level, low) -> IRQ 10
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0xcc00
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Mar  2 23:36:56 kangur hub 2-0:1.0: USB hub found
Mar  2 23:36:56 kangur hub 2-0:1.0: 2 ports detected
Mar  2 23:36:56 kangur usb 1-2: new full speed USB device using uhci_hcd 
and address 2
Mar  2 23:36:56 kangur Linux video capture interface: v1.00
Mar  2 23:36:56 kangur bttv: driver version 0.9.15 loaded
Mar  2 23:36:56 kangur bttv: using 32 buffers with 2080k (520 pages) each 
for capture
Mar  2 23:36:56 kangur bttv: Bt8xx card found (0).
Mar  2 23:36:56 kangur ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Mar  2 23:36:56 kangur PCI: setting IRQ 5 as level-triggered
Mar  2 23:36:56 kangur ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 
(level, low) -> IRQ 5
Mar  2 23:36:56 kangur bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, 
latency: 32, mmio: 0xf7000000
Mar  2 23:36:56 kangur bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
Mar  2 23:36:56 kangur bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
Mar  2 23:36:56 kangur bttv0: using tuner=25
Mar  2 23:36:56 kangur bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Mar  2 23:36:56 kangur bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Mar  2 23:36:56 kangur bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Mar  2 23:36:56 kangur tvaudio: TV audio decoder + audio/video mux driver
Mar  2 23:36:56 kangur tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Mar  2 23:36:56 kangur bttv0: i2c: checking for TDA9887 @ 0x86... not 
found
Mar  2 23:36:56 kangur tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Mar  2 23:36:56 kangur tuner 0-0061: type set to 25 (LG PAL_I+FM 
(TAPC-I001D))
Mar  2 23:36:56 kangur bttv0: registered device video0
Mar  2 23:36:56 kangur bttv0: registered device vbi0
Mar  2 23:36:56 kangur bttv0: registered device radio0
Mar  2 23:36:56 kangur bttv0: PLL: 28636363 => 35468950 .. ok
Mar  2 23:36:56 kangur bttv0: add subdevice "remote0"
Mar  2 23:36:56 kangur uhci_hcd 0000:00:07.2: Unlink after no-IRQ? 
Controller is probably using the wrong IRQ.
Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0in
Mar  2 23:36:56 kangur gameport: pci0000:00:0b.1 speed 1242 kHz
Mar  2 23:36:56 kangur Real Time Clock Driver v1.12
Mar  2 23:36:56 kangur Serial: 8250/16550 driver $Revision: 1.90 $ 8 
ports, IRQ sharing disabled
Mar  2 23:36:56 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar  2 23:36:56 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar  2 23:36:56 kangur pnp: the driver 'serial' has been registered
Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:07' and 
the driver 'serial'
Mar  2 23:36:56 kangur ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar  2 23:36:56 kangur pnp: match found with the PnP device '00:08' and 
the driver 'serial'
Mar  2 23:36:56 kangur ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
Mar  2 23:36:56 kangur eth0: link down
Mar  2 23:36:56 kangur eth0: link down
Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
Mar  2 23:36:56 kangur usb 1-2: device not accepting address 2, error -110
Mar  2 23:36:56 kangur usb 1-2: new full speed USB device using uhci_hcd 
and address 3
Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0in
Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
Mar  2 23:36:56 kangur usb 1-2: khubd timed out on ep0out
Mar  2 23:36:56 kangur usb 1-2: device not accepting address 3, error -110
Mar  2 23:36:56 kangur NET: Registered protocol family 10
Mar  2 23:36:56 kangur IPv6 over IPv4 tunneling driver


And for comparision whole log with acpi=off:


Mar  3 01:45:48 kangur Linux version 2.6.11-cko1 (root@kangur) (gcc 
version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 
Wed Mar 2 20:48:19 CET 2005
Mar  3 01:45:48 kangur BIOS-provided physical RAM map:
Mar  3 01:45:48 kangur BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Mar  3 01:45:48 kangur BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Mar  3 01:45:48 kangur BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Mar  3 01:45:48 kangur BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Mar  3 01:45:48 kangur BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Mar  3 01:45:48 kangur BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Mar  3 01:45:48 kangur BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Mar  3 01:45:48 kangur 511MB LOWMEM available.
Mar  3 01:45:48 kangur On node 0 totalpages: 131056
Mar  3 01:45:48 kangur DMA zone: 4096 pages, LIFO batch:1
Mar  3 01:45:48 kangur Normal zone: 126960 pages, LIFO batch:16
Mar  3 01:45:48 kangur HighMem zone: 0 pages, LIFO batch:1
Mar  3 01:45:48 kangur DMI 2.2 present.
Mar  3 01:45:48 kangur Allocating PCI resources starting at 20000000 (gap: 
20000000:dfff0000)
Mar  3 01:45:48 kangur Built 1 zonelists
Mar  3 01:45:48 kangur Kernel command line: ro root=/dev/hdb4 acpi=off
Mar  3 01:45:48 kangur Local APIC disabled by BIOS -- you can enable it 
with "lapic"
Mar  3 01:45:48 kangur mapped APIC to ffffd000 (01402000)
Mar  3 01:45:48 kangur Initializing CPU#0
Mar  3 01:45:48 kangur CPU 0 irqstacks, hard=b0476000 soft=b0475000
Mar  3 01:45:48 kangur PID hash table entries: 2048 (order: 11, 32768 
bytes)
Mar  3 01:45:48 kangur Detected 1203.036 MHz processor.
Mar  3 01:45:48 kangur Using tsc for high-res timesource
Mar  3 01:45:48 kangur Console: colour VGA+ 80x25
Mar  3 01:45:48 kangur Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Mar  3 01:45:48 kangur Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Mar  3 01:45:48 kangur Memory: 514944k/524224k available (2543k kernel 
code, 8728k reserved, 815k data, 156k init, 0k highmem)
Mar  3 01:45:48 kangur Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Mar  3 01:45:48 kangur Calibrating delay loop... 2359.29 BogoMIPS 
(lpj=1179648)
Mar  3 01:45:48 kangur Security Framework v1.0.0 initialized
Mar  3 01:45:48 kangur Capability LSM initialized
Mar  3 01:45:48 kangur Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Mar  3 01:45:48 kangur CPU: After generic identify, caps: 0383f9ff 
c1cbf9ff 00000000 00000000 00000000 00000000 00000000Mar  3 01:45:48 
kangur CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 
00000000 00000000 00000000 00000000
Mar  3 01:45:48 kangur CPU: CLK_CTL MSR was 60071263. Reprogramming to 
20071263
Mar  3 01:45:48 kangur CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Mar  3 01:45:48 kangur CPU: L2 Cache: 512K (64 bytes/line)
Mar  3 01:45:48 kangur CPU: After all inits, caps: 0383f9ff c1cbf9ff 
00000000 00000020 00000000 00000000 00000000
Mar  3 01:45:48 kangur Intel machine check architecture supported.
Mar  3 01:45:48 kangur Intel machine check reporting enabled on CPU#0.
Mar  3 01:45:48 kangur CPU: AMD Unknown CPU Type stepping 00
Mar  3 01:45:48 kangur Enabling fast FPU save and restore... done.
Mar  3 01:45:48 kangur Enabling unmasked SIMD FPU exception support... 
done.
Mar  3 01:45:48 kangur Checking 'hlt' instruction... OK.
Mar  3 01:45:48 kangur NET: Registered protocol family 16
Mar  3 01:45:48 kangur PCI: PCI BIOS revision 2.10 entry at 0xfb690, last 
bus=1
Mar  3 01:45:48 kangur PCI: Using configuration type 1
Mar  3 01:45:48 kangur mtrr: v2.0 (20020519)
Mar  3 01:45:48 kangur ACPI: Subsystem revision 20050211
Mar  3 01:45:48 kangur ACPI: Interpreter disabled.
Mar  3 01:45:48 kangur Linux Plug and Play Support v0.97 (c) Adam Belay
Mar  3 01:45:48 kangur pnp: PnP ACPI: disabled
Mar  3 01:45:48 kangur SCSI subsystem initialized
Mar  3 01:45:48 kangur PCI: Probing PCI hardware
Mar  3 01:45:48 kangur PCI: Probing PCI hardware (bus 00)
Mar  3 01:45:48 kangur PCI: Using IRQ router VIA [1106/0686] at 
0000:00:07.0
Mar  3 01:45:48 kangur pnp: the driver 'system' has been registered
Mar  3 01:45:48 kangur Total HugeTLB memory allocated, 0
Mar  3 01:45:48 kangur VFS: Disk quotas dquot_6.5.1
Mar  3 01:45:48 kangur Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Mar  3 01:45:48 kangur SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Mar  3 01:45:48 kangur SGI XFS Quota Management subsystem
Mar  3 01:45:48 kangur Initializing Cryptographic API
Mar  3 01:45:48 kangur inotify device minor=63
Mar  3 01:45:48 kangur i8042: ACPI detection disabled
Mar  3 01:45:48 kangur serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  3 01:45:48 kangur serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  3 01:45:48 kangur io scheduler noop registered
Mar  3 01:45:48 kangur io scheduler anticipatory registered
Mar  3 01:45:48 kangur io scheduler deadline registered
Mar  3 01:45:48 kangur io scheduler cfq registered
Mar  3 01:45:48 kangur 8139too Fast Ethernet driver 0.9.27
Mar  3 01:45:48 kangur PCI: Found IRQ 11 for device 0000:00:0f.0
Mar  3 01:45:48 kangur PCI: Sharing IRQ 11 with 0000:00:0d.0
Mar  3 01:45:48 kangur eth0: RealTek RTL8139 at 0xec00, 00:06:4f:00:73:8b, 
IRQ 11
Mar  3 01:45:48 kangur eth0:  Identified 8139 chip type 'RTL-8139C'
Mar  3 01:45:48 kangur Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Mar  3 01:45:48 kangur ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Mar  3 01:45:48 kangur VP_IDE: IDE controller at PCI slot 0000:00:07.1
Mar  3 01:45:48 kangur VP_IDE: chipset revision 6
Mar  3 01:45:48 kangur VP_IDE: not 100% native mode: will probe irqs later
Mar  3 01:45:48 kangur VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Mar  3 01:45:48 kangur ide0: BM-DMA at 0xc400-0xc407, BIOS settings: 
hda:pio, hdb:DMA
Mar  3 01:45:48 kangur ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: 
hdc:pio, hdd:DMA
Mar  3 01:45:48 kangur Probing IDE interface ide0...
Mar  3 01:45:48 kangur hdb: SAMSUNG SV3063H, ATA DISK drive
Mar  3 01:45:48 kangur ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  3 01:45:48 kangur Probing IDE interface ide1...
Mar  3 01:45:48 kangur hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
Mar  3 01:45:48 kangur ide1 at 0x170-0x177,0x376 on irq 15
Mar  3 01:45:48 kangur pnp: the driver 'ide' has been registered
Mar  3 01:45:48 kangur hdb: max request size: 128KiB
Mar  3 01:45:48 kangur hdb: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Mar  3 01:45:48 kangur hdb: cache flushes not supported
Mar  3 01:45:48 kangur hdb: hdb1 hdb2 hdb3 hdb4
Mar  3 01:45:48 kangur libata version 1.10 loaded.
Mar  3 01:45:48 kangur sata_sil version 0.8
Mar  3 01:45:48 kangur PCI: Found IRQ 11 for device 0000:00:0d.0
Mar  3 01:45:48 kangur PCI: Sharing IRQ 11 with 0000:00:0f.0
Mar  3 01:45:48 kangur ata1: SATA max UDMA/100 cmd 0xD084E080 ctl 
0xD084E08A bmdma 0xD084E000 irq 11
Mar  3 01:45:48 kangur ata2: SATA max UDMA/100 cmd 0xD084E0C0 ctl 
0xD084E0CA bmdma 0xD084E008 irq 11
Mar  3 01:45:48 kangur ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 
85:3469 86:3c41 87:4003 88:207f
Mar  3 01:45:48 kangur ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: 
lba48
Mar  3 01:45:48 kangur ata1: dev 0 configured for UDMA/100
Mar  3 01:45:48 kangur scsi0 : sata_sil
Mar  3 01:45:48 kangur ata2: no device found (phy stat 00000000)
Mar  3 01:45:48 kangur scsi1 : sata_sil
Mar  3 01:45:48 kangur Vendor: ATA       Model: WDC WD1600JD-00H  Rev: 
08.0
Mar  3 01:45:48 kangur Type:   Direct-Access                      ANSI 
SCSI revision: 05
Mar  3 01:45:48 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar  3 01:45:48 kangur SCSI device sda: drive cache: write back
Mar  3 01:45:48 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar  3 01:45:48 kangur SCSI device sda: drive cache: write back
Mar  3 01:45:48 kangur sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 
sda10 sda11 sda12 sda13 sda14 sda15 >
Mar  3 01:45:48 kangur Attached scsi disk sda at scsi0, channel 0, id 0, 
lun 0
Mar  3 01:45:48 kangur mice: PS/2 mouse device common for all mice
Mar  3 01:45:48 kangur input: AT Translated Set 2 keyboard on 
isa0060/serio0
Mar  3 01:45:48 kangur NET: Registered protocol family 2
Mar  3 01:45:48 kangur IP: routing cache hash table of 4096 buckets, 
32Kbytes
Mar  3 01:45:48 kangur TCP established hash table entries: 32768 (order: 
6, 262144 bytes)
Mar  3 01:45:48 kangur TCP bind hash table entries: 32768 (order: 5, 
131072 bytes)
Mar  3 01:45:48 kangur TCP: Hash tables configured (established 32768 bind 
32768)
Mar  3 01:45:48 kangur ip_conntrack version 2.1 (4095 buckets, 32760 max) 
- 216 bytes per conntrack
Mar  3 01:45:48 kangur ip_tables: (C) 2000-2002 Netfilter core team
Mar  3 01:45:48 kangur ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Mar  3 01:45:48 kangur arp_tables: (C) 2002 David S. Miller
Mar  3 01:45:48 kangur NET: Registered protocol family 17
Mar  3 01:45:48 kangur kjournald starting.  Commit interval 5 seconds
Mar  3 01:45:48 kangur EXT3-fs: mounted filesystem with ordered data mode.
Mar  3 01:45:48 kangur VFS: Mounted root (ext3 filesystem) readonly.
Mar  3 01:45:48 kangur Freeing unused kernel memory: 156k freed
Mar  3 01:45:48 kangur NET: Registered protocol family 1
Mar  3 01:45:48 kangur EXT3 FS on hdb4, internal journal
Mar  3 01:45:48 kangur input: PC Speaker
Mar  3 01:45:48 kangur loop: loaded (max 8 devices)
Mar  3 01:45:48 kangur Non-volatile memory driver v1.2
Mar  3 01:45:48 kangur BIOS EDD facility v0.16 2004-Jun-25, 2 devices 
found
Mar  3 01:45:48 kangur vesafb: NVidia Corporation, NV15 Reference Board, 
Chip Rev A0 (OEM: NVidia)
Mar  3 01:45:48 kangur vesafb: VBE version: 3.0
Mar  3 01:45:48 kangur vesafb: protected mode interface info at c000:0f03
Mar  3 01:45:48 kangur vesafb: pmi: set display start = b00c0f3c, set 
palette = b00c0fb2
Mar  3 01:45:48 kangur vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 
3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
Mar  3 01:45:48 kangur vesafb: hardware supports DCC2 transfers
Mar  3 01:45:48 kangur vesafb: monitor limits: vf = 85 Hz, hf = 64 kHz, 
clk = 108 MHz
Mar  3 01:45:48 kangur vesafb: scrolling: redraw
Mar  3 01:45:48 kangur vesafb: framebuffer at 0xe8000000, mapped to 
0xd0900000, using 6144k, total 65536k
Mar  3 01:45:48 kangur fb0: VESA VGA frame buffer device
Mar  3 01:45:48 kangur Console: switching to colour frame buffer device 
128x48
Mar  3 01:45:48 kangur device-mapper: 4.4.0-ioctl (2005-01-12) 
initialised: dm-devel@redhat.com
Mar  3 01:45:48 kangur NTFS driver 2.1.22 [Flags: R/O MODULE].
Mar  3 01:45:48 kangur NTFS volume version 3.1.
Mar  3 01:45:48 kangur NTFS volume version 3.1.
Mar  3 01:45:48 kangur usbcore: registered new driver usbfs
Mar  3 01:45:48 kangur usbcore: registered new driver hub
Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:0b.0
Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.2
Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.3
Mar  3 01:45:48 kangur parport_pc: VIA 686A/8231 detected
Mar  3 01:45:48 kangur parport_pc: probing current configuration
Mar  3 01:45:48 kangur parport_pc: Current parallel port base: 0x378
Mar  3 01:45:48 kangur parport_pc: Strange, can't probe VIA parallel port: 
io=0x378, irq=7, dma=-1
Mar  3 01:45:48 kangur pnp: the driver 'parport_pc' has been registered
Mar  3 01:45:48 kangur parport0: PC-style at 0x378 [PCSPP(,...)]
Mar  3 01:45:48 kangur USB Universal Host Controller Interface driver v2.2
Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.2
Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.3
Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: irq 9, io base 0xc800
Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Mar  3 01:45:48 kangur hub 1-0:1.0: USB hub found
Mar  3 01:45:48 kangur hub 1-0:1.0: 2 ports detected
Mar  3 01:45:48 kangur PCI: Found IRQ 9 for device 0000:00:07.3
Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:07.2
Mar  3 01:45:48 kangur PCI: Sharing IRQ 9 with 0000:00:0b.0
Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: irq 9, io base 0xcc00
Mar  3 01:45:48 kangur uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Mar  3 01:45:48 kangur hub 2-0:1.0: USB hub found
Mar  3 01:45:48 kangur hub 2-0:1.0: 2 ports detected
Mar  3 01:45:48 kangur usb 1-2: new full speed USB device using uhci_hcd 
and address 2
Mar  3 01:45:48 kangur NET: Registered protocol family 8
Mar  3 01:45:48 kangur NET: Registered protocol family 20
Mar  3 01:45:48 kangur Linux video capture interface: v1.00
Mar  3 01:45:48 kangur bttv: driver version 0.9.15 loaded
Mar  3 01:45:48 kangur bttv: using 32 buffers with 2080k (520 pages) each 
for capture
Mar  3 01:45:48 kangur bttv: Bt8xx card found (0).
Mar  3 01:45:48 kangur PCI: Found IRQ 5 for device 0000:00:09.0
Mar  3 01:45:48 kangur PCI: Sharing IRQ 5 with 0000:00:09.1
Mar  3 01:45:48 kangur bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, 
latency: 32, mmio: 0xf7000000
Mar  3 01:45:48 kangur bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
Mar  3 01:45:48 kangur bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
Mar  3 01:45:48 kangur bttv0: using tuner=25
Mar  3 01:45:48 kangur bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Mar  3 01:45:48 kangur bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Mar  3 01:45:48 kangur bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Mar  3 01:45:48 kangur tvaudio: TV audio decoder + audio/video mux driver
Mar  3 01:45:48 kangur tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Mar  3 01:45:48 kangur bttv0: i2c: checking for TDA9887 @ 0x86... not 
found
Mar  3 01:45:48 kangur tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Mar  3 01:45:48 kangur tuner 0-0061: type set to 25 (LG PAL_I+FM 
(TAPC-I001D))
Mar  3 01:45:48 kangur bttv0: registered device video0
Mar  3 01:45:48 kangur bttv0: registered device vbi0
Mar  3 01:45:48 kangur bttv0: registered device radio0
Mar  3 01:45:48 kangur bttv0: PLL: 28636363 => 35468950 .. ok
Mar  3 01:45:48 kangur bttv0: add subdevice "remote0"
Mar  3 01:45:48 kangur usb 1-2: modprobe timed out on ep0in
Mar  3 01:45:48 kangur usbcore: registered new driver speedtch
Mar  3 01:45:48 kangur usb 1-2: found stage 1 firmware speedtch-1.bin
Mar  3 01:45:48 kangur gameport: pci0000:00:0b.1 speed 1242 kHz
Mar  3 01:45:48 kangur nvidia: module license 'NVIDIA' taints kernel.
Mar  3 01:45:48 kangur PCI: Found IRQ 10 for device 0000:01:05.0
Mar  3 01:45:48 kangur NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module 
1.0-6629  Wed Nov  3 13:12:51 PST 2004
Mar  3 01:45:48 kangur usb 1-2: found stage 2 firmware speedtch-2.bin
Mar  3 01:45:50 kangur eth0: link down
Mar  3 01:45:50 kangur eth0: link down
Mar  3 01:45:50 kangur ADSL line is synchronising
Mar  3 01:45:50 kangur CSLIP: code copyright 1989 Regents of the 
University of California
Mar  3 01:45:50 kangur PPP generic driver version 2.4.2
Mar  3 01:45:51 kangur pppd[9623]: Plugin /usr/lib/pppd/2.4.3/pppoatm.so 
loaded.
Mar  3 01:45:51 kangur pppd[9623]: PPPoATM plugin_init
Mar  3 01:45:51 kangur pppd[9623]: PPPoATM setdevname_pppoatm - 
SUCCESS:0.35
Mar  3 01:45:51 kangur pppd[9624]: pppd 2.4.3 started by root, uid 0
Mar  3 01:45:51 kangur pppd[9624]: Using interface ppp0
Mar  3 01:45:51 kangur pppd[9624]: Connect: ppp0 <--> 0.35
Mar  3 01:45:52 kangur NET: Registered protocol family 10
Mar  3 01:45:52 kangur Disabled Privacy Extensions on device b03e6aa0(lo)
Mar  3 01:45:52 kangur IPv6 over IPv4 tunneling driver


And a log from 2.6.9:

Mar  1 23:51:22 kangur Linux version 2.6.9-cko2 (root@kangur) (gcc version 
3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #5 Thu Nov 
11 21:44:36 CET 2004
Mar  1 23:51:22 kangur BIOS-provided physical RAM map:
Mar  1 23:51:22 kangur BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Mar  1 23:51:22 kangur BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Mar  1 23:51:22 kangur BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Mar  1 23:51:22 kangur BIOS-e820: 0000000000100000 - 000000001fff0000 
(usable)
Mar  1 23:51:22 kangur BIOS-e820: 000000001fff0000 - 000000001fff3000 
(ACPI NVS)
Mar  1 23:51:22 kangur BIOS-e820: 000000001fff3000 - 0000000020000000 
(ACPI data)
Mar  1 23:51:22 kangur BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Mar  1 23:51:22 kangur 511MB LOWMEM available.
Mar  1 23:51:22 kangur On node 0 totalpages: 131056
Mar  1 23:51:22 kangur DMA zone: 4096 pages, LIFO batch:1
Mar  1 23:51:22 kangur Normal zone: 126960 pages, LIFO batch:16
Mar  1 23:51:22 kangur HighMem zone: 0 pages, LIFO batch:1
Mar  1 23:51:22 kangur DMI 2.2 present.
Mar  1 23:51:22 kangur ACPI: RSDP (v000 761686 
) @ 0x000f6a70
Mar  1 23:51:22 kangur ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3000
Mar  1 23:51:22 kangur ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x1fff3040
Mar  1 23:51:22 kangur ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 
0x0100000c) @ 0x00000000
Mar  1 23:51:22 kangur ACPI: PM-Timer IO Port: 0x4008
Mar  1 23:51:22 kangur Built 1 zonelists
Mar  1 23:51:22 kangur Kernel command line: ro root=/dev/hdb4
Mar  1 23:51:22 kangur No local APIC present or hardware disabled
Mar  1 23:51:22 kangur Initializing CPU#0
Mar  1 23:51:22 kangur PID hash table entries: 2048 (order: 11, 32768 
bytes)
Mar  1 23:51:22 kangur Detected 1203.074 MHz processor.
Mar  1 23:51:22 kangur Using pmtmr for high-res timesource
Mar  1 23:51:22 kangur Console: colour VGA+ 80x25
Mar  1 23:51:22 kangur Dentry cache hash table entries: 131072 (order: 7, 
524288 bytes)
Mar  1 23:51:22 kangur Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Mar  1 23:51:22 kangur Memory: 514704k/524224k available (2740k kernel 
code, 8984k reserved, 867k data, 152k init, 0k highmem)
Mar  1 23:51:22 kangur Checking if this processor honours the WP bit even 
in supervisor mode... Ok.
Mar  1 23:51:22 kangur Calibrating delay loop... 2375.68 BogoMIPS 
(lpj=1187840)
Mar  1 23:51:22 kangur Security Scaffold v1.0.0 initialized
Mar  1 23:51:22 kangur Capability LSM initialized
Mar  1 23:51:22 kangur Mount-cache hash table entries: 512 (order: 0, 4096 
bytes)
Mar  1 23:51:22 kangur CPU: After generic identify, caps: 0383f9ff 
c1cbf9ff 00000000 00000000
Mar  1 23:51:22 kangur CPU: After vendor identify, caps:  0383f9ff 
c1cbf9ff 00000000 00000000
Mar  1 23:51:22 kangur CPU: CLK_CTL MSR was 60071263. Reprogramming to 
20071263
Mar  1 23:51:22 kangur CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(64 bytes/line)
Mar  1 23:51:22 kangur CPU: L2 Cache: 512K (64 bytes/line)
Mar  1 23:51:22 kangur CPU: After all inits, caps:        0383f9ff 
c1cbf9ff 00000000 00000020
Mar  1 23:51:22 kangur Intel machine check architecture supported.
Mar  1 23:51:22 kangur Intel machine check reporting enabled on CPU#0.
Mar  1 23:51:22 kangur CPU: AMD Unknown CPU Type stepping 00
Mar  1 23:51:22 kangur Enabling fast FPU save and restore... done.
Mar  1 23:51:22 kangur Enabling unmasked SIMD FPU exception support... 
done.
Mar  1 23:51:22 kangur Checking 'hlt' instruction... OK.
Mar  1 23:51:22 kangur ACPI: IRQ11 SCI: Level Trigger.
Mar  1 23:51:22 kangur NET: Registered protocol family 16
Mar  1 23:51:22 kangur PCI: PCI BIOS revision 2.10 entry at 0xfb690, last 
bus=1
Mar  1 23:51:22 kangur PCI: Using configuration type 1
Mar  1 23:51:22 kangur mtrr: v2.0 (20020519)
Mar  1 23:51:22 kangur ACPI: Subsystem revision 20041015
Mar  1 23:51:22 kangur ACPI: Interpreter enabled
Mar  1 23:51:22 kangur ACPI: Using PIC for interrupt routing
Mar  1 23:51:22 kangur ACPI: PCI Root Bridge [PCI0] (00:00)
Mar  1 23:51:22 kangur PCI: Probing PCI hardware (bus 00)
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 
*10 11 12 14 15)
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 
10 *11 12 14 15)
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 
10 11 12 14 15)
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 
10 11 12 14 15) *9
Mar  1 23:51:22 kangur SCSI subsystem initialized
Mar  1 23:51:22 kangur PCI: Using ACPI for IRQ routing
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 
(level, low) -> IRQ 5
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:09.1[A] -> GSI 5 
(level, low) -> IRQ 5
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar  1 23:51:22 kangur ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur Total HugeTLB memory allocated, 0
Mar  1 23:51:22 kangur VFS: Disk quotas dquot_6.5.1
Mar  1 23:51:22 kangur Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
Mar  1 23:51:22 kangur SGI XFS with ACLs, security attributes, realtime, 
no debug enabled
Mar  1 23:51:22 kangur SGI XFS Quota Management subsystem
Mar  1 23:51:22 kangur Initializing Cryptographic API
Mar  1 23:51:22 kangur PCI: Via IRQ fixup for 0000:00:07.2, from 9 to 10
Mar  1 23:51:22 kangur PCI: Via IRQ fixup for 0000:00:07.3, from 9 to 10
Mar  1 23:51:22 kangur serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  1 23:51:22 kangur serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  1 23:51:22 kangur 8139too Fast Ethernet driver 0.9.27
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar  1 23:51:22 kangur eth0: RealTek RTL8139 at 0xec00, 00:06:4f:00:73:8b, 
IRQ 11
Mar  1 23:51:22 kangur eth0:  Identified 8139 chip type 'RTL-8139C'
Mar  1 23:51:22 kangur Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Mar  1 23:51:22 kangur ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
Mar  1 23:51:22 kangur VP_IDE: IDE controller at PCI slot 0000:00:07.1
Mar  1 23:51:22 kangur VP_IDE: chipset revision 6
Mar  1 23:51:22 kangur VP_IDE: not 100% native mode: will probe irqs later
Mar  1 23:51:22 kangur VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci0000:00:07.1
Mar  1 23:51:22 kangur ide0: BM-DMA at 0xc400-0xc407, BIOS settings: 
hda:pio, hdb:DMA
Mar  1 23:51:22 kangur ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: 
hdc:pio, hdd:DMA
Mar  1 23:51:22 kangur Probing IDE interface ide0...
Mar  1 23:51:22 kangur hdb: SAMSUNG SV3063H, ATA DISK drive
Mar  1 23:51:22 kangur Using cfq io scheduler
Mar  1 23:51:22 kangur ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  1 23:51:22 kangur Probing IDE interface ide1...
Mar  1 23:51:22 kangur hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM 
drive
Mar  1 23:51:22 kangur ide1 at 0x170-0x177,0x376 on irq 15
Mar  1 23:51:22 kangur hdb: max request size: 128KiB
Mar  1 23:51:22 kangur hdb: 59797584 sectors (30616 MB) w/426KiB Cache, 
CHS=59323/16/63, UDMA(100)
Mar  1 23:51:22 kangur hdb: cache flushes not supported
Mar  1 23:51:22 kangur hdb: hdb1 hdb2 hdb3 hdb4
Mar  1 23:51:22 kangur libata version 1.02 loaded.
Mar  1 23:51:22 kangur sata_sil version 0.54
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 
(level, low) -> IRQ 11
Mar  1 23:51:22 kangur ata1: SATA max UDMA/100 cmd 0xD0802080 ctl 
0xD080208A bmdma 0xD0802000 irq 11
Mar  1 23:51:22 kangur ata2: SATA max UDMA/100 cmd 0xD08020C0 ctl 
0xD08020CA bmdma 0xD0802008 irq 11
Mar  1 23:51:22 kangur ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 
85:3469 86:3c41 87:4003 88:207f
Mar  1 23:51:22 kangur ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: 
lba48
Mar  1 23:51:22 kangur ata1: dev 0 configured for UDMA/100
Mar  1 23:51:22 kangur scsi0 : sata_sil
Mar  1 23:51:22 kangur ata2: no device found (phy stat 00000000)
Mar  1 23:51:22 kangur scsi1 : sata_sil
Mar  1 23:51:22 kangur Vendor: ATA       Model: WDC WD1600JD-00H  Rev: 
08.0
Mar  1 23:51:22 kangur Type:   Direct-Access                      ANSI 
SCSI revision: 05
Mar  1 23:51:22 kangur SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Mar  1 23:51:22 kangur SCSI device sda: drive cache: write back
Mar  1 23:51:22 kangur sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 
sda10 sda11 sda12 sda13 sda14 sda15 >
Mar  1 23:51:22 kangur Attached scsi disk sda at scsi0, channel 0, id 0, 
lun 0
Mar  1 23:51:22 kangur mice: PS/2 mouse device common for all mice
Mar  1 23:51:22 kangur input: AT Translated Set 2 keyboard on 
isa0060/serio0
Mar  1 23:51:22 kangur NET: Registered protocol family 2
Mar  1 23:51:22 kangur IP: routing cache hash table of 4096 buckets, 
32Kbytes
Mar  1 23:51:22 kangur TCP: Hash tables configured (established 32768 bind 
65536)
Mar  1 23:51:22 kangur ip_conntrack version 2.1 (4095 buckets, 32760 max) 
- 300 bytes per conntrack
Mar  1 23:51:22 kangur ip_tables: (C) 2000-2002 Netfilter core team
Mar  1 23:51:22 kangur ipt_recent v0.3.1: Stephen Frost 
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Mar  1 23:51:22 kangur arp_tables: (C) 2002 David S. Miller
Mar  1 23:51:22 kangur NET: Registered protocol family 17
Mar  1 23:51:22 kangur ACPI: (supports S0 S1 S4 S5)
Mar  1 23:51:22 kangur ACPI wakeup devices:
Mar  1 23:51:22 kangur SLPB PCI0 USB0 USB1
Mar  1 23:51:22 kangur kjournald starting.  Commit interval 5 seconds
Mar  1 23:51:22 kangur EXT3-fs: mounted filesystem with ordered data mode.
Mar  1 23:51:22 kangur VFS: Mounted root (ext3 filesystem) readonly.
Mar  1 23:51:22 kangur Freeing unused kernel memory: 152k freed
Mar  1 23:51:22 kangur NET: Registered protocol family 1
Mar  1 23:51:22 kangur EXT3 FS on hdb4, internal journal
Mar  1 23:51:22 kangur CSLIP: code copyright 1989 Regents of the 
University of California
Mar  1 23:51:22 kangur PPP generic driver version 2.4.2
Mar  1 23:51:22 kangur PPP Deflate Compression module registered
Mar  1 23:51:22 kangur NET: Registered protocol family 8
Mar  1 23:51:22 kangur NET: Registered protocol family 20
Mar  1 23:51:22 kangur input: PS/2 Generic Mouse on isa0060/serio1
Mar  1 23:51:22 kangur ACPI: Power Button (FF) [PWRF]
Mar  1 23:51:22 kangur ACPI: Sleep Button (CM) [SLPB]
Mar  1 23:51:22 kangur ACPI: Processor [CPU0] (supports C1, 2 throttling 
states)
Mar  1 23:51:22 kangur input: PC Speaker
Mar  1 23:51:22 kangur inserting floppy driver for 2.6.9-cko2
Mar  1 23:51:22 kangur Floppy drive(s): fd0 is 1.44M
Mar  1 23:51:22 kangur FDC 0 is a post-1991 82077
Mar  1 23:51:22 kangur loop: loaded (max 8 devices)
Mar  1 23:51:22 kangur Non-volatile memory driver v1.2
Mar  1 23:51:22 kangur BIOS EDD facility v0.16 2004-Jun-25, 2 devices 
found
Mar  1 23:51:22 kangur vesafb: NVidia Corporation, NV15 Reference Board, 
Chip Rev A0 (OEM: NVidia)
Mar  1 23:51:22 kangur vesafb: VBE version: 3.0
Mar  1 23:51:22 kangur vesafb: protected mode interface info at c000:0f03
Mar  1 23:51:22 kangur vesafb: pmi: set display start = b00c0f3c, set 
palette = b00c0fb2
Mar  1 23:51:22 kangur vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 
3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
Mar  1 23:51:22 kangur vesafb: hardware supports DCC2 transfers
Mar  1 23:51:22 kangur vesafb: monitor limits: vf = 85 Hz, hf = 64 kHz, 
clk = 108 MHz
Mar  1 23:51:22 kangur vesafb: scrolling: redraw
Mar  1 23:51:22 kangur vesafb: framebuffer at 0xe8000000, mapped to 
0xd0900000, size 16384k
Mar  1 23:51:22 kangur fb0: VESA VGA frame buffer device
Mar  1 23:51:22 kangur Console: switching to colour frame buffer device 
128x48
Mar  1 23:51:22 kangur device-mapper: 4.3.0-ioctl (2004-09-30) 
initialised: dm-devel@redhat.com
Mar  1 23:51:22 kangur NTFS driver 2.1.20 [Flags: R/O MODULE].
Mar  1 23:51:22 kangur NTFS volume version 3.1.
Mar  1 23:51:22 kangur NTFS volume version 3.1.
Mar  1 23:51:22 kangur usbcore: registered new driver usbfs
Mar  1 23:51:22 kangur usbcore: registered new driver hub
Mar  1 23:51:22 kangur Real Time Clock Driver v1.12
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:09.1[A] -> GSI 5 
(level, low) -> IRQ 5
Mar  1 23:51:22 kangur parport_pc: Strange, can't probe Via 686A parallel 
port: io=0x378, irq=-1, dma=-1
Mar  1 23:51:22 kangur USB Universal Host Controller Interface driver v2.2
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur uhci_hcd 0000:00:07.2: UHCI Host Controller
Mar  1 23:51:22 kangur uhci_hcd 0000:00:07.2: irq 10, io base 0000c800
Mar  1 23:51:22 kangur uhci_hcd 0000:00:07.2: new USB bus registered, 
assigned bus number 1
Mar  1 23:51:22 kangur hub 1-0:1.0: USB hub found
Mar  1 23:51:22 kangur hub 1-0:1.0: 2 ports detected
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur uhci_hcd 0000:00:07.3: UHCI Host Controller
Mar  1 23:51:22 kangur uhci_hcd 0000:00:07.3: irq 10, io base 0000cc00
Mar  1 23:51:22 kangur uhci_hcd 0000:00:07.3: new USB bus registered, 
assigned bus number 2
Mar  1 23:51:22 kangur hub 2-0:1.0: USB hub found
Mar  1 23:51:22 kangur hub 2-0:1.0: 2 ports detected
Mar  1 23:51:22 kangur usb 1-2: new full speed USB device using address 2
Mar  1 23:51:22 kangur usbcore: registered new driver speedtch
Mar  1 23:51:22 kangur Linux video capture interface: v1.00
Mar  1 23:51:22 kangur bttv: driver version 0.9.15 loaded
Mar  1 23:51:22 kangur bttv: using 32 buffers with 2080k (520 pages) each 
for capture
Mar  1 23:51:22 kangur bttv: Bt8xx card found (0).
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 5 
(level, low) -> IRQ 5
Mar  1 23:51:22 kangur bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, 
latency: 32, mmio: 0xf7000000
Mar  1 23:51:22 kangur bttv0: using: Prolink Pixelview PV-BT878P+ 
(Rev.4C,8E) [card=70,insmod option]
Mar  1 23:51:22 kangur bttv0: gpio: en=00000000, out=00000000 in=00ffc0ff 
[init]
Mar  1 23:51:22 kangur ALSA sound/pci/bt87x.c:265: Aieee - PCI error! 
status 0x008008, PCI status 0x8290
Mar  1 23:51:22 kangur bttv0: using tuner=25
Mar  1 23:51:22 kangur bttv0: i2c: checking for MSP34xx @ 0x80... not 
found
Mar  1 23:51:22 kangur bttv0: i2c: checking for TDA9875 @ 0xb0... not 
found
Mar  1 23:51:22 kangur bttv0: i2c: checking for TDA7432 @ 0x8a... not 
found
Mar  1 23:51:22 kangur tvaudio: Ignoring new-style parameters in presence 
of obsolete ones
Mar  1 23:51:22 kangur tvaudio: TV audio decoder + audio/video mux driver
Mar  1 23:51:22 kangur tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
Mar  1 23:51:22 kangur bttv0: i2c: checking for TDA9887 @ 0x86... not 
found
Mar  1 23:51:22 kangur tuner: Ignoring new-style parameters in presence of 
obsolete ones
Mar  1 23:51:22 kangur tuner: chip found at addr 0xc2 i2c-bus bt878 #0 
[sw]
Mar  1 23:51:22 kangur tuner: type set to 25 (LG PAL_I+FM (TAPC-I001D)) by 
bt878 #0 [sw]
Mar  1 23:51:22 kangur bttv0: registered device video0
Mar  1 23:51:22 kangur bttv0: registered device vbi0
Mar  1 23:51:22 kangur bttv0: registered device radio0
Mar  1 23:51:22 kangur bttv0: PLL: 28636363 => 35468950 .. ok
Mar  1 23:51:22 kangur bttv0: add subdevice "remote0"
Mar  1 23:51:22 kangur gameport: pci0000:00:0b.1 speed 1242 kHz
Mar  1 23:51:22 kangur nvidia: module license 'NVIDIA' taints kernel.
Mar  1 23:51:22 kangur ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 
(level, low) -> IRQ 10
Mar  1 23:51:22 kangur NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module 
1.0-6629  Wed Nov  3 13:12:51 PST 2004
Mar  1 23:51:22 kangur eth0: link down
Mar  1 23:51:22 kangur NET: Registered protocol family 10
Mar  1 23:51:22 kangur Disabled Privacy Extensions on device b0417640(lo)
Mar  1 23:51:22 kangur IPv6 over IPv4 tunneling driver


Thanks,

Grzegorz Kulewski

