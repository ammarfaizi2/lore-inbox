Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWGERM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWGERM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWGERMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:12:25 -0400
Received: from web33504.mail.mud.yahoo.com ([68.142.206.153]:23687 "HELO
	web33504.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964908AbWGERMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:12:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2MqnxCDsyIxfKrgZzmJ0cNRECJ+ic7Pk2dgfV2uMmHMAeujzJMxqbnUX9nhL5w6cEMVDV1S1LcE1M8SGsItdp/OfRt2UD4R6vmK2ZpsOQWCNUpVhxBNAtWHbP/kYnMEyHCM7qm0eUbepWPDxHdaQ0dTG61Q1OjpU1fpY0Z12Rh8=  ;
Message-ID: <20060705171223.65590.qmail@web33504.mail.mud.yahoo.com>
Date: Wed, 5 Jul 2006 10:12:23 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Fwd: Re: sata_mv driver on 88sx6041 ( 2.6.14): PCI IRQ error
To: linux-kernel@vger.kernel.org
Cc: nhadke@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-780421898-1152119543=:64913"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-780421898-1152119543=:64913
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,
    The sata_mv I am using is with
  "three fixes" ie 0.6 on kernel version 2.6.14
(Marvell 6041 part) without the IEN related change. 
libata & scsi are modified(imported change from later
version of kernel) to make this change 
compile.(With IEN change  driver gets truck after 
identifying the disk)
   I  got rid of the disk errors but the next the
 error I am getting is related to PCI IRQ.
-----------------------------------------
SCSI device sda: drive cache: write back
 sda:<3>sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
 unknown partition table
Attached scsi disk sda at scsi2, channel 0, id 0, lun
0
--------------------------------------------------
  Please note that the same disk works perfectly fine
 in PIO mode( formating/read/write etc). So can't
suspect disk or connectors.
   Really apreciate if get any help/ponters on this.
 Please copy me on the reply,
Thanks,
Narendra

   Here is the complet dmesg:

-----------------------------------------------------
Octeon# run cfroot
reading vmlinux.64

45600467 bytes read
argv[2]: coremask=ffff
argv[3]: root=/dev/cfa2
ELF file is 64 bit
Allocated memory for ELF segment: addr: 0x1100000,
size 0x481110
Loading .text @ 0x81100000 (0x35ab70 bytes)
Loading __ex_table @ 0x8145ab70 (0x6be0 bytes)
Loading .rodata @ 0x81461750 (0x3fd28 bytes)
Loading .pci_fixup @ 0x814a1478 (0x600 bytes)
Loading __ksymtab @ 0x814a1a78 (0x7c00 bytes)
Loading __ksymtab_gpl @ 0x814a9678 (0x1530 bytes)
Loading __ksymtab_strings @ 0x814aaba8 (0xb6d0 bytes)
Loading __param @ 0x814b6278 (0x780 bytes)
Loading .data @ 0x814b8000 (0x66300 bytes)
Loading .data.cacheline_aligned @ 0x8151f000 (0x5a00
bytes)
Loading .init.text @ 0x81525000 (0x23f30 bytes)
Loading .init.data @ 0x81548f30 (0x3118 bytes)
Loading .init.setup @ 0x8154c050 (0x3f0 bytes)
Loading .initcall.init @ 0x8154c440 (0x380 bytes)
Loading .con_initcall.init @ 0x8154c7c0 (0x10 bytes)
Loading .init.ramfs @ 0x8154d000 (0x85 bytes)
Loading .data.percpu @ 0x8154d100 (0x5418 bytes)
Clearing .bss @ 0x81554000 (0x2d110 bytes)
## Loading Linux kernel with entry point: 0x81525000
...
Bootloader: Done loading app on coremask: 0xffff
WARNING: Network HW reset not implemented on this
board
Linux version 2.6.14-Cavium-Octeon (root@naren) (gcc
version 3.4.5 Cavium Networks Version: 1.3.1, build
54) #34 SMP Wed Jul 5 10:03:44 CDT 2006
Cavium Networks Version: 1.3.1, build 137
CVMSEG size: 2 cache lines (256 bytes)
Setting flash physical map for 8MB flash at 0x1f400000
CPU revision is: 000d0001
Determined physical RAM map:
 memory: 0000000000c00000 @ 0000000000110000 (usable)
 memory: 000000000e800000 @ 0000000001590000 (usable)
 memory: 0000000010c00000 @ 0000000020000000 (usable)
Built 1 zonelists
Kernel command line: console=ttyS0,115200 bootoctlinux
21000000 coremask=ffff root=/dev/cfa2
Primary instruction cache 32kB, virtually tagged, 4
way, 64 sets, linesize 128 bytes.
Primary data cache 8kB, 64-way, 1 sets, linesize 128
bytes.
Synthesized TLB refill handler (51 instructions).
Synthesized TLB load handler fastpath (49
instructions).
Synthesized TLB store handler fastpath (49
instructions).
Synthesized TLB modify handler fastpath (48
instructions).
PID hash table entries: 4096 (order: 12, 131072 bytes)
Using 503.000 MHz high precision timer.
Dentry cache hash table entries: 131072 (order: 8,
1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7,
524288 bytes)
Memory: 498432k/524288k available (3434k kernel code,
25416k reserved, 807k data,
184k init, 0k highmem)
Calibrating delay using timer specific routine..
1006.32 BogoMIPS (lpj=503161)
Mount-cache hash table entries: 256
Checking for 'wait' instruction...  available.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
softlockup thread 0 started up.
SMP: Booting CPU01 (CoreId  1)...CPU revision is:
000d0001
softlockup thread 1 started up.
SMP: Booting CPU02 (CoreId  2)...CPU revision is:
000d0001
softlockup thread 2 started up.
SMP: Booting CPU03 (CoreId  3)...CPU revision is:
000d0001
softlockup thread 3 started up.
SMP: Booting CPU04 (CoreId  4)...CPU revision is:
000d0001
softlockup thread 4 started up.
SMP: Booting CPU05 (CoreId  5)...CPU revision is:
000d0001
softlockup thread 5 started up.
SMP: Booting CPU06 (CoreId  6)...CPU revision is:
000d0001
softlockup thread 6 started up.
SMP: Booting CPU07 (CoreId  7)...CPU revision is:
000d0001
softlockup thread 7 started up.
SMP: Booting CPU08 (CoreId  8)...CPU revision is:
000d0001
softlockup thread 8 started up.
SMP: Booting CPU09 (CoreId  9)...CPU revision is:
000d0001
softlockup thread 9 started up.
SMP: Booting CPU10 (CoreId 10)...CPU revision is:
000d0001
softlockup thread 10 started up.
SMP: Booting CPU11 (CoreId 11)...CPU revision is:
000d0001
softlockup thread 11 started up.
SMP: Booting CPU12 (CoreId 12)...CPU revision is:
000d0001
softlockup thread 12 started up.
SMP: Booting CPU13 (CoreId 13)...CPU revision is:
000d0001
softlockup thread 13 started up.
SMP: Booting CPU14 (CoreId 14)...CPU revision is:
000d0001
softlockup thread 14 started up.
SMP: Booting CPU15 (CoreId 15)...CPU revision is:
000d0001
Brought up 16 CPUs
softlockup thread 15 started up.
NET: Registered protocol family 16
PCI Status: PCI-X 64-bit
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI dev 13.0 slot 13 pin 1: 11ab:6041 using irq 47
PCI dev 14.0 slot 14 pin 1: 8086:1079 using irq 46
PCI dev 14.1 slot 14 pin 1: 8086:1079 using irq 46
/proc/octeon_perf: Octeon performace counter interface
loaded
Total HugeTLB memory allocated, 0
NTFS driver 2.1.24 [Flags: R/W].
SGI XFS with ACLs, security attributes, large
block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
PCI: Enabling device 0000:00:0e.0 (0000 -> 0003)
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network
Connection
PCI: Enabling device 0000:00:0e.1 (0000 -> 0003)
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network
Connection
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
sata_mv 0000:00:0d.0: version 0.5
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
sata_mv 0000:00:0d.0: 32 slots 4 ports SCSI mode IRQ
via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008022120
bmdma 0x0 irq 47
ata2: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008024120
bmdma 0x0 irq 47
ata3: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008026120
bmdma 0x0 irq 47
ata4: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008028120
bmdma 0x0 irq 47
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: dev 0 ATA, max UDMA/133, 156301488 sectors:
lba48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
  Vendor: ATA       Model: ST380817AS        Rev: 9.01
  Type:   Direct-Access                      ANSI SCSI
revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
 sda:<3>sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
 unknown partition table
Attached scsi disk sda at scsi2, channel 0, id 0, lun
0
physmap flash device: 800000 at 1f400000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 8-bit
bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due
to code brokenness.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
oprofile: using mips/octeon performance monitoring.
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6,
262144 bytes)
TCP established hash table entries: 131072 (order: 9,
2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576
bytes)
TCP: Hash tables configured (established 131072 bind
65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ttyS0 at MMIO 0x1180000000800 (irq = 0) is a 16550A
cf: Octeon bootbus compact flash driver version 1.0
cf: Compact flash found in bootbus region 3 (8 bit).
cfa: SAMSUNG CF/ATA Serial SP3C0231060403000018
(2041200 sectors, 512 bytes/sector)
 cfa: cfa1 cfa2
EXT3-fs: INFO: recovery required on readonly
filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.86 booting
Activating swap.
EXT3 FS on cfa2, internal journal
Cleaning up ifupdown...done.
Calculating module dependencies... done.
Loading modules...
    cavium-ethernet
cavium_ethernet: module license 'Proprietary' taints
kernel.
Octeon ethernet driver version: 1.3.1, build 137
        Interface 0 is RGMII
                eth2: Down   1Gbs Half duplex, port 
0, queue  0
                eth3: Down   1Gbs Half duplex, port 
1, queue  1
                eth4: Down   1Gbs Half duplex, port 
2, queue  2
                eth5: Down   1Gbs Half duplex, port 
3, queue  3
        Interface 1 is SPI4
SPI1: mode Duplex
SPI1: Waiting to see TsClk...
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: CLK_STAT 0x000000000000005C
  s4 (1,0) d4 (1,0)
SPI1: Timeout
All modules loaded.
Checking all file systems...
fsck 1.37 (21-Mar-2005)
Setting kernel variables ...
... done.
Mounting local filesystems...
/dev/cfa1 on /boot type vfat (rw)
Cleaning /tmp /var/run /var/lock.
Running 0dns-down to make sure resolv.conf is
ok...done.
Setting up networking...done.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...Internet Software
Consortium DHCP Client 2.0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet
Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit
http://www.isc.org/dhcp-contrib.html

Listening on LPF/eth0/00:90:fb:81:58:e2
Sending on   LPF/eth0/00:90:fb:81:58:e2
Sending on   Socket/fallback/fallback-net
DHCPDISCOVER on eth0 to 255.255.255.255 port 67
interval 5


DHCPDISCOVER on eth0 to 255.255.255.255 port 67
interval 5
Running ntpdate to synchronize clockError : Temporary
failure in name resolution
.
Initializing random number generator...done.
INIT: Entering runlevel: 2ions...
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting MTA:
exim4.
Starting internet superserver: inetd.

Starting OpenBSD Secure Shell server: sshd.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.

Debian GNU/Linux 3.1 octeon ttyS0

octeon login: root
Last login: Fri Dec 31 16:00:41 1999 on ttyS0
Linux octeon 2.6.14-Cavium-Octeon #34 SMP Wed Jul 5
10:03:44 CDT 2006 mips64 GNU/Linux

The programs included with the Debian GNU/Linux system
are free software;
the exact distribution terms for each program are
described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to
the extent
permitted by applicable law.
octeon:~#
octeon:~#
octeon:~#
octeon:~#
octeon:~#
octeon:~# fdsik /dev/sdb
-bash: fdsik: command not found
octeon:~# fdsik /dev/sda
-bash: fdsik: command not found
octeon:~# fdisk /dev/sda
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
Device contains neither a valid DOS partition table,
nor Sun, SGI or OSF disklabelBuilding a new DOS
disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course,
the previous
content won't be recoverable.


The number of cylinders for this disk is set to 9729.
There is nothing wrong with that, but this is larger
than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions
of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)
Warning: invalid flag 0x0000 of partition table 4 will
be corrected by w(rite)

