Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284354AbRLEMw6>; Wed, 5 Dec 2001 07:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284363AbRLEMwu>; Wed, 5 Dec 2001 07:52:50 -0500
Received: from ti200710a082-0406.bb.online.no ([148.122.9.150]:11012 "EHLO
	empire.local") by vger.kernel.org with ESMTP id <S284354AbRLEMwd>;
	Wed, 5 Dec 2001 07:52:33 -0500
Message-ID: <3C0E19B6.7010903@freenix.no>
Date: Wed, 05 Dec 2001 13:57:26 +0100
From: "Frode E. Moe" <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011130
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ooops! on 2.4.16 + preemptive
Content-Type: multipart/mixed;
 boundary="------------050404000708040000080800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050404000708040000080800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello. I received several Ooops!es today after upgrading to 2.4.16 + 
preemptive patch from http://www.tech9.net/rml/linux/.

I used this same kernel yesterday without problems, but today it crashed 
miserably after only fifteen minutes.

The first oops! occured after pressing "play" in xmms after having it 
set on "pause" for about ten minutes. Xmms segfaulted (see attached 
oops!), and afterwards X bombed completely. I could log in on two 
virtual consoles, but nothing worked (like "ps ax" etc.), and afterwards 
the machine was completely dead. (I could switch consoles but nothing more).

It seems only the first oops! got logged into /var/log/messages, but 
several others occured while trying to log in on the console.

I think the error message that appeared along with the oops was
"Unable to handle kernel paging request".

I'm running yesterday's version of Debian Sid.

Please email me back if you need additional information!

With regards,
Frode

--------------050404000708040000080800
Content-Type: text/plain;
 name="ksymoops-out.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops-out.txt"

ksymoops 2.4.3 on i686 2.4.16preemptive.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16preemptive/ (default)
     -m /boot/System.map-2.4.16preemptive (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Dec  5 12:55:53 kingdom kernel: cpu: 0, clocks: 2000089, slice: 1000044
Dec  5 12:55:53 kingdom kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Dec  5 12:55:53 kingdom kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Dec  5 13:11:02 kingdom kernel: c012ef95
Dec  5 13:11:02 kingdom kernel: Oops: 0002
Dec  5 13:11:02 kingdom kernel: CPU:    0
Dec  5 13:11:02 kingdom kernel: EIP:    0010:[<c012ef95>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  5 13:11:02 kingdom kernel: EFLAGS: 00010006
Dec  5 13:11:02 kingdom kernel: eax: c1607e60   ebx: c1607e58   ecx: cdcc4000   edx: 0852aec1
Dec  5 13:11:02 kingdom kernel: esi: c1607e50   edi: 00000246   ebp: 000000f0   esp: d1a2be24
Dec  5 13:11:02 kingdom kernel: ds: 0018   es: 0018   ss: 0018
Dec  5 13:11:02 kingdom kernel: Process xmms (pid: 450, stackpage=d1a2b000)
Dec  5 13:11:02 kingdom kernel: Stack: cdcc50c0 00000200 00000200 00000001 c0139285 c1607e50 000000f0 cdcc50c0 
Dec  5 13:11:02 kingdom kernel:        c013934d 00000001 c133f500 00000348 0000106e c133f500 c0139587 c133f500 
Dec  5 13:11:02 kingdom kernel:        00000200 00000001 c133f500 d1a3ca70 c0139a4d c133f500 00000348 00000200 
Dec  5 13:11:02 kingdom kernel: Call Trace: [<c0139285>] [<c013934d>] [<c0139587>] [<c0139a4d>] [<c0130cf3>] 
Dec  5 13:11:02 kingdom kernel:    [<c0129ab2>] [<c0178aaf>] [<c0176f60>] [<c0129b7e>] [<c012a215>] [<c012a450>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c012ef94 <kmem_cache_alloc+44/b0>   <=====
Trace; c0139284 <get_unused_buffer_head+54/e0>
Trace; c013934c <create_buffers+1c/100>
Trace; c0139586 <create_empty_buffers+16/50>
Trace; c0139a4c <block_read_full_page+4c/1c0>
Trace; c0130cf2 <__alloc_pages+32/170>
Trace; c0129ab2 <add_to_page_cache_unique+92/a0>
Trace; c0178aae <fat_readpage+e/20>
Trace; c0176f60 <fat_get_block+0/d0>
Trace; c0129b7e <page_cache_read+be/e0>
Trace; c012a214 <generic_file_readahead+104/140>
Trace; c012a450 <do_generic_file_read+1d0/470>


2 warnings issued.  Results may not be reliable.

--------------050404000708040000080800
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Dec  5 12:55:53 kingdom syslogd 1.4.1#6: restart.
Dec  5 12:55:53 kingdom kernel: klogd 1.4.1#6, log source = /proc/kmsg started.
Dec  5 12:55:53 kingdom kernel: Cannot find map file.
Dec  5 12:55:53 kingdom kernel: Loaded 207 symbols from 6 modules.
Dec  5 12:55:53 kingdom kernel: Linux version 2.4.16preemptive (root@kingdom) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Tue Dec 4 16:01:41 CET 2001
Dec  5 12:55:53 kingdom kernel: BIOS-provided physical RAM map:
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
Dec  5 12:55:53 kingdom kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Dec  5 12:55:53 kingdom kernel: On node 0 totalpages: 98284
Dec  5 12:55:53 kingdom kernel: zone(0): 4096 pages.
Dec  5 12:55:53 kingdom kernel: zone(1): 94188 pages.
Dec  5 12:55:53 kingdom kernel: zone(2): 0 pages.
Dec  5 12:55:53 kingdom kernel: Local APIC disabled by BIOS -- reenabling.
Dec  5 12:55:53 kingdom kernel: Found and enabled local APIC!
Dec  5 12:55:53 kingdom kernel: Kernel command line: BOOT_IMAGE=kingdom2416p ro root=345
Dec  5 12:55:53 kingdom kernel: Initializing CPU#0
Dec  5 12:55:53 kingdom kernel: Detected 750.053 MHz processor.
Dec  5 12:55:53 kingdom kernel: Console: colour VGA+ 80x50
Dec  5 12:55:53 kingdom kernel: Calibrating delay loop... 1497.49 BogoMIPS
Dec  5 12:55:53 kingdom kernel: Memory: 383992k/393136k available (1610k kernel code, 8756k reserved, 503k data, 220k init, 0k highmem)
Dec  5 12:55:53 kingdom kernel: Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Dec  5 12:55:53 kingdom kernel: Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Dec  5 12:55:53 kingdom kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Dec  5 12:55:53 kingdom kernel: Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Dec  5 12:55:53 kingdom kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec  5 12:55:53 kingdom kernel: Intel machine check architecture supported.
Dec  5 12:55:53 kingdom kernel: Intel machine check reporting enabled on CPU#0.
Dec  5 12:55:53 kingdom kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Dec  5 12:55:53 kingdom kernel: CPU: L2 Cache: 512K (64 bytes/line)
Dec  5 12:55:53 kingdom kernel: CPU: AMD Athlon(tm) Processor stepping 01
Dec  5 12:55:53 kingdom kernel: Enabling fast FPU save and restore... done.
Dec  5 12:55:53 kingdom kernel: Checking 'hlt' instruction... OK.
Dec  5 12:55:53 kingdom kernel: POSIX conformance testing by UNIFIX
Dec  5 12:55:53 kingdom kernel: enabled ExtINT on CPU#0
Dec  5 12:55:53 kingdom kernel: ESR value before enabling vector: 00000000
Dec  5 12:55:53 kingdom kernel: ESR value after enabling vector: 00000000
Dec  5 12:55:53 kingdom kernel: Using local APIC timer interrupts.
Dec  5 12:55:53 kingdom kernel: calibrating APIC timer ...
Dec  5 12:55:53 kingdom kernel: ..... CPU clock speed is 750.0338 MHz.
Dec  5 12:55:53 kingdom kernel: ..... host bus clock speed is 200.0089 MHz.
Dec  5 12:55:53 kingdom kernel: cpu: 0, clocks: 2000089, slice: 1000044
Dec  5 12:55:53 kingdom kernel: CPU0<T0:2000080,T1:1000032,D:4,S:1000044,C:2000089>
Dec  5 12:55:53 kingdom kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Dec  5 12:55:53 kingdom kernel: mtrr: detected mtrr type: Intel
Dec  5 12:55:53 kingdom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1010, last bus=1
Dec  5 12:55:53 kingdom kernel: PCI: Using configuration type 1
Dec  5 12:55:53 kingdom kernel: PCI: Probing PCI hardware
Dec  5 12:55:53 kingdom kernel: PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Dec  5 12:55:53 kingdom kernel: PCI: Disabling Via external APIC routing
Dec  5 12:55:53 kingdom kernel: isapnp: Scanning for PnP cards...
Dec  5 12:55:53 kingdom kernel: isapnp: No Plug & Play device found
Dec  5 12:55:53 kingdom kernel: Linux NET4.0 for Linux 2.4
Dec  5 12:55:53 kingdom kernel: Based upon Swansea University Computer Society NET3.039
Dec  5 12:55:53 kingdom kernel: Initializing RT netlink socket
Dec  5 12:55:53 kingdom kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Dec  5 12:55:53 kingdom kernel: Starting kswapd
Dec  5 12:55:53 kingdom kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Dec  5 12:55:53 kingdom kernel: Journalled Block Device driver loaded
Dec  5 12:55:53 kingdom kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Dec  5 12:55:53 kingdom kernel: parport0: Printer, EPSON Stylus COLOR 850
Dec  5 12:55:53 kingdom kernel: parport_pc: Via 686A parallel port: io=0x378
Dec  5 12:55:53 kingdom kernel: pty: 256 Unix98 ptys configured
Dec  5 12:55:53 kingdom kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Dec  5 12:55:53 kingdom kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec  5 12:55:53 kingdom kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec  5 12:55:53 kingdom kernel: lp0: using parport0 (polling).
Dec  5 12:55:53 kingdom kernel: lp0: console ready
Dec  5 12:55:53 kingdom kernel: Real Time Clock Driver v1.10e
Dec  5 12:55:53 kingdom kernel: Non-volatile memory driver v1.1
Dec  5 12:55:53 kingdom kernel: ppdev: user-space parallel port driver
Dec  5 12:55:53 kingdom kernel: block: 128 slots per queue, batch=32
Dec  5 12:55:53 kingdom kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Dec  5 12:55:53 kingdom kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Dec  5 12:55:53 kingdom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  5 12:55:53 kingdom kernel: VP_IDE: IDE controller on PCI bus 00 dev 21
Dec  5 12:55:53 kingdom kernel: VP_IDE: chipset revision 16
Dec  5 12:55:53 kingdom kernel: VP_IDE: not 100%% native mode: will probe irqs later
Dec  5 12:55:53 kingdom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Dec  5 12:55:53 kingdom kernel: VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:04.1
Dec  5 12:55:53 kingdom kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
Dec  5 12:55:53 kingdom kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Dec  5 12:55:53 kingdom kernel: hda: IBM-DPTA-372050, ATA DISK drive
Dec  5 12:55:53 kingdom kernel: hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
Dec  5 12:55:53 kingdom kernel: hdc: _NEC DV-5700A, ATAPI CD/DVD-ROM drive
Dec  5 12:55:53 kingdom kernel: hdd: CR-4801TE, ATAPI CD/DVD-ROM drive
Dec  5 12:55:53 kingdom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  5 12:55:53 kingdom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec  5 12:55:53 kingdom kernel: hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(66)
Dec  5 12:55:53 kingdom kernel: hdb: 40132503 sectors (20548 MB) w/1900KiB Cache, CHS=2498/255/63, UDMA(66)
Dec  5 12:55:53 kingdom kernel: Partition check:
Dec  5 12:55:53 kingdom kernel:  hda: hda1 hda2 < hda5 >
Dec  5 12:55:53 kingdom kernel:  hdb: hdb1 < hdb5 hdb6 hdb7 hdb8 > hdb2
Dec  5 12:55:53 kingdom kernel: Floppy drive(s): fd0 is 1.44M
Dec  5 12:55:53 kingdom kernel: FDC 0 is a post-1991 82077
Dec  5 12:55:53 kingdom kernel: loop: loaded (max 8 devices)
Dec  5 12:55:53 kingdom kernel: SCSI subsystem driver Revision: 1.00
Dec  5 12:55:53 kingdom kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Dec  5 12:55:53 kingdom kernel:   Vendor: _NEC      Model: DV-5700A          Rev: 1.91
Dec  5 12:55:53 kingdom kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Dec  5 12:55:53 kingdom kernel:   Vendor: MITSUMI   Model: CR-4801TE         Rev: 2.03
Dec  5 12:55:53 kingdom kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Dec  5 12:55:53 kingdom kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Dec  5 12:55:53 kingdom kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Dec  5 12:55:53 kingdom kernel: sr0: scsi3-mmc drive: 17x/40x cd/rw xa/form2 cdda tray
Dec  5 12:55:53 kingdom kernel: Uniform CD-ROM driver Revision: 3.12
Dec  5 12:55:53 kingdom kernel: sr1: scsi3-mmc drive: 8x/8x writer cd/rw xa/form2 cdda tray
Dec  5 12:55:53 kingdom kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec  5 12:55:53 kingdom kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec  5 12:55:53 kingdom kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Dec  5 12:55:53 kingdom kernel: TCP: Hash tables configured (established 32768 bind 32768)
Dec  5 12:55:53 kingdom kernel: IPv4 over IPv4 tunneling driver
Dec  5 12:55:53 kingdom kernel: GRE over IPv4 tunneling driver
Dec  5 12:55:53 kingdom kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Dec  5 12:55:53 kingdom kernel: VFS: Mounted root (ext2 filesystem) readonly.
Dec  5 12:55:53 kingdom kernel: Freeing unused kernel memory: 220k freed
Dec  5 12:55:53 kingdom kernel: Adding Swap: 160608k swap-space (priority -1)
Dec  5 12:55:53 kingdom kernel: PCI: Found IRQ 9 for device 00:0d.0
Dec  5 12:55:53 kingdom kernel: PCI: Sharing IRQ 9 with 00:04.2
Dec  5 12:55:53 kingdom kernel: PCI: Sharing IRQ 9 with 00:04.3
Dec  5 12:55:53 kingdom kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Dec  5 12:55:53 kingdom kernel: 00:0d.0: 3Com PCI 3c900 Cyclone 10Mbps Combo at 0x9800. Vers LK1.1.16
Dec  5 12:55:53 kingdom kernel: Creative EMU10K1 PCI Audio Driver, version 0.16, 16:10:06 Dec  4 2001
Dec  5 12:55:53 kingdom kernel: PCI: Found IRQ 10 for device 00:0b.0
Dec  5 12:55:53 kingdom kernel: emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xa400-0xa41f, IRQ 10
Dec  5 12:55:53 kingdom kernel: ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Dec  5 12:55:58 kingdom kernel: NVRM: loading NVIDIA kernel module version 1.0-1541
Dec  5 12:55:58 kingdom kernel: spurious 8259A interrupt: IRQ7.
Dec  5 13:11:02 kingdom kernel:  printing eip:
Dec  5 13:11:02 kingdom kernel: c012ef95
Dec  5 13:11:02 kingdom kernel: Oops: 0002
Dec  5 13:11:02 kingdom kernel: CPU:    0
Dec  5 13:11:02 kingdom kernel: EIP:    0010:[<c012ef95>]    Tainted: P 
Dec  5 13:11:02 kingdom kernel: EFLAGS: 00010006
Dec  5 13:11:02 kingdom kernel: eax: c1607e60   ebx: c1607e58   ecx: cdcc4000   edx: 0852aec1
Dec  5 13:11:02 kingdom kernel: esi: c1607e50   edi: 00000246   ebp: 000000f0   esp: d1a2be24
Dec  5 13:11:02 kingdom kernel: ds: 0018   es: 0018   ss: 0018
Dec  5 13:11:02 kingdom kernel: Process xmms (pid: 450, stackpage=d1a2b000)
Dec  5 13:11:02 kingdom kernel: Stack: cdcc50c0 00000200 00000200 00000001 c0139285 c1607e50 000000f0 cdcc50c0 
Dec  5 13:11:02 kingdom kernel:        c013934d 00000001 c133f500 00000348 0000106e c133f500 c0139587 c133f500 
Dec  5 13:11:02 kingdom kernel:        00000200 00000001 c133f500 d1a3ca70 c0139a4d c133f500 00000348 00000200 
Dec  5 13:11:02 kingdom kernel: Call Trace: [<c0139285>] [<c013934d>] [<c0139587>] [<c0139a4d>] [<c0130cf3>] 
Dec  5 13:11:02 kingdom kernel:    [<c0129ab2>] [<c0178aaf>] [<c0176f60>] [<c0129b7e>] [<c012a215>] [<c012a450>] 

--------------050404000708040000080800--

