Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272387AbTGaFIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272380AbTGaFIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:08:23 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:9178 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272387AbTGaFGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:06:14 -0400
Date: Wed, 30 Jul 2003 21:27:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: nelson.ferreira@ieee.org
Subject: [Bug 1016] New: Boot blocked on  2.6.0-test2
Message-ID: <35120000.1059625623@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1016

           Summary: Boot blocked on  2.6.0-test2
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: nelson.ferreira@ieee.org


Distribution: RedHat 6.1 heavilly updated
Hardware Environment: Dual PIII 450Mhz SMP 440BX motherboard
Software Environment: 
Problem Description:

I took 2.6.0-test2 for a spin (compiled even with 2.93.5) and could not
complete the boot because it seems that pppd-2.4.0 is having a bad interaction
with the kernel.

On the other hand, the matroxfb is not using the mode I specify on the boot args
(very minor :) ) and the aic78xx driver is not being able to configure the DV
and asks
me to file a bug report on that.

Following are the boot log and .config.

--- boot.log ---
Jul 28 01:07:37 tuxie syslogd 1.3-3: restart.
Jul 28 01:07:37 tuxie syslog: syslogd startup succeeded
Jul 28 01:07:37 tuxie kernel: klogd 1.3-3, log source = /proc/kmsg started.
Jul 28 01:07:37 tuxie kernel: Inspecting /boot/System.map-2.6.0-test2
Jul 28 01:07:37 tuxie syslog: klogd startup succeeded
Jul 28 01:07:37 tuxie identd: identd startup succeeded
Jul 28 01:07:38 tuxie atd: atd startup succeeded
Jul 28 01:07:38 tuxie kernel: Loaded 31613 symbols from
/boot/System.map-2.6.0-test2.
Jul 28 01:07:38 tuxie kernel: Symbols match kernel version 2.6.0.
Jul 28 01:07:38 tuxie kernel: No module symbols loaded - kernel modules not
enabled. 
Jul 28 01:07:38 tuxie kernel: Linux version 2.6.0-test2
(root@tuxie.homelinux.net) (gcc version 2.95.3 20010315 (release)) #6 SMP Sun
Jul 27 22:58:58 EDT 2003 
Jul 28 01:07:38 tuxie kernel: Video mode to be used for restore is f07 
Jul 28 01:07:38 tuxie kernel: BIOS-provided physical RAM map: 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00
(usable) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 0000000000100000 - 0000000000f00000
(usable) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 0000000000f00000 - 0000000001000000
(reserved) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 0000000001000000 - 0000000040000000
(usable) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved) 
Jul 28 01:07:38 tuxie kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000
(reserved) 
Jul 28 01:07:38 tuxie kernel: 128MB HIGHMEM available. 
Jul 28 01:07:38 tuxie kernel: 896MB LOWMEM available. 
Jul 28 01:07:38 tuxie kernel: found SMP MP-table at 000f5810 
Jul 28 01:07:38 tuxie kernel: hm, page 000f5000 reserved twice. 
Jul 28 01:07:38 tuxie kernel: hm, page 000f6000 reserved twice. 
Jul 28 01:07:38 tuxie kernel: hm, page 000f1000 reserved twice. 
Jul 28 01:07:38 tuxie kernel: hm, page 000f2000 reserved twice. 
Jul 28 01:07:38 tuxie kernel: On node 0 totalpages: 262144 
Jul 28 01:07:38 tuxie kernel:   DMA zone: 4096 pages, LIFO batch:1 
Jul 28 01:07:38 tuxie crond: crond startup succeeded
Jul 28 01:07:38 tuxie kernel:   Normal zone: 225280 pages, LIFO batch:16 
Jul 28 01:07:38 tuxie kernel:   HighMem zone: 32768 pages, LIFO batch:8 
Jul 28 01:07:38 tuxie kernel: Intel MultiProcessor Specification v1.1 
Jul 28 01:07:39 tuxie inet: inetd startup succeeded
Jul 28 01:07:39 tuxie inetd[492]: auth/tcp: bind: Address already in use
Jul 28 01:07:39 tuxie kernel:     Virtual Wire compatibility mode. 
Jul 28 01:07:39 tuxie keytable: Loading keymap: 
Jul 28 01:07:39 tuxie inetd[492]: pmap_set: 391002 1 6 32768: Address already in use
Jul 28 01:07:39 tuxie kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at:
0xFEE00000 
Jul 28 01:07:39 tuxie keytable: Loading system font: 
Jul 28 01:07:39 tuxie inetd[492]: pmap_set: 391002 2 6 32768: Address already in use
Jul 28 01:07:39 tuxie kernel: Processor #0 6:7 APIC version 17 
Jul 28 01:07:39 tuxie keytable: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us-acentos.map.gz
Jul 28 01:07:39 tuxie kernel: Processor #1 6:7 APIC version 17 
Jul 28 01:07:39 tuxie rc: Starting keytable succeeded
Jul 28 01:07:39 tuxie kernel: I/O APIC #2 Version 17 at 0xFEC00000. 
Jul 28 01:07:39 tuxie kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs 
Jul 28 01:07:39 tuxie kernel: Processors: 2 
Jul 28 01:07:39 tuxie adsl: Bringing up ADSL link
Jul 28 01:07:39 tuxie kernel: Building zonelist for node : 0 
Jul 28 01:07:40 tuxie kernel: Kernel command line: BOOT_IMAGE=LI ro root=81b
video=matrox:vesa:0x11E apm=off acpi=off ide2=ata66 hdc=cdrom 
Jul 28 01:07:40 tuxie adsl: .
Jul 28 01:07:40 tuxie kernel: ide_setup: ide2=ata66 
Jul 28 01:07:40 tuxie kernel: ide_setup: hdc=cdrom 
Jul 28 01:07:40 tuxie kernel: Initializing CPU#0 
Jul 28 01:07:40 tuxie kernel: PID hash table entries: 4096 (order 12: 32768 bytes) 
Jul 28 01:07:40 tuxie kernel: Detected 463.956 MHz processor. 
Jul 28 01:07:40 tuxie kernel: Console: colour VGA+ 80x60 
Jul 28 01:07:40 tuxie kernel: Calibrating delay loop... 915.45 BogoMIPS 
Jul 28 01:07:40 tuxie kernel: Memory: 1032032k/1048576k available (2368k kernel
code, 14560k reserved, 1228k data, 208k init, 131072k highmem) 
Jul 28 01:07:40 tuxie kernel: Security Scaffold v1.0.0 initialized 
Jul 28 01:07:40 tuxie kernel: Capability LSM initialized 
Jul 28 01:07:40 tuxie kernel: Dentry cache hash table entries: 131072 (order: 7,
524288 bytes) 
Jul 28 01:07:40 tuxie kernel: Inode-cache hash table entries: 65536 (order: 6,
262144 bytes) 
Jul 28 01:07:40 tuxie kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes) 
Jul 28 01:07:40 tuxie kernel: -> /dev 
Jul 28 01:07:40 tuxie kernel: -> /dev/console 
Jul 28 01:07:40 tuxie kernel: -> /root 
Jul 28 01:07:41 tuxie kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Jul 28 01:07:41 tuxie kernel: CPU: L2 cache: 512K 
Jul 28 01:07:41 tuxie pppd[643]: pppd 2.4.0 started by root, uid 0
Jul 28 01:07:41 tuxie kernel: Intel machine check architecture supported. 
Jul 28 01:07:41 tuxie pppd[643]: Using interface ppp0
Jul 28 01:07:41 tuxie pppoe[746]: ioctl(SIOCGIFHWADDR): No such device
Jul 28 01:07:41 tuxie kernel: Intel machine check reporting enabled on CPU#0. 
Jul 28 01:07:41 tuxie kernel: Enabling fast FPU save and restore... done. 
Jul 28 01:07:41 tuxie pppd[643]: Connect: ppp0 <--> /dev/pts/0
Jul 28 01:07:41 tuxie kernel: Enabling unmasked SIMD FPU exception support... done. 
Jul 28 01:07:41 tuxie pppd[643]: ioctl(PPPIOCSASYNCMAP): Inappropriate ioctl for
device(25)
Jul 28 01:07:41 tuxie kernel: Checking 'hlt' instruction... OK. 
Jul 28 01:07:41 tuxie pppd[643]: tcflush failed: Input/output error
Jul 28 01:07:41 tuxie kernel: POSIX conformance testing by UNIFIX 
Jul 28 01:07:41 tuxie pppd[643]: Exit.
Jul 28 01:07:41 tuxie kernel: CPU0: Intel Pentium III (Katmai) stepping 03 
Jul 28 01:07:41 tuxie kernel: per-CPU timeslice cutoff: 1465.61 usecs. 
Jul 28 01:07:41 tuxie kernel: task migration cache decay timeout: 2 msecs. 
Jul 28 01:07:41 tuxie kernel: enabled ExtINT on CPU#0 
Jul 28 01:07:41 tuxie kernel: ESR value before enabling vector: 00000000 
Jul 28 01:07:41 tuxie kernel: ESR value after enabling vector: 00000000 
Jul 28 01:07:41 tuxie kernel: Booting processor 1/1 eip 3000 
Jul 28 01:07:41 tuxie kernel: Initializing CPU#1 
Jul 28 01:07:42 tuxie kernel: masked ExtINT on CPU#1 
Jul 28 01:07:42 tuxie kernel: ESR value before enabling vector: 00000000 
Jul 28 01:07:42 tuxie kernel: ESR value after enabling vector: 00000000 
Jul 28 01:07:42 tuxie kernel: Calibrating delay loop... 925.69 BogoMIPS 
Jul 28 01:07:42 tuxie kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Jul 28 01:07:42 tuxie kernel: CPU: L2 cache: 512K 
Jul 28 01:07:42 tuxie kernel: Intel machine check architecture supported. 
Jul 28 01:07:42 tuxie adsl: .
Jul 28 01:07:42 tuxie kernel: Intel machine check reporting enabled on CPU#1. 
Jul 28 01:07:42 tuxie kernel: CPU1: Intel Pentium III (Katmai) stepping 03 
Jul 28 01:07:42 tuxie kernel: Total of 2 processors activated (1841.15 BogoMIPS). 
Jul 28 01:07:42 tuxie kernel: ENABLING IO-APIC IRQs 
Jul 28 01:07:42 tuxie kernel: Setting 2 in the phys_id_present_map 
Jul 28 01:07:42 tuxie kernel: ...changing IO-APIC physical APIC ID to 2 ... ok. 
Jul 28 01:07:42 tuxie kernel: ..TIMER: vector=0x31 pin1=2 pin2=0 
Jul 28 01:07:42 tuxie kernel: testing the IO APIC....................... 
Jul 28 01:07:43 tuxie kernel: .................................... done. 
Jul 28 01:07:43 tuxie kernel: Using local APIC timer interrupts. 
Jul 28 01:07:43 tuxie kernel: calibrating APIC timer ... 
Jul 28 01:07:43 tuxie kernel: ..... CPU clock speed is 463.0845 MHz. 
Jul 28 01:07:43 tuxie kernel: ..... host bus clock speed is 103.0076 MHz. 
Jul 28 01:07:43 tuxie kernel: checking TSC synchronization across 2 CPUs: passed. 
Jul 28 01:07:43 tuxie kernel: Starting migration thread for cpu 0 
Jul 28 01:07:43 tuxie kernel: Bringing up 1 
Jul 28 01:07:43 tuxie kernel: CPU 1 IS NOW UP! 
Jul 28 01:07:43 tuxie kernel: Starting migration thread for cpu 1 
Jul 28 01:07:43 tuxie kernel: CPUS done 2 
Jul 28 01:07:43 tuxie kernel: Initializing RT netlink socket 
Jul 28 01:07:43 tuxie kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last
bus=1 
Jul 28 01:07:43 tuxie kernel: PCI: Using configuration type 1 
Jul 28 01:07:43 tuxie kernel: mtrr: v2.0 (20020519) 
Jul 28 01:07:43 tuxie kernel: mtrr: your CPUs had inconsistent fixed MTRR settings 
Jul 28 01:07:43 tuxie kernel: mtrr: your CPUs had inconsistent variable MTRR
settings 
Jul 28 01:07:43 tuxie kernel: mtrr: probably your BIOS does not setup all CPUs. 
Jul 28 01:07:43 tuxie kernel: mtrr: corrected configuration. 
Jul 28 01:07:43 tuxie kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio) 
Jul 28 01:07:43 tuxie kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes) 
Jul 28 01:07:43 tuxie kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes) 
Jul 28 01:07:44 tuxie kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes) 
Jul 28 01:07:44 tuxie kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes) 
Jul 28 01:07:44 tuxie kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes) 
Jul 28 01:07:44 tuxie kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes) 
Jul 28 01:07:44 tuxie kernel: ACPI: Subsystem revision 20030714 
Jul 28 01:07:44 tuxie kernel: ACPI: Disabled via command line (acpi=off) 
Jul 28 01:07:44 tuxie kernel: Linux Plug and Play Support v0.96 (c) Adam Belay 
Jul 28 01:07:44 tuxie kernel: PnPBIOS: Scanning system for PnP BIOS support... 
Jul 28 01:07:44 tuxie kernel: PnPBIOS: Found PnP BIOS installation structure at
0xc00fbff0 
Jul 28 01:07:44 tuxie kernel: PnPBIOS: PnP BIOS version 1.0, entry
0xf0000:0xc018, dseg 0xf0000 
Jul 28 01:07:44 tuxie kernel: PnPBIOS: 15 nodes reported by PnP BIOS; 15
recorded by driver 
Jul 28 01:07:44 tuxie kernel: SCSI subsystem initialized 
Jul 28 01:07:44 tuxie adsl: .
Jul 28 01:07:44 tuxie kernel: drivers/usb/core/usb.c: registered new driver usbfs 
Jul 28 01:07:44 tuxie kernel: drivers/usb/core/usb.c: registered new driver hub 
Jul 28 01:07:44 tuxie kernel: ACPI: ACPI tables contain no PCI IRQ routing entries 
Jul 28 01:07:44 tuxie kernel: PCI: Invalid ACPI-PCI IRQ routing table 
Jul 28 01:07:44 tuxie kernel: PCI: Probing PCI hardware 
Jul 28 01:07:44 tuxie kernel: PCI: Probing PCI hardware (bus 00) 
Jul 28 01:07:44 tuxie kernel: PCI: Using IRQ router PIIX [8086/7110] at
0000:00:07.0 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I8,P0) -> 17 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I8,P0) -> 17 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 19 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I11,P0) -> 17 
Jul 28 01:07:44 tuxie kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 16 
Jul 28 01:07:44 tuxie kernel: PCI: No IRQ known for interrupt pin A of device
0000:01:00.0. Probably buggy MP table. 
Jul 28 01:07:44 tuxie kernel: matroxfb: Matrox Marvel G200 (AGP) detected 
Jul 28 01:07:44 tuxie kernel: matroxfb: MTRR's turned on 
Jul 28 01:07:44 tuxie kernel: matroxfb: 640x480x8bpp (virtual: 640x65536) 
Jul 28 01:07:44 tuxie kernel: matroxfb: framebuffer at 0xEC000000, mapped to
0xf8805000, size 8388608 
Jul 28 01:07:44 tuxie kernel: fb0: MATROX frame buffer device 
Jul 28 01:07:44 tuxie kernel: fb0: initializing hardware 
Jul 28 01:07:44 tuxie kernel: Console: switching to colour frame buffer device
80x30 
Jul 28 01:07:44 tuxie kernel: pty: 256 Unix98 ptys configured 
Jul 28 01:07:45 tuxie kernel: IA-32 Microcode Update Driver: v1.11
<tigran@veritas.com> 
Jul 28 01:07:45 tuxie kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version
1.16ac) 
Jul 28 01:07:45 tuxie kernel: apm: disabled on user request. 
Jul 28 01:07:45 tuxie kernel: Starting balanced_irq 
Jul 28 01:07:45 tuxie kernel: Enabling SEP on CPU 1 
Jul 28 01:07:45 tuxie kernel: Enabling SEP on CPU 0 
Jul 28 01:07:45 tuxie kernel: Total HugeTLB memory allocated, 0 
Jul 28 01:07:45 tuxie kernel: highmem bounce pool size: 64 pages 
Jul 28 01:07:45 tuxie kernel: VFS: Disk quotas dquot_6.5.1 
Jul 28 01:07:45 tuxie kernel: Journalled Block Device driver loaded 
Jul 28 01:07:45 tuxie kernel: devfs: v1.22 (20021013) Richard Gooch
(rgooch@atnf.csiro.au) 
Jul 28 01:07:45 tuxie kernel: devfs: boot_options: 0x0 
Jul 28 01:07:45 tuxie kernel: Initializing Cryptographic API 
Jul 28 01:07:45 tuxie kernel: Limiting direct PCI/PCI transfers. 
Jul 28 01:07:45 tuxie kernel: isapnp: Scanning for PnP cards... 
Jul 28 01:07:45 tuxie kernel: isapnp: No Plug & Play device found 
Jul 28 01:07:45 tuxie kernel: Real Time Clock Driver v1.11 
Jul 28 01:07:45 tuxie kernel: Non-volatile memory driver v1.2 
Jul 28 01:07:45 tuxie kernel: Linux agpgart interface v0.100 (c) Dave Jones 
Jul 28 01:07:45 tuxie kernel: agpgart: Detected an Intel 440BX Chipset. 
Jul 28 01:07:45 tuxie kernel: agpgart: Maximum main memory to use for agp
memory: 942M 
Jul 28 01:07:45 tuxie kernel: agpgart: AGP aperture is 128M @ 0xe0000000 
Jul 28 01:07:45 tuxie kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0 
Jul 28 01:07:45 tuxie kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE,EPP] 
Jul 28 01:07:45 tuxie kernel: parport0: irq 7 detected 
Jul 28 01:07:45 tuxie kernel: parport0: Printer, Lexmark Lexmark Z53 
Jul 28 01:07:45 tuxie kernel: Using anticipatory scheduling elevator 
Jul 28 01:07:45 tuxie kernel: Floppy drive(s): fd0 is 1.44M 
Jul 28 01:07:45 tuxie kernel: FDC 0 is a post-1991 82077 
Jul 28 01:07:45 tuxie kernel: PPP generic driver version 2.4.2 
Jul 28 01:07:45 tuxie kernel: PPP Deflate Compression module registered 
Jul 28 01:07:45 tuxie kernel: PPP BSD Compression module registered 
Jul 28 01:07:45 tuxie kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2 
Jul 28 01:07:45 tuxie kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx 
Jul 28 01:07:45 tuxie kernel: PIIX4: IDE controller at PCI slot 0000:00:07.1 
Jul 28 01:07:46 tuxie kernel: PIIX4: chipset revision 1 
Jul 28 01:07:46 tuxie kernel: PIIX4: not 100%% native mode: will probe irqs later 
Jul 28 01:07:46 tuxie kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings:
hda:DMA, hdb:pio 
Jul 28 01:07:46 tuxie kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:
hdc:DMA, hdd:pio 
Jul 28 01:07:46 tuxie kernel: hda: Maxtor 90845D4, ATA DISK drive 
Jul 28 01:07:46 tuxie kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
Jul 28 01:07:46 tuxie kernel: hdc: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive 
Jul 28 01:07:46 tuxie kernel: ide1 at 0x170-0x177,0x376 on irq 15 
Jul 28 01:07:46 tuxie kernel: PDC20269: IDE controller at PCI slot 0000:00:0b.0 
Jul 28 01:07:46 tuxie kernel: PDC20269: chipset revision 2 
Jul 28 01:07:46 tuxie adsl: .
Jul 28 01:07:46 tuxie kernel: PDC20269: ROM enabled at 0xee000000 
Jul 28 01:07:46 tuxie kernel: PDC20269: 100%% native mode on irq 17 
Jul 28 01:07:46 tuxie kernel:     ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings:
hde:pio, hdf:pio 
Jul 28 01:07:46 tuxie kernel:     ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings:
hdg:pio, hdh:pio 
Jul 28 01:07:46 tuxie kernel: hde: Maxtor 4G160J8, ATA DISK drive 
Jul 28 01:07:46 tuxie kernel: ide2 at 0xac00-0xac07,0xb002 on irq 17 
Jul 28 01:07:46 tuxie kernel: hda: max request size: 128KiB 
Jul 28 01:07:46 tuxie kernel: hda: host protected area => 1 
Jul 28 01:07:46 tuxie kernel: hda: 16514064 sectors (8455 MB) w/512KiB Cache,
CHS=16383/16/63, UDMA(33) 
Jul 28 01:07:46 tuxie kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > 
Jul 28 01:07:46 tuxie kernel: hde: max request size: 1024KiB 
Jul 28 01:07:46 tuxie kernel: hde: host protected area => 1 
Jul 28 01:07:46 tuxie kernel: hde: 320173056 sectors (163929 MB) w/2048KiB
Cache, CHS=19929/255/63, UDMA(133) 
Jul 28 01:07:46 tuxie kernel:  /dev/ide/host2/bus0/target0/lun0: p1 < p5 p6 p7 p8 > 
Jul 28 01:07:46 tuxie kernel: end_request: I/O error, dev hdc, sector 0 
Jul 28 01:07:46 tuxie kernel: hdc: ATAPI 40X CD-ROM drive, 128kB Cache, DMA 
Jul 28 01:07:46 tuxie kernel: Uniform CD-ROM driver Revision: 3.12 
Jul 28 01:07:47 tuxie kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.35 
Jul 28 01:07:47 tuxie kernel:         <Adaptec 2940 Ultra2 SCSI adapter> 
Jul 28 01:07:47 tuxie kernel:         aic7890/91: Ultra2 Wide Channel A, SCSI
Id=7, 32/253 SCBs 
Jul 28 01:07:47 tuxie kernel:  
Jul 28 01:07:47 tuxie kernel: (scsi0:A:2): 10.000MB/s transfers (10.000MHz,
offset 8) 
Jul 28 01:07:47 tuxie kernel: scsi0:A:4:0: DV failed to configure device. 
Please file a bug report against this driver. 
Jul 28 01:07:47 tuxie kernel: (scsi0:A:12): 80.000MB/s transfers (40.000MHz,
offset 31, 16bit) 
Jul 28 01:07:47 tuxie kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W4220T  Rev:
1.04 
Jul 28 01:07:47 tuxie kernel:   Type:   CD-ROM                             ANSI
SCSI revision: 02 
Jul 28 01:07:47 tuxie kernel: (scsi0:A:4): 20.000MB/s transfers (20.000MHz,
offset 15) 
Jul 28 01:07:47 tuxie kernel:   Vendor: QUANTUM   Model: FIREBALL ST4.3S   Rev:
0F0C 
Jul 28 01:07:47 tuxie kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 02 
Jul 28 01:07:47 tuxie kernel: scsi0:A:4:0: Tagged Queuing enabled.  Depth 32 
Jul 28 01:07:47 tuxie kernel:   Vendor: IBM       Model: DNES-309170W      Rev:
SA30 
Jul 28 01:07:47 tuxie kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 03 
Jul 28 01:07:47 tuxie kernel: scsi0:A:12:0: Tagged Queuing enabled.  Depth 32 
Jul 28 01:07:47 tuxie kernel: SCSI device sda: 8519216 512-byte hdwr sectors
(4362 MB) 
Jul 28 01:07:47 tuxie kernel: SCSI device sda: drive cache: write back 
Jul 28 01:07:47 tuxie kernel:  /dev/scsi/host0/bus0/target4/lun0: p1 < p5 > 
Jul 28 01:07:47 tuxie kernel: Attached scsi disk sda at scsi0, channel 0, id 4,
lun 0 
Jul 28 01:07:47 tuxie kernel: SCSI device sdb: 17916240 512-byte hdwr sectors
(9173 MB) 
Jul 28 01:07:47 tuxie kernel: SCSI device sdb: drive cache: write back 
Jul 28 01:07:47 tuxie kernel:  /dev/scsi/host0/bus0/target12/lun0: p1 p2 p3 < p5
p6 p7 p8 p9 p10 p11 p12 p13 p14 > 
Jul 28 01:07:47 tuxie kernel: Attached scsi disk sdb at scsi0, channel 0, id 12,
lun 0 
Jul 28 01:07:47 tuxie kernel: sr0: scsi3-mmc drive: 20x/20x writer cd/rw
xa/form2 cdda tray 
Jul 28 01:07:47 tuxie kernel: Attached scsi generic sg0 at scsi0, channel 0, id
2, lun 0,  type 5 
Jul 28 01:07:47 tuxie kernel: Attached scsi generic sg1 at scsi0, channel 0, id
4, lun 0,  type 0 
Jul 28 01:07:47 tuxie kernel: Attached scsi generic sg2 at scsi0, channel 0, id
12, lun 0,  type 0 
Jul 28 01:07:47 tuxie kernel: Console: switching to colour frame buffer device
80x30 
Jul 28 01:07:47 tuxie kernel: mice: PS/2 mouse device common for all mice 
Jul 28 01:07:47 tuxie kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1 
Jul 28 01:07:47 tuxie kernel: serio: i8042 AUX port at 0x60,0x64 irq 12 
Jul 28 01:07:47 tuxie kernel: input: AT Set 2 keyboard on isa0060/serio0 
Jul 28 01:07:47 tuxie kernel: serio: i8042 KBD port at 0x60,0x64 irq 1 
Jul 28 01:07:47 tuxie kernel: i2c /dev entries driver module version 2.7.0
(20021208) 
Jul 28 01:07:48 tuxie kernel: i2c-elv.o: i2c ELV parallel port adapter module
version 2.7.0 (20021208) 
Jul 28 01:07:48 tuxie kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Jul 28 01:07:48 tuxie kernel: IP: routing cache hash table of 8192 buckets,
64Kbytes 
Jul 28 01:07:48 tuxie kernel: TCP: Hash tables configured (established 262144
bind 65536) 
Jul 28 01:07:48 tuxie kernel: Linux IP multicast router 0.06 plus PIM-SM 
Jul 28 01:07:48 tuxie kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
Jul 28 01:07:48 tuxie kernel: BIOS EDD facility v0.09 2003-Jan-22, 4 devices found 
Jul 28 01:07:48 tuxie kernel: Software Suspend has malfunctioning SMP support.
Disabled :( 
Jul 28 01:07:48 tuxie kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Jul 28 01:07:48 tuxie kernel: Freeing unused kernel memory: 208k freed 
Jul 28 01:07:48 tuxie kernel: Adding 1049576k swap on /dev/sdb6.  Priority:-1
extents:1 
Jul 28 01:07:48 tuxie kernel: es1371: version v0.32 time 22:34:54 Jul 27 2003 
Jul 28 01:07:48 tuxie kernel: es1371: found chip, vendor id 0x1274 device id
0x1371 revision 0x06 
Jul 28 01:07:48 tuxie kernel: es1371: found es1371 rev 6 at io 0xa400 irq 19
joystick 0x0 
Jul 28 01:07:48 tuxie kernel: ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5) 
Jul 28 01:07:48 tuxie kernel: MIDI Loopback device driver 
Jul 28 01:07:48 tuxie kernel: lp0: using parport0 (polling). 
Jul 28 01:07:48 tuxie adsl: .
Jul 28 01:07:48 tuxie kernel: lp0: console ready 
Jul 28 01:07:48 tuxie kernel: drivers/usb/core/usb.c: registered new driver
usbscanner 
Jul 28 01:07:48 tuxie kernel: drivers/usb/image/scanner.c: 0.4.14:USB Scanner
Driver 
Jul 28 01:07:48 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:48 tuxie kernel: EXT3 FS on sdb9, internal journal 
Jul 28 01:07:48 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:48 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:48 tuxie kernel: EXT3 FS on sdb14, internal journal 
Jul 28 01:07:48 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:48 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:48 tuxie kernel: EXT3 FS on hde6, internal journal 
Jul 28 01:07:48 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:48 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:48 tuxie kernel: EXT3 FS on hde8, internal journal 
Jul 28 01:07:48 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:48 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:48 tuxie kernel: EXT3 FS on sda5, internal journal 
Jul 28 01:07:48 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:49 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:49 tuxie kernel: EXT3 FS on sdb5, internal journal 
Jul 28 01:07:49 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:49 tuxie kernel: kjournald starting.  Commit interval 5 seconds 
Jul 28 01:07:49 tuxie kernel: EXT3 FS on sdb13, internal journal 
Jul 28 01:07:49 tuxie kernel: EXT3-fs: mounted filesystem with ordered data mode. 
Jul 28 01:07:49 tuxie kernel: ip_tables: (C) 2000-2002 Netfilter core team 
Jul 28 01:07:49 tuxie kernel: ip_conntrack version 2.1 (8192 buckets, 65536 max)
- 304 bytes per conntrack 
Jul 28 01:07:49 tuxie kernel: Badness in local_bh_enable at kernel/softirq.c:113 
Jul 28 01:07:49 tuxie kernel: Call Trace: 
Jul 28 01:07:49 tuxie kernel:  [local_bh_enable+53/108] local_bh_enable+0x35/0x6c 
Jul 28 01:07:49 tuxie kernel:  [ppp_async_push+400/412] ppp_async_push+0x190/0x19c 
Jul 28 01:07:49 tuxie kernel:  [ppp_asynctty_wakeup+40/76]
ppp_asynctty_wakeup+0x28/0x4c 
Jul 28 01:07:49 tuxie kernel:  [pty_unthrottle+35/72] pty_unthrottle+0x23/0x48 
Jul 28 01:07:49 tuxie kernel:  [check_unthrottle+50/56] check_unthrottle+0x32/0x38 
Jul 28 01:07:49 tuxie kernel:  [reset_buffer_flags+136/144]
reset_buffer_flags+0x88/0x90 
Jul 28 01:07:49 tuxie kernel:  [n_tty_flush_buffer+11/64]
n_tty_flush_buffer+0xb/0x40 
Jul 28 01:07:50 tuxie kernel:  [pty_flush_buffer+26/72] pty_flush_buffer+0x1a/0x48 
Jul 28 01:07:50 tuxie kernel:  [do_tty_hangup+425/1040] do_tty_hangup+0x1a9/0x410 
Jul 28 01:07:50 tuxie kernel:  [tty_vhangup+10/16] tty_vhangup+0xa/0x10 
Jul 28 01:07:50 tuxie kernel:  [pty_close+255/260] pty_close+0xff/0x104 
Jul 28 01:07:50 tuxie kernel:  [release_dev+506/1496] release_dev+0x1fa/0x5d8 
Jul 28 01:07:50 tuxie kernel:  [schedule+1030/1264] schedule+0x406/0x4f0 
Jul 28 01:07:50 tuxie kernel:  [tty_release+70/136] tty_release+0x46/0x88 
Jul 28 01:07:50 tuxie kernel:  [__fput+66/268] __fput+0x42/0x10c 
Jul 28 01:07:50 tuxie kernel:  [fput+20/24] fput+0x14/0x18 
Jul 28 01:07:50 tuxie kernel:  [filp_close+80/92] filp_close+0x50/0x5c 
Jul 28 01:07:50 tuxie kernel:  [put_files_struct+84/188] put_files_struct+0x54/0xbc 
Jul 28 01:07:50 tuxie adsl: .
Jul 28 01:07:50 tuxie kernel:  [do_exit+523/1084] do_exit+0x20b/0x43c 
Jul 28 01:07:50 tuxie kernel:  [sys_exit_group+0/20] sys_exit_group+0x0/0x14 
Jul 28 01:07:50 tuxie kernel:  [sys_exit_group+14/20] sys_exit_group+0xe/0x14 
Jul 28 01:07:50 tuxie kernel:  [syscall_call+7/11] syscall_call+0x7/0xb 
Jul 28 01:07:50 tuxie kernel:  
Jul 28 01:07:52 tuxie adsl: .
Jul 28 01:08:08 tuxie last message repeated 8 times
Jul 28 01:08:10 tuxie init: Switching to runlevel: 6
Jul 28 01:08:11 tuxie rc: Stopping keytable succeeded
Jul 28 01:08:12 tuxie gpm: gpm shutdown succeeded
Jul 28 01:08:12 tuxie inet: inetd shutdown succeeded
Jul 28 01:08:12 tuxie atd: atd shutdown succeeded
Jul 28 01:08:12 tuxie crond: crond shutdown succeeded
Jul 28 01:08:13 tuxie identd: identd shutdown succeeded
Jul 28 01:08:13 tuxie dd: 1+0 records in
Jul 28 01:08:13 tuxie dd: 1+0 records out
Jul 28 01:08:13 tuxie random: Saving random seed succeeded
Jul 28 01:08:13 tuxie network: Shutting down interface eth0 succeeded
Jul 28 01:08:13 tuxie sysctl: net.ipv4.ip_forward = 0
Jul 28 01:08:13 tuxie network: Disabling IPv4 packet forwarding succeeded
Jul 28 01:08:13 tuxie kernel: Kernel logging (proc) stopped.
Jul 28 01:08:13 tuxie kernel: Kernel log daemon terminating.
Jul 28 01:08:14 tuxie syslog: klogd shutdown succeeded
Jul 28 01:08:14 tuxie exiting on signal 15
----- end of boot.log---

--- .config ---
# 
# Automatically generated make config: don't edit
# 
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

# 
# Code maturity level options
# 
CONFIG_EXPERIMENTAL=y

# 
# General setup
# 
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

# 
# Loadable module support
# 
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

# 
# Processor type and features
# 
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HUGETLB_PAGE=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

# 
# Power management options (ACPI, APM)
# 
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

# 
# ACPI Support
# 
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

# 
# CPU Frequency scaling
# 
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_24_API is not set
CONFIG_CPU_FREQ_TABLE=y

# 
# CPUFreq processor drivers
# 
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

# 
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
# 
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

# 
# PCMCIA/CardBus support
# 
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

# 
# PCI Hotplug Support
# 
# CONFIG_HOTPLUG_PCI is not set

# 
# Executable file formats
# 
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

# 
# Generic Driver Options
# 
CONFIG_FW_LOADER=m

# 
# Memory Technology Devices (MTD)
# 
# CONFIG_MTD is not set

# 
# Parallel port support
# 
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

# 
# Plug and Play support
# 
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

# 
# Protocols
# 
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

# 
# Block devices
# 
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

# 
# ATA/ATAPI/MFM/RLL support
# 
CONFIG_IDE=y

# 
# IDE, ATA and ATAPI Block devices
# 
CONFIG_BLK_DEV_IDE=y

