Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261889AbREZQd5>; Sat, 26 May 2001 12:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbREZQds>; Sat, 26 May 2001 12:33:48 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:46348 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S261889AbREZQdo> convert rfc822-to-8bit;
	Sat, 26 May 2001 12:33:44 -0400
Date: Sat, 26 May 2001 16:43:12 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with AIC7XXX in 2.4.5 
Message-ID: <Pine.LNX.4.33.0105261639500.727-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,
I'm having problems with aic7xxx on 2.4.5 final. I just upgraded from
2.4.4 where it was working perfect. I booted 2.4.5 ,and it started
printing some messages like
scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: Data Parity Error Detected during address or write data phase

( full log follows at the end )

And, then the machine hung up. I looked a bit the messages, saw that
there is one more device that has the same IRQ, the USB controller, but
it's disabled in the BIOS, and I haven't found any way to make it go on
another IRQ ( maybe this is a known bug, my motherboard is ASUS P2B-S).
Is it from the new driver in 2.4.5 or from something else?


May 26 15:27:02 doom kernel: klogd 1.4.1#2, log source = /proc/kmsg started.
May 26 15:27:02 doom kernel: Cannot find map file.
May 26 15:27:02 doom kernel: No module symbols loaded.
May 26 15:27:02 doom kernel: Linux version 2.4.5 (root@doom) (gcc version 2.95.4 20010506 (Debian prerelease)) #29 —· Ã‡È 26 15:01:51 EEST 2001
May 26 15:27:02 doom kernel: BIOS-provided physical RAM map:
May 26 15:27:02 doom kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
May 26 15:27:02 doom kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
May 26 15:27:02 doom kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
May 26 15:27:02 doom kernel:  BIOS-e820: 0000000000100000 - 000000000bffd000 (usable)
May 26 15:27:02 doom kernel:  BIOS-e820: 000000000bffd000 - 000000000bfff000 (ACPI data)
May 26 15:27:02 doom kernel:  BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
May 26 15:27:02 doom kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
May 26 15:27:02 doom kernel: On node 0 totalpages: 49149
May 26 15:27:02 doom kernel: zone(0): 4096 pages.
May 26 15:27:02 doom kernel: zone(1): 45053 pages.
May 26 15:27:02 doom kernel: zone(2): 0 pages.
May 26 15:27:02 doom kernel: Kernel command line: BOOT_IMAGE=Linux245 ro root=801
May 26 15:27:02 doom kernel: Initializing CPU#0
May 26 15:27:02 doom kernel: Detected 300.684 MHz processor.
May 26 15:27:02 doom kernel: Console: colour VGA+ 80x25
May 26 15:27:02 doom kernel: Calibrating delay loop... 599.65 BogoMIPS
May 26 15:27:02 doom kernel: Memory: 190736k/196596k available (1304k kernel code, 5472k reserved, 475k data, 188k init, 0k highmem)
May 26 15:27:02 doom kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
May 26 15:27:02 doom kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
May 26 15:27:02 doom kernel: Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
May 26 15:27:02 doom kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
May 26 15:27:02 doom kernel: CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
May 26 15:27:02 doom kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 26 15:27:02 doom kernel: CPU: L2 cache: 128K
May 26 15:27:02 doom kernel: Intel machine check architecture supported.
May 26 15:27:02 doom kernel: Intel machine check reporting enabled on CPU#0.
May 26 15:27:02 doom kernel: CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
May 26 15:27:02 doom kernel: CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
May 26 15:27:02 doom kernel: CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
May 26 15:27:02 doom kernel: CPU: Intel Celeron (Mendocino) stepping 00
May 26 15:27:02 doom kernel: Enabling fast FPU save and restore... done.
May 26 15:27:02 doom kernel: Checking 'hlt' instruction... OK.
May 26 15:27:02 doom kernel: POSIX conformance testing by UNIFIX
May 26 15:27:02 doom kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
May 26 15:27:02 doom kernel: mtrr: detected mtrr type: Intel
May 26 15:27:02 doom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0750, last bus=1
May 26 15:27:02 doom kernel: PCI: Using configuration type 1
May 26 15:27:02 doom kernel: PCI: Probing PCI hardware
May 26 15:27:02 doom kernel: Unknown bridge resource 0: assuming transparent
May 26 15:27:02 doom kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
May 26 15:27:02 doom kernel: PCI: Found IRQ 9 for device 00:04.2
May 26 15:27:02 doom kernel: PCI: The same IRQ used for device 00:06.0
May 26 15:27:02 doom kernel: Limiting direct PCI/PCI transfers.
May 26 15:27:02 doom kernel: Linux NET4.0 for Linux 2.4
May 26 15:27:02 doom kernel: Based upon Swansea University Computer Society NET3.039
May 26 15:27:02 doom kernel: Initializing RT netlink socket
May 26 15:27:02 doom kernel: IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
May 26 15:27:02 doom kernel: apm: BIOS version 1.2 Flags 0x0b (Driver version 1.14)
May 26 15:27:02 doom kernel: Starting kswapd v1.8
May 26 15:27:02 doom kernel: Coda Kernel/Venus communications, v5.3.14, coda@cs.cmu.edu
May 26 15:27:02 doom kernel: pty: 256 Unix98 ptys configured
May 26 15:27:02 doom kernel: Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
May 26 15:27:02 doom kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
May 26 15:27:02 doom kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
May 26 15:27:02 doom kernel: Real Time Clock Driver v1.10d
May 26 15:27:02 doom kernel: Non-volatile memory driver v1.1
May 26 15:27:02 doom kernel: block: queued sectors max/low 126608kB/42202kB, 384 slots per queue
May 26 15:27:02 doom kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 26 15:27:02 doom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 26 15:27:02 doom kernel: PIIX4: IDE controller on PCI bus 00 dev 21
May 26 15:27:02 doom kernel: PIIX4: chipset revision 1
May 26 15:27:02 doom kernel: PIIX4: not 100%% native mode: will probe irqs later
May 26 15:27:02 doom kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
May 26 15:27:02 doom kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
May 26 15:27:02 doom kernel: hdd: ASUS CD-S360, ATAPI CD/DVD-ROM drive
May 26 15:27:02 doom kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 26 15:27:02 doom kernel: hdd: ATAPI 36X CD-ROM drive, 128kB Cache, UDMA(33)
May 26 15:27:02 doom kernel: Uniform CD-ROM driver Revision: 3.12
May 26 15:27:02 doom kernel: Floppy drive(s): fd0 is 1.44M
May 26 15:27:02 doom kernel: FDC 0 is a post-1991 82077
May 26 15:27:02 doom kernel: SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
May 26 15:27:02 doom kernel: CSLIP: code copyright 1989 Regents of the University of California.
May 26 15:27:02 doom kernel: loop: loaded (max 8 devices)
May 26 15:27:02 doom kernel: Davicom DM9xxx net driver, version 1.36p1 (May 12, 2001)
May 26 15:27:02 doom kernel: PCI: Found IRQ 7 for device 00:0a.0
May 26 15:27:02 doom kernel: eth0: Davicom DM9102 at 0xb800, 00:80:ad:72:13:5a, IRQ 7
May 26 15:27:02 doom kernel: PPP generic driver version 2.4.1
May 26 15:27:02 doom kernel: PPP Deflate Compression module registered
May 26 15:27:02 doom kernel: PPP BSD Compression module registered
May 26 15:27:02 doom kernel: Registered PPPoX v0.5
May 26 15:27:02 doom kernel: Registered PPPoE v0.6.5
May 26 15:27:02 doom kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
May 26 15:27:02 doom kernel: agpgart: Maximum main memory to use for agp memory: 149M
May 26 15:27:02 doom kernel: agpgart: Detected Intel 440BX chipset
May 26 15:27:02 doom kernel: agpgart: AGP aperture is 128M @ 0xe0000000
May 26 15:27:02 doom kernel: [drm] AGP 0.99 on Intel 440BX @ 0xe0000000 128MB
May 26 15:27:02 doom kernel: [drm] Initialized mga 2.0.1 20000928 on minor 63
May 26 15:27:02 doom kernel: SCSI subsystem driver Revision: 1.00
May 26 15:27:02 doom kernel: PCI: Found IRQ 9 for device 00:06.0
May 26 15:27:02 doom kernel: PCI: The same IRQ used for device 00:04.2
May 26 15:27:02 doom kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
May 26 15:27:02 doom kernel:         <Adaptec aic7890/91 Ultra2 SCSI adapter>
May 26 15:27:02 doom kernel:         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
May 26 15:27:02 doom kernel:
May 26 15:27:02 doom kernel:   Vendor: IBM       Model: DDYS-T36950N      Rev: S93E
May 26 15:27:02 doom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
May 26 15:27:02 doom kernel: (scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
May 26 15:27:02 doom kernel: scsi0:0:0:0: Tagged Queuing enabled.  Depth 24
May 26 15:27:02 doom kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
May 26 15:27:02 doom kernel: SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
May 26 15:27:02 doom kernel: Partition check:
May 26 15:27:02 doom kernel:  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
May 26 15:27:02 doom kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 26 15:27:02 doom kernel: IP Protocols: ICMP, UDP, TCP, IGMP
May 26 15:27:02 doom kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
May 26 15:27:02 doom kernel: TCP: Hash tables configured (established 16384 bind 16384)
May 26 15:27:02 doom kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
May 26 15:27:02 doom kernel: VFS: Mounted root (ext2 filesystem) readonly.
May 26 15:27:02 doom kernel: Freeing unused kernel memory: 188k freed
May 26 15:27:02 doom kernel: Adding Swap: 104384k swap-space (priority -1)
May 26 15:27:02 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:02 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:02 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:02 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:02 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x90
May 26 15:27:02 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:02 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x55
May 26 15:27:02 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:04 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:04 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:04 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:04 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:04 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:04 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:04 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:04 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:04 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:04 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:05 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:05 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:05 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:05 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:09 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:09 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:10 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:10 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:14 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:14 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:15 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:15 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:15 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:15 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:20 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:20 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x1a6
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x56
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8e
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x90
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:21 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:21 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:22 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:22 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:22 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:22 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:22 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:22 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:22 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:22 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:23 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:23 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:25 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:25 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:27 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:27 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:27 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:27 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:27 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:27 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:28 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:28 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:28 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:28 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:33 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:33 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:34 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:34 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:34 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
May 26 15:27:34 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:35 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:35 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:35 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:35 doom kernel: scsi0: Data Parity Error Detected during address or write data phase
May 26 15:27:35 doom kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
May 26 15:27:35 doom kernel: scsi0: Data Parity Error Detected during address or write data phase