Command (m for help): p

Disk /dev/sda: 80.0 GB, 80026361856 bytes
255 heads, 63 sectors/track, 9729 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id
 System

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-9729, default 1):
Using default value 1
Last cylinder or +size or +sizeM or +sizeK (1-9729,
default 9729):
Using default value 9729

Command (m for help): wsata_mv: PCI ERROR; PCI IRQ
cause=0x00000400

The partition table has been altered!

Calling ioctl() to re-read partition table.
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
 sda:<3>sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
 unknown partition table
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
 sda:<3>sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
 unknown partition table
Syncing disks.

octeon:~#
octeon:~#
octeon:~# fdisk /dev/sda
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
Device contains neither a valid DOS partition table,
nor Sun, SGI or OSF disklabelBuilding a new DOS
disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course,
the previous
content won't be recoverable.


The number of cylinders for this disk is set to 9729.
There is nothing wrong with that, but this is larger
than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions
of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)
Warning: invalid flag 0x0000 of partition table 4 will
be corrected by w(rite)

Command (m for help): p

Disk /dev/sda: 80.0 GB, 80026361856 bytes
255 heads, 63 sectors/track, 9729 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id
 System



Note: forwarded message attached.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-780421898-1152119543=:64913
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Received: from [69.26.216.147] by web33514.mail.mud.yahoo.com via HTTP; Mon, 03 Jul 2006 12:40:52 PDT
Date: Mon, 3 Jul 2006 12:40:52 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Fwd: Re: sata_mv driver on 88sx6041 ( 2.6.14):DriveReady SeekComplete
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2017456613-1151955652=:821"
Content-Transfer-Encoding: 8bit
Content-Length: 1736