# 
# Please see Documentation/ide.txt for help/info on IDE drives
# 
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

# 
# IDE chipset support/bugfixes
# 
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y

# 
# SCSI device support
# 
CONFIG_SCSI=y

# 
# SCSI support type (disk, tape, CD-ROM)
# 
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

# 
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
# 
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

# 
# SCSI low-level drivers
# 
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_ENABLE_RD_STRM=y
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_DEBUG=m

# 
# Old CD-ROM drivers (not SCSI, not IDE)
# 
# CONFIG_CD_NO_IDESCSI is not set

# 
# Multi-device support (RAID and LVM)
# 
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_IOCTL_V4=y

# 
# Fusion MPT device support
# 
# CONFIG_FUSION is not set

# 
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
# 
# CONFIG_IEEE1394 is not set

# 
# I2O device support
# 
# CONFIG_I2O is not set

# 
# Networking support
# 
CONFIG_NET=y

# 
# Networking options
# 
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y

# 
# IP: Netfilter Configuration
# 
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
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
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m

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
CONFIG_IPV6_TUNNEL=m

# 
# IPv6: Netfilter Configuration
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
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=m

# 
# SCTP Configuration (EXPERIMENTAL)
# 
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_MARK_T=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

# 
# QoS and/or fair queueing
# 
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

