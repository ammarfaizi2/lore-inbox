Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310193AbSCKQgL>; Mon, 11 Mar 2002 11:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310197AbSCKQgC>; Mon, 11 Mar 2002 11:36:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64642 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310193AbSCKQfp>; Mon, 11 Mar 2002 11:35:45 -0500
Date: Mon, 11 Mar 2002 11:37:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE on linux-2.4.18
In-Reply-To: <E16kSg8-00010S-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1020311113143.2648A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alan Cox wrote:

> > hda:	Cannot handle device with more than 16 heads giving up.
> 
> You enabled the old ST506 driver not the newer IDE one
> 
I don't think so. If I put append= "hda=1024,255,63" in LILO it works,
although I think I'm working around something that's broken.

Here's `dmesg` after the hack.


Linux version 2.4.18 (root@blackhole) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #12 SMP Mon Mar 11 09:56:04 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffc000 (usable)
 BIOS-e820: 0000000007ffc000 - 0000000007fff000 (ACPI data)
 BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32764
zone(0): 4096 pages.
zone(1): 28668 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=new root=305 BOOT_FILE=/boot/vmlinuz-2.4.18 nmi_watchdog=0 hda=1024,255,63
ide_setup: hda=1024,255,63
Initializing CPU#0
Detected 752.835 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1500.77 BogoMIPS
Memory: 126440k/131056k available (1012k kernel code, 4228k reserved, 232k data, 116k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 732.05 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 752.8208 MHz.
..... host bus clock speed is 100.3760 MHz.
cpu: 0, clocks: 1003760, slice: 501880
CPU0<T0:1003760,T1:501872,D:8,S:501880,C:1003760>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0890, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0596] at 00:04.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
hda: QUANTUM FIREBALL EX10.2A, ATA DISK drive
hdb: FX4830T, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1024/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
hd: unable to get major 3 for hard disk
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 421k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... okay
Freeing unused kernel memory: 116k freed
Adding Swap: 72252k swap-space (priority -1)
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 5 for device 00:0a.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[df800000-df800800]  Max Packet=[2048]
ieee1394: Device added: node 1:1023, GUID 080028500000ffff
raw1394: /dev/raw1394 device initialized
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 00:0b.0
eth0: PCI device 8086:1229, 00:02:B3:03:3B:BE, IRQ 10.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Analogic(tm) GPIB Driver: No GPIB device at (0x0300)
Analogic(tm) GPIB Driver: Initialization complete
loop: loaded (max 8 devices)


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