--0-2017456613-1151955652=:821
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,
   I have backported the 0.25 verion of sata_mv.c to
 2.6.14. This the patched version with DMA Boundry
fixes. I need a backport as kernel is supported for
a specific hardware (Cavium Octeon).
 This looks somewaht stable on the hardware as
compared
 to 0.5 and 07 which are very unstable and gets struct
in middle. I can send those logs if needed. Please
note
 that in PIO mode everything looks OK with this setup.
   Apreciate your help.
Thanks,
Narendra
   Here is the log for  0.25 with DMA bounryfixes. I 
few erros are follows 
------------------------------------------------
CSI device sda: drive cache: write back
 sda:<4>ata3: status=0x50 { DriveReady SeekComplete }
ata3: error=0x01 { AddrMarkNotFound }
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
 unknown partition table

---------------------------------------------
Here is log  SCSI messages....
ata_mv 0000:00:0d.0: version 0.25
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
sata_mv 0000:00:0d.0: 32 slots 4 ports SCSI mode IRQ
via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008022120
bmdma 0x0 irq 47
ata2: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008024120
bmdma 0x0 irq 47
ata3: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008026120
bmdma 0x0 irq 47
ata4: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008028120
bmdma 0x0 irq 47
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: dev 0 ATA-7, max UDMA/100, 156301488 sectors:
LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
  Vendor: ATA       Model: HTS721080G9SA00   Rev: MC4O
  Type:   Direct-Access                      ANSI SCSI
revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
 sda:<4>ata3: status=0x50 { DriveReady SeekComplete }
ata3: error=0x01 { AddrMarkNotFound }
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
 unknown partition table
Attached scsi disk sda at scsi2, channel 0, id 0, lun
0
Attached scsi generic sg0 at scsi2, channel 0, id 0,
lun 0,  type 0


Note: forwarded message attached.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2017456613-1151955652=:821
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Received: from [69.26.216.147] by web33514.mail.mud.yahoo.com via HTTP; Thu, 29 Jun 2006 18:09:26 PDT
Date: Thu, 29 Jun 2006 18:09:26 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Re: sata_mv driver on 88sx6041 (kernel version 2.6.14)
To: linux-kernel@vger.kernel.org
Cc: nhadke@yahoo.com
In-Reply-To: <4496B47B.7070602@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Got it working. Thanks.
This works in PIO mode hence performance is horrible.
I see the udma mode is set to 0 in driver 2.6.14
sata_mv version 0.12.  Is is possible to Back port
sata_mv from versin 2.6.17 to 2.6.14 to get a stable
drive. 
   Please let me know.
Thanks,
Narendra 

--- Mark Lord <lkml@rtr.ca> wrote:

> Narendra Hadke wrote:
> > Hi,
> > I am using sata_mv driver as exists in kernel
> 2.6.13,
> > reached to a stage where after detecting the disk,
> > control gets struck. Any ideas? 
> 
> No surprises there.  The sata_mv driver is horribly
> buggy
> in all kernels prior to 2.6.16, and even there it
> still has
> some serious bugs.  The 2.6.17 kernel version is
> MUCH better.
> 
> Cheers
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--0-2017456613-1151955652=:821--

--0-780421898-1152119543=:64913--