# 
# Network testing
# 
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

# 
# ARCnet devices
# 
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
# CONFIG_NET_SB1000 is not set

# 
# Ethernet (10 or 100Mbit)
# 
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

# 
# Tulip family network device support
# 
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

# 
# Ethernet (1000 Mbit)
# 
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

# 
# Ethernet (10000 Mbit)
# 
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

# 
# Wireless LAN (non-hamradio)
# 
# CONFIG_NET_RADIO is not set

# 
# Token Ring devices (depends on LLC=y)
# 
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

# 
# Wan interfaces
# 
# CONFIG_WAN is not set

# 
# Amateur Radio support
# 
# CONFIG_HAMRADIO is not set

# 
# IrDA (infrared) support
# 
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
CONFIG_IRDA_DEBUG=y

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

# 
# Old SIR device drivers
# 
# CONFIG_IRTTY_OLD is not set
CONFIG_IRPORT_SIR=m

# 
# Old Serial dongle support
# 
# CONFIG_DONGLE_OLD is not set

# 
# FIR device drivers
# 
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_OLD=m
CONFIG_TOSHIBA_FIR=m
# CONFIG_SMC_IRCC_OLD is not set
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m

# 
# ISDN subsystem
# 
# CONFIG_ISDN_BOOL is not set

# 
# Telephony Support
# 
# CONFIG_PHONE is not set

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
CONFIG_INPUT_EVBUG=m

# 
# Input I/O drivers
# 
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

# 
# Input Device Drivers
# 
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

# 
# Character devices
# 
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

# 
# Serial drivers
# 
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
CONFIG_SERIAL_8250_RSA=y

# 
# Non-8250 serial port support
# 
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=128
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

# 
# I2C support
# 
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_PROSAVAGE is not set
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=y
CONFIG_I2C_VELLEMAN=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=y
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=y

# 
# I2C Hardware Sensors Mainboard support
# 
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISA is not set
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

# 
# I2C Hardware Sensors Chip support
# 
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
CONFIG_I2C_SENSOR=m

# 
# Mice
# 
CONFIG_BUSMOUSE=m
# CONFIG_QIC02_TAPE is not set

# 
# IPMI
# 
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

# 
# Watchdog Cards
# 
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
CONFIG_W83877F_WDT=m
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

# 
# Ftape, the floppy tape device driver
# 
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

# 
# The compressor will be built as a module only!
# 
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_PROC_FS=y
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

# 
# Hardware configuration
# 
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_MGA=y
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=m
CONFIG_HANGCHECK_TIMER=m

# 
# Multimedia devices
# 
CONFIG_VIDEO_DEV=m

# 
# Video For Linux
# 
CONFIG_VIDEO_PROC_FS=y

