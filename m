Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJCUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTJCUH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 16:07:28 -0400
Received: from firewall.indigita.com ([65.211.227.66]:10998 "EHLO
	control2.indigita.com") by vger.kernel.org with ESMTP
	id S261152AbTJCUHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 16:07:19 -0400
Date: Fri, 3 Oct 2003 13:07:17 -0700
From: David Caldwell <david+kernel@porkrind.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] lost interrupt
Message-ID: <20031003200712.GA10268@indigita.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xpthen0xl.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Caldwell <david+kernel@porkrind.org> writes:
> 
> > I didn't have the forethought to save my dmesg output. This screwed up
> > my RAID pretty bad, so I'm a little reticent about making it happen
> > again...
> 
> In my case, no data is lost.  It just takes an awfully long time to
> write it.

I'm sorry, I just remembered a crutial point. The lost insterrupt
probably wasn't the thing that screwed up my raid. I had forgotten
when I wrote the first message, but I thought the lost interrupt
message might be because the disk itself was screwed up so I tried to
do an ATA reset with hdparm. That locked my system hard. Oops. Perhaps
if I had just been patient I would have been able to shutdown nicely...

After I locked,  I couldn't even boot 2.6.0 because I would get the lost
interrupt almost immediately after it started rebuilding my raid set.

> > I just wanted to let it known that it wasn't just happening to SiS IDE
> > controllers.
> 
> Could you post your dmesg output for that machine?  It might reveal
> something, even the error doesn't occur.

Sure. Here it is:
Linux version 2.6.0-test6 (david@death.porkrind.org) (gcc version 3.3.2 20030908 (Debian prerelease)) #3 SMP Sun Sep 28 04:15:14 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000001fff0000 (usable)
 user: 000000001fff0000 - 000000001fff8000 (ACPI data)
 user: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb0f0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fc0d0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0030
ACPI: MADT (v001 AMIINT          0x00000009 MSFT 0x00000097) @ 0x1fff00b0
ACPI: DSDT (v001    VIA   VIA_K7 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: KT266        APIC at: 0xFEE00000
I/O APIC #2 Version 2 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: root=/dev/hda2 ide0=dma ide1=dma ide2=dma ide3=dma acpi=1 apm=0 video=aty128fb:1024x768-32@75 noapic single mem=524224K
ide_setup: ide0=dma
ide_setup: ide1=dma
ide_setup: ide2=dma
ide_setup: ide3=dma
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1600.792 MHz processor.
Console: colour VGA+ 80x25
Memory: 514224k/524224k available (2312k kernel code, 9252k reserved, 912k data, 200k init, 0k highmem)
Calibrating delay loop... 3153.92 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(tm) XP 1900+ stepping 02
per-CPU timeslice cutoff: 731.66 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
Error: only one processor found.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1599.0810 MHz.
..... host bus clock speed is 266.0635 MHz.
Starting migration thread for cpu 0
CPUS done 8
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20030813
    ACPI-0269: *** Error: Looking up [\_S1_] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: , AE_ALREADY_EXISTS
    ACPI-0125: *** Error: acpi_load_tables: Could not load namespace: AE_ALREADY_EXISTS
    ACPI-0134: *** Error: acpi_load_tables: Could not load tables: AE_ALREADY_EXISTS
ACPI: Unable to load the System Description Tables
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3147] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:11.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
hgafb: HGA card not detected.
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
spurious 8259A interrupt: IRQ7.
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller at PCI slot 0000:00:09.0
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0xdffd0000
PDC20267: 100% native mode on irq 12
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:DMA, hdh:pio
hde: Maxtor 6Y120L0, ATA DISK drive
ide2 at 0xdc00-0xdc07,0xd802 on irq 12
hdg: Maxtor 6Y120L0, ATA DISK drive
ide3 at 0xd400-0xd407,0xd002 on irq 12
PDC20276: IDE controller at PCI slot 0000:00:0f.0
PDC20276: chipset revision 1
PDC20276: 100% native mode on irq 10
    ide4: BM-DMA at 0xb000-0xb007, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb008-0xb00f, BIOS settings: hdk:pio, hdl:pio
hdi: Maxtor 6Y120L0, ATA DISK drive
ide4 at 0xc000-0xc007,0xbc02 on irq 10
hdk: WDC WD1200JB-00DUA0, ATA DISK drive
ide5 at 0xb800-0xb807,0xb402 on irq 10
hda: QUANTUM FIREBALL EX6.4A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hde: max request size: 128KiB
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hde: hde1
hdg: max request size: 128KiB
hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hdg: hdg1
hdi: max request size: 128KiB
hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
 hdi: hdi1
hdk: max request size: 1024KiB
hdk: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 hdk: hdk1
hda: max request size: 128KiB
hda: 12594960 sectors (6448 MB) w/418KiB Cache, CHS=13328/15/63
 hda: hda1 hda2
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Console: switching to colour frame buffer device 80x30
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2136.000 MB/sec
   8regs_prefetch:  1904.000 MB/sec
   32regs    :  1640.000 MB/sec
   32regs_prefetch:  1628.000 MB/sec
   pIII_sse  :  4096.000 MB/sec
   pII_mmx   :  4248.000 MB/sec
   p5_mmx    :  5684.000 MB/sec
