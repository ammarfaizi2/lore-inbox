Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTDDHQF (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDDHQF (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:16:05 -0500
Received: from mail.set-software.de ([193.218.212.121]:28548 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP id S263456AbTDDHPh convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 02:15:37 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 04 Apr 2003 07:25:53 GMT
Message-ID: <20030404.7255311@knigge.local.net>
Subject: Strange e1000
To: <linux-kernel@vger.kernel.org>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi *,

when I load the e1000 module, my NIC is recognized. Then, "pump –i 
eth0" is called (DHCP-Client), the message "e1000: eth0 NIC Link is Up 
1000 Mbps Full Duplex" appears and after some time I get the message 
"operation failed".

When I sleep some time (currently 20 seconds) before doing the "pump", 
everything works as expected.

What the hell is happening here? Ok, I got it working with the 
20-sec-sleep but this is not the way it sould work...

My Board is a Gigabyte GA-7ZXR (1.0) and the Intel NIC is a PRO/1000 
MT (should be the 82540OEM Chip). The NIC is attached to a NetGear 
FSM726S Switch (24x100 + 2x1000). It is currenty the only box attached 
with a gigabit-nic to the switch. All other PC's (including the 
DHCP-Server) are 100 Mbit/s.... I hope I've written all somehow 
important things ;-)

My distribution is Debian Woody 3.0R1 with some updates (i.e. pump). 
I'm running 2.4.18 with the e1000 driver from the Intel site (I've 
tried e1000-4.6.11 and e1000-5.0.43) and pump is 0.8.14. I've also 
tried 2.4.21-pre5-ac3 with the "built-in" e1000 driver. All without 
any success...

Output from dmesg:

Linux version 2.4.18 (root@crash) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #1 SMP Fri Dec 27 09:08:43 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=Linux ro root=801
Initializing CPU#0
Detected 902.063 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 255388k/262144k available (1186k kernel code, 6368k reserved, 
450k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU0: AMD Athlon(tm) Processor stepping 02
per-CPU timeslice cutoff: 730.71 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 902.0570 MHz.
..... host bus clock speed is 200.4569 MHz.
cpu: 0, clocks: 2004569, slice: 1002284
CPU0<T0:2004560,T1:1002272,D:4,S:1002284,C:2004569>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb61, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue: [55] 89->09
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SCSI subsystem driver Revision: 1.00
3ware Storage Controller device driver for Linux v1.02.00.016.
PCI: Found IRQ 10 for device 00:0f.0
scsi0 : Found a 3ware Storage Controller at 0xdc00, IRQ: 10, P-chip: 
5.7
scsi0 : 3ware Storage Controller
  Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 160832256 512-byte hdwr sectors (82346 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 996020k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
Real Time Clock Driver v1.10e
Intel(R) PRO/1000 Network Driver - version 5.0.43
Copyright (c) 1999-2003 Intel Corporation.
PCI: Found IRQ 9 for device 00:0a.0
eth0: Intel(R) PRO/1000 Network Connection
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
spurious 8259A interrupt: IRQ7.


Any ideas? 


Bye & Thanks,
  Michael