# 
# Video Adapters
# 
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set

# 
# Radio Adapters
# 
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

# 
# Digital Video Broadcasting Devices
# 
# CONFIG_DVB is not set
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m

# 
# File systems
# 
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

# 
# CD-ROM/DVD Filesystems
# 
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

# 
# DOS/FAT/NT Filesystems
# 
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

# 
# Pseudo filesystems
# 
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_RAMFS=y

# 
# Miscellaneous filesystems
# 
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
CONFIG_HPFS_FS=m
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y

# 
# Network File Systems
# 
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
# CONFIG_AFS_FS is not set

# 
# Partition Types
# 
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

# 
# Native Language Support
# 
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
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
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=y

# 
# Graphics support
# 
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
CONFIG_FB_VIRTUAL=m

# 
# Console display driver support
# 
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

# 
# Logo configuration
# 
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

# 
# Sound
# 
CONFIG_SOUND=m

# 
# Advanced Linux Sound Architecture
# 
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

# 
# Generic devices
# 
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

# 
# ISA devices
# 
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

# 
# PCI devices
# 
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

# 
# ALSA USB devices
# 
# CONFIG_SND_USB_AUDIO is not set

# 
# Open Sound System
# 
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_AD1889 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
CONFIG_SOUND_MPU401=m
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
# CONFIG_SOUND_AEDSP16 is not set
CONFIG_SOUND_TVMIXER=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_AD1980 is not set

