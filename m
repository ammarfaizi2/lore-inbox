Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276507AbRI2OWS>; Sat, 29 Sep 2001 10:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276506AbRI2OWL>; Sat, 29 Sep 2001 10:22:11 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:44161 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S276505AbRI2OV7>;
	Sat, 29 Sep 2001 10:21:59 -0400
Date: Sat, 29 Sep 2001 16:22:24 +0200
From: Ookhoi <ookhoi@dds.nl>
To: gibbs@plutotech.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine)
Message-ID: <20010929162224.E9327@humilis>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 20:50:40 up 1 day, 9 min,  9 users,  load average: 0.08, 0.12, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin, Alan,

The new driver for the Adaptec 7892B gives me the following problems
(see dmesg) on a asus a7v mobo with kernel 2.4.9-ac17.

I have to run the system underclocked to make it boot at all. As soon as
I run it at 1000 or 1200 MHz, it does a Kernel panic: for safety during
the scsi boot part. It is a 1200MHz processor. The system runs fine
after the (long) boot.

The old driver doesn't compile with -ac17, it does with -ac16.

2.4.9-ac17:
[blabla]
aic7xxx_old.c:11965: parse error before string constant
aic7xxx_old.c:11965: warning: type defaults to `int' in declaration of `MODULE_LICENSE'
aic7xxx_old.c:11965: warning: function declaration isn't a prototype
aic7xxx_old.c:11965: warning: data definition has no type or storage class
make[3]: *** [aic7xxx_old.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_scsi] Error 2
make: *** [_dir_drivers] Error 2


With the old AIC7XXX driver, the system boots normal (-ac16 dmesg below
-ac17 dmesg).

Is there something wrong with the driver? Or settings I have to look for
in the scsi bios?

Tia!

	Ookhoi


Linux version 2.4.9-ac17 (root@tranquil) (gcc version 2.95.4 20010902 (Debian prerelease)) #1 Sat Sep 29 13:15:37 UTC 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 196588
zone(0): 4096 pages.
zone(1): 192492 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=2.4.9-ac17 ro root=901
Initializing CPU#0
Detected 807.224 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1608.90 BogoMIPS
Memory: 770956k/786352k available (1129k kernel code, 15008k reserved, 318k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 807.2539 MHz.
..... host bus clock speed is 201.8134 MHz.
cpu: 0, clocks: 2018134, slice: 1009067
CPU0<T0:2018128,T1:1009056,D:5,S:1009067,C:2018134>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PnP: PNP BIOS installation structure at 0xc00fc2b0
PnP: PNP BIOS version 1.0, entry at f0000:c2e0, dseg at f0000
PnPBIOS: PNP0c02: request 0xe400-0xe480 ok
PnPBIOS: PNP0c02: request 0xe800-0xe840
PnP: 12 devices detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: queued sectors max/low 511730kB/380658kB, 1536 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Found IRQ 11 for device 00:0c.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0c.0: 3Com PCI 3c905C Tornado at 0x9400. Vers LK1.1.16
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: unsupported bridge
agpgart: no supported devices found.

---

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 12 for device 00:0d.0
PCI: Sharing IRQ 12 with 00:04.3
scsi0: PCI error Interrupt at seqaddr = 0x44
scsi0: Signaled a Target Abort
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: PCI error Interrupt at seqaddr = 0x18
scsi0: Signaled a Target Abort
scsi0:0:5:0: Attempting to queue an ABORT message
scsi0:0:5:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:5:0: Attempting to queue an ABORT message
scsi0:0:5:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:5:0: Attempting to queue a TARGET RESET message
scsi0:0:5:0: Is not an active device
aic7xxx_dev_reset returns 8194
scsi0:0:5:0: Attempting to queue an ABORT message
scsi0:0:5:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0: PCI error Interrupt at seqaddr = 0x44
scsi0: Signaled a Target Abort
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 5 lun 0
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: PCI error Interrupt at seqaddr = 0x18
scsi0: Signaled a Target Abort
scsi0:0:9:0: Attempting to queue an ABORT message
scsi0:0:9:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:9:0: Attempting to queue an ABORT message
scsi0:0:9:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:9:0: Attempting to queue a TARGET RESET message
scsi0:0:9:0: Is not an active device
aic7xxx_dev_reset returns 8194
scsi0:0:9:0: Attempting to queue an ABORT message
scsi0:0:9:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0: PCI error Interrupt at seqaddr = 0x3
scsi0: Signaled a Target Abort
spurious 8259A interrupt: IRQ7.
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 9 lun 0
scsi0: PCI error Interrupt at seqaddr = 0x18
scsi0: Signaled a Target Abort
scsi0:0:15:0: Attempting to queue an ABORT message
scsi0:0:15:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:15:0: Attempting to queue an ABORT message
scsi0:0:15:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:15:0: Attempting to queue a TARGET RESET message
scsi0:0:15:0: Is not an active device
aic7xxx_dev_reset returns 8194
scsi0:0:15:0: Attempting to queue an ABORT message
scsi0:0:15:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0: PCI error Interrupt at seqaddr = 0x44
scsi0: Signaled a Target Abort
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 15 lun 0
scsi0:0:3:0: Tagged Queuing enabled.  Depth 253
scsi0:0:6:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
(scsi0:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1 sdb2

---

md: raid1 personality registered as nr 3
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) sda1's sb offset: 1049472 [events: 0000001c]
(read) sda2's sb offset: 16871360 [events: 00000019]
(read) sdb1's sb offset: 1049472 [events: 0000001c]
(read) sdb2's sb offset: 16871360 [events: 00000019]
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md1
md: bind<sda2,1>
md: bind<sdb2,2>
md: running: <sdb2><sda2>
md: sdb2's event counter: 00000019
md: sda2's event counter: 00000019
RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdb2 operational as mirror 1
raid1: device sda2 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sdb2 [events: 0000001a](write) sdb2's sb offset: 16871360
md: sda2 [events: 0000001a](write) sda2's sb offset: 16871360
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1,1>
md: bind<sdb1,2>
md: running: <sdb1><sda1>
md: sdb1's event counter: 0000001c
md: sda1's event counter: 0000001c
RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdb1 operational as mirror 1
raid1: device sda1 operational as mirror 0
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: sdb1 [events: 0000001d](write) sdb1's sb offset: 1049472
md: sda1 [events: 0000001d](write) sda1's sb offset: 1049472
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack (6143 buckets, 49144 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
md: swapper(pid 1) used obsolete MD ioctl, upgrade your software to use new ictls.
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 1049464k swap-space (priority -1)


===


Linux version 2.4.9-ac16 (root@tranquil) (gcc version 2.95.4 20010902 (Debian prerelease)) #1 Sat Sep 29 15:10:58 UTC 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffec000 (usable)
 BIOS-e820: 000000002ffec000 - 000000002ffef000 (ACPI data)
 BIOS-e820: 000000002ffef000 - 000000002ffff000 (reserved)
 BIOS-e820: 000000002ffff000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 196588
zone(0): 4096 pages.
zone(1): 192492 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=2.4.9-ac16 ro root=901
Initializing CPU#0
Detected 807.195 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1608.90 BogoMIPS
Memory: 770956k/786352k available (1133k kernel code, 15008k reserved, 321k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 807.1718 MHz.
..... host bus clock speed is 201.7929 MHz.
cpu: 0, clocks: 2017929, slice: 1008964
CPU0<T0:2017920,T1:1008944,D:12,S:1008964,C:2017929>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PnP: PNP BIOS installation structure at 0xc00fc2b0
PnP: PNP BIOS version 1.0, entry at f0000:c2e0, dseg at f0000
PnPBIOS: PNP0c02: request 0xe400-0xe480 ok
PnPBIOS: PNP0c02: request 0xe800-0xe840
PnP: 12 devices detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: queued sectors max/low 511730kB/380658kB, 1536 slots per queue
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Found IRQ 11 for device 00:0c.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0c.0: 3Com PCI 3c905C Tornado at 0x9400. Vers LK1.1.16
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: unsupported bridge
agpgart: no supported devices found.
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 12 for device 00:0d.0
PCI: Sharing IRQ 12 with 00:04.3
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 0/13/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
(scsi0:0:3:0) Synchronous at 160.0 Mbyte/sec, offset 63.
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2
(scsi0:0:6:0) Synchronous at 160.0 Mbyte/sec, offset 63.
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1 sdb2
md: raid1 personality registered as nr 3
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) sda1's sb offset: 1049472 [events: 00000020]
(read) sda2's sb offset: 16871360 [events: 0000001d]
(read) sdb1's sb offset: 1049472 [events: 00000020]
(read) sdb2's sb offset: 16871360 [events: 0000001d]
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md1
md: bind<sda2,1>
md: bind<sdb2,2>
md: running: <sdb2><sda2>
md: sdb2's event counter: 0000001d
md: sda2's event counter: 0000001d
RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdb2 operational as mirror 1
raid1: device sda2 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sdb2 [events: 0000001e](write) sdb2's sb offset: 16871360
md: sda2 [events: 0000001e](write) sda2's sb offset: 16871360
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1,1>
md: bind<sdb1,2>
md: running: <sdb1><sda1>
md: sdb1's event counter: 00000020
md: sda1's event counter: 00000020
RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdb1 operational as mirror 1
raid1: device sda1 operational as mirror 0
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: sdb1 [events: 00000021](write) sdb1's sb offset: 1049472
md: sda1 [events: 00000021](write) sda1's sb offset: 1049472
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack (6143 buckets, 49144 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
md: swapper(pid 1) used obsolete MD ioctl, upgrade your software to use new ictls.
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 1049464k swap-space (priority -1)