raid5: using function: pIII_sse (4096.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdk1 ...
md:  adding hdk1 ...
md:  adding hdi1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md1
md: bind<hde1>
md: bind<hdg1>
md: bind<hdi1>
md: bind<hdk1>
md: running: <hdk1><hdi1><hdg1><hde1>
raid5: device hdk1 operational as raid disk 2
raid5: device hdi1 operational as raid disk 3
raid5: device hdg1 operational as raid disk 1
raid5: device hde1 operational as raid disk 0
raid5: allocated 4185kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:hde1
 disk 1, o:1, dev:hdg1
 disk 2, o:1, dev:hdk1
 disk 3, o:1, dev:hdi1
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
version 0 swap is no longer supported. Use mkswap -v1 /dev/hda1
EXT3 FS on hda2, internal journal
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth0: ADMtek Comet rev 17 at 0xc400, 00:04:5A:50:1F:85, IRQ 10.
8139too Fast Ethernet driver 0.9.26
eth1: RealTek RTL8139 at 0xe084db00, 00:20:ed:31:8d:b4, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
version 0 swap is no longer supported. Use mkswap -v1 /dev/hda1
ehci_hcd 0000:00:14.2: EHCI Host Controller
ehci_hcd 0000:00:14.2: irq 10, pci mem e084fa00
ehci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:14.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:11.2: UHCI Host Controller
uhci-hcd 0000:00:11.2: irq 10, io base 0000a800
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci-hcd 0000:00:11.3: UHCI Host Controller
uhci-hcd 0000:00:11.3: irq 10, io base 0000ac00
uhci-hcd 0000:00:11.3: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci-hcd 0000:00:14.0: UHCI Host Controller
uhci-hcd 0000:00:14.0: irq 10, io base 00009c00
uhci-hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci-hcd 0000:00:14.1: UHCI Host Controller
uhci-hcd 0000:00:14.1: irq 12, io base 0000a000
uhci-hcd 0000:00:14.1: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 2-0:1.0: new USB device on port 1, assigned address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
hub 2-1:1.0: new USB device on port 3, assigned address 3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:11.2-1.3
hub 2-1:1.0: new USB device on port 4, assigned address 4
input: USB HID v1.00 Keyboard [Griffin Technology, Inc. iMate, USB To ADB Adaptor] on usb-0000:00:11.2-1.4
input: USB HID v1.00 Mouse [Griffin Technology, Inc. iMate, USB To ADB Adaptor] on usb-0000:00:11.2-1.4
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1

So at this point I did some dd's to my raid set as a test and
somewhere between 200-300 MB my screen when blank and my monitor lost
sync. This lasted for 5 seconds and then the picture came back. I
checked dmesg again and got:

Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.

So I kept doing dd's (3 at a time) and adding more and more modules in
but I could never get it to do the "lost interrupt" thing. Even after
booting all the way up into X and playing with myth tv which is what I
was doing when it happened the first time.

Here's my /proc/interrupts:
           CPU0       
  0:    4511238          XT-PIC  timer
  1:       9786          XT-PIC  i8042
  2:          0          XT-PIC  cascade
 10:     724396          XT-PIC  ide4, ide5, ehci_hcd, uhci-hcd, uhci-hcd, uhci-hcd, eth1, eth0, bttv0, btaudio
 12:     346598          XT-PIC  ide2, ide3, uhci-hcd, Ensoniq AudioPCI
 14:     964016          XT-PIC  ide0
NMI:          0 
LOC:    4489849 
ERR:     123957
MIS:          0

And just for completeness, my lsmod:
Module                  Size  Used by
sis                    52160  0 
appletalk              41680  18 
psnap                   4676  1 appletalk
llc                     8660  1 psnap
btaudio                17872  0 
tuner                  15820  0 
tvaudio                22732  0 
msp3400                24932  0 
bttv                  141924  0 
video_buf              22148  1 bttv
i2c_algo_bit           10632  1 bttv
btcx_risc               5256  1 bttv
v4l2_common             5056  1 bttv
videodev               10112  1 bttv
snd_pcm_oss            53604  0 
snd_mixer_oss          19648  1 snd_pcm_oss
snd_ens1371            26664  0 
snd_rawmidi            26080  1 snd_ens1371
snd_seq_device          8776  1 snd_rawmidi
snd_pcm               103840  2 snd_pcm_oss,snd_ens1371
snd_page_alloc         12420  1 snd_pcm
snd_timer              27396  1 snd_pcm
snd_ac97_codec         55044  1 snd_ens1371
snd                    54884  8 snd_pcm_oss,snd_mixer_oss,snd_ens1371,snd_rawmidi,snd_seq_device,snd_pcm,snd_timer,snd_ac97_codec
soundcore               9856  3 btaudio,bttv,snd
gameport                5504  1 snd_ens1371
uhci_hcd               34960  0 
ohci_hcd               19520  0 
ehci_hcd               25540  0 
8139too                24448  0 
tulip                  47456  0 
ns83820                20936  0 
hid                    33664  0 

-David