# 
# USB support
# 
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

# 
# Miscellaneous USB options
# 
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y

# 
# USB Host Controller Drivers
# 
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

# 
# USB Device Class drivers
# 
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

# 
# USB Human Interface Devices (HID)
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
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_XPAD=m

# 
# USB Imaging devices
# 
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

# 
# USB Multimedia devices
# 
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m

# 
# USB Network adaptors
# 
CONFIG_USB_AX8817X=m
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

# 
# USB Host-to-Host Cables
# 
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

# 
# Intelligent USB Devices/Gadgets
# 
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

# 
# USB port drivers
# 
CONFIG_USB_USS720=m

# 
# USB Serial Converter support
# 
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
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
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

# 
# USB Miscellaneous drivers
# 
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
CONFIG_USB_TEST=m
CONFIG_USB_GADGET=m
CONFIG_USB_NET2280=m
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_NET2280=y
CONFIG_USB_ETH=m
CONFIG_USB_ETH_NET2280=y

# 
# Bluetooth support
# 
# CONFIG_BT is not set

# 
# Profiling support
# 
# CONFIG_PROFILING is not set

# 
# Kernel hacking
# 
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

# 
# Security options
# 
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_ROOTPLUG=m

# 
# Cryptographic options
# 
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_TEST=m

# 
# Library routines
# 
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
--end of .config---



Steps to reproduce:

