Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317397AbSGTIJE>; Sat, 20 Jul 2002 04:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSGTIJE>; Sat, 20 Jul 2002 04:09:04 -0400
Received: from terra.planetarium.com.br ([200.196.32.31]:64004 "HELO
	terra.planetarium.com.br") by vger.kernel.org with SMTP
	id <S317397AbSGTIJC>; Sat, 20 Jul 2002 04:09:02 -0400
Message-ID: <3D391A54.4020404@planetarium.com.br>
Date: Sat, 20 Jul 2002 05:07:48 -0300
From: Leonardo Gomes Figueira <sabbath@planetarium.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: pt-br, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory detection problem in 2.4.19-rc2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have a Toshiba K6-2 450 notebook with 32MB RAM onboard plus an 256MB chip.

I use kernel 2.4.18 with the mem param on the boot (mem=288M) and it 
works fine. (Without the mem param it only detects 32MB).

I've been testing 2.4.19-preX (8,9,10 maybe others before, i don't 
remember) and 2.4.19-rcX (1,2) but in this releases it don't detect more 
than 32MB even with the mem param. I didn't test in 2.4.19-rc3 yet but i 
read the changelog and didn't see any change in this area but i can test 
if it helps.

The kernel configuration is the same from 2.4.18, i didn't see any 
option related to this issue there. I tried lower values to mem param 
like mem=256M or mem=64MB but it failed too.

The dmesg from 2.4.18 and 2.4.19-rc2 are in the end of this message, if 
anyone has an solution or needs more information please send an CC to my 
email, I'm not subscribed to the list.

Thanks,

    Leo


  Leonardo Gomes Figueira
  sabbath@planetarium.com.br


dmesg - 2.4.18

Linux version 2.4.18 (root@satellite) (gcc version 2.96 20000731 (Red 
Hat Linux 7.1 2.96-98)) #2 Sun Jun 30 03:26:36 BRT 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ed400 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
  BIOS-e820: 0000000011ff0000 - 0000000011fffc00 (ACPI data)
  BIOS-e820: 0000000011fffc00 - 0000000012000000 (ACPI NVS)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 73728
zone(0): 4096 pages.
zone(1): 69632 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.18 ro root=305 mem=288M
Initializing CPU#0
Detected 448.472 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 288420k/294912k available (867k kernel code, 6104k reserved, 
204k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfd8ce, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 01:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try 
using pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: simplex device:  DMA disabled
ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
ALI15X3: simplex device:  DMA disabled
ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
hda: FUJITSU MHM2100AT, ATA DISK drive
hdc: SR242S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/2048KiB Cache, CHS=1222/255/63
Partition check:
  hda: hda1 hda2 < hda5 hda6 > hda3 hda4
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Real Time Clock Driver v1.10e
Adding Swap: 128484k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal

dmesg - 2.4.19-rc2

Linux version 2.4.19-rc2 (root@satellite) (gcc version 2.96 20000731 
(Red Hat Linux 7.1 2.96-98)) #3 Wed Jul 17 14:21:05 BRT 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ed400 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
  BIOS-e820: 0000000011ff0000 - 0000000011fffc00 (ACPI data)
  BIOS-e820: 0000000011fffc00 - 0000000012000000 (ACPI NVS)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
  user: 0000000000000000 - 000000000009f800 (usable)
  user: 000000000009f800 - 00000000000a0000 (reserved)
  user: 00000000000ed400 - 0000000000100000 (reserved)
  user: 0000000000100000 - 0000000002000000 (usable)
  user: 0000000011ff0000 - 0000000011fffc00 (ACPI data)
  user: 0000000011fffc00 - 0000000012000000 (ACPI NVS)
  user: 00000000fffc0000 - 0000000100000000 (reserved)
32MB LOWMEM available.
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.19-rc2 ro root=305 mem=288M
Initializing CPU#0
Detected 448.474 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 30544k/32768k available (879k kernel code, 1836k reserved, 203k 
data, 196k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfd8ce, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 9 for device 00:04.1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
ALI15X3: detected chipset, but driver not compiled in!
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHM2100AT, ATA DISK drive
hdc: SR242S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/2048KiB Cache, CHS=1222/255/63, UDMA(33)
Partition check:
  hda: hda1 hda2 < hda5 hda6 > hda3 hda4
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Real Time Clock Driver v1.10e
Adding Swap: 128484k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal



