Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272219AbRIEQsZ>; Wed, 5 Sep 2001 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272225AbRIEQsQ>; Wed, 5 Sep 2001 12:48:16 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:6979 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S272219AbRIEQsA>;
	Wed, 5 Sep 2001 12:48:00 -0400
Message-ID: <3B965749.E4B9AAA9@strike.wu-wien.ac.at>
Date: Wed, 05 Sep 2001 18:48:09 +0200
From: Hermann Himmelbauer <dusty@strike.wu-wien.ac.at>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: de-AT, de-DE, de, de-CH, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic with 2.4.6/2.4.9/2.4.9-ac7
Content-Type: multipart/mixed;
 boundary="------------0819FA9CF5D90A41E841192C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------0819FA9CF5D90A41E841192C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
Today I installed SuSE 7.2 (with kernel 2.4.4-4GB included with SuSE).
After the installation I decided to compile my own kernel like I always
do.

First I tried 2.4.9, afterwards 2.4.9-ac7 and at last 2.4.6, all with
the same result: Either the boot process simply stops somewhere in the
middle or there is a kernel panic. So I took 2.4.9-ac7 and removed
everything "Experimental" from it, including IDE-DMA, AGP etc. This time
I could boot to the prompt but when X came up, it crashed and triggered
a kernel Ooops. This time I could save the dmesg. BTW, 2.2.19 also works
properly.

My System is a AMD Thunderbird with a Via82C686 Chipset, 256MB Ram
(tested with memtestx86, no errors), a DPT PM1554U2 controller (but same
behavior without compiling this into the kernel) and Reiserfs on my root
partition (hda2), so no exotic hardware.

The kernel Oops looks like this:
------------------- snip -----------------
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len
2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len
2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
VM: refill_inactive, wrong page on list.
Unable to handle kernel paging request at virtual address 0d696910
 printing eip:
c0125f0f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0125f0f>]
EFLAGS: 00010282
eax: c025a360   ebx: c105a004   ecx: c1476000   edx: 0d696910
esi: c105a020   edi: 00000011   ebp: 00000000   esp: c1477fc8
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1477000)
Stack: c1476000 c01e2f27 c1476239 0008e000 c01e2f27 c012632d 00000006
00010f00
       cffe7fb8 00000000 c01054c8 00000000 00000078 c0219fd4
Call Trace: [<c012632d>] [<c01054c8>]
 
Code: 89 02 ff 0d 58 a3 25 c0 e9 45 01 00 00 8d 74 26 00 8b 43 40
----------------------- end ---------------------------

I simply attach the whole "dmesg" to this mail - perhaps this makes
things clearer...

Does anyone have a clue what to do? Should I try 2.4.4?
Please contact me if you need any further information.

		Best Regards,
		Hermann

-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
--------------0819FA9CF5D90A41E841192C
Content-Type: text/plain; charset=us-ascii;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Linux version 2.4.9-ac7 (root@capella) (gcc version 2.95.3 20010315 (SuSE)) #1 Wed Sep 5 18:24:05 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/bzImage-2.4.9
Initializing CPU#0
Detected 1195.247 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2385.51 BogoMIPS
Memory: 255800k/262080k available (885k kernel code, 5892k reserved, 232k data, 176k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb160, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169941kB/56647kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: IBM-DJNA-371350, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 26520480 sectors (13578 MB) w/1966KiB Cache, CHS=1650/255/63
Partition check:
 hda: hda1 hda2
SCSI subsystem driver Revision: 1.00
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
PCI: Found IRQ 5 for device 00:09.1
IRQ routing conflict for 00:07.5, have irq 11, want irq 5
Adaptec I2O RAID controller 0 at d0800000 size=100000 irq=5
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: SYMBIOS      Device: SYM53C895    Rev: 00000001    
TID 517  Vendor: DPT          Device: RAID-1       Rev: 2047        
scsi0 : Vendor: Adaptec  Model: PM1554U2         FW:2047
  Vendor: DPT       Model: RAID-1            Rev: 2047
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
SCSI device sda: 8923904 512-byte hdwr sectors (4569 MB)
 sda: sda1 sda2 sda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding Swap: 530104k swap-space (priority 42)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 15 for device 00:0c.0
PCI: Sharing IRQ 15 with 00:08.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00. Vers LK1.1.16
memory.c:84: bad pmd c1432244.
memory.c:84: bad pmd c14321bc.
memory.c:84: bad pmd c1576d38.
memory.c:84: bad pmd 0000001e.
memory.c:84: bad pmd 00000005.
memory.c:84: bad pmd 0000004c.
memory.c:84: bad pmd c1432260.
memory.c:84: bad pmd c14321d8.
memory.c:84: bad pmd 00000002.
memory.c:84: bad pmd c1432020.
memory.c:84: bad pmd c1430000.
memory.c:84: bad pmd cff42000.
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [7727 7869 0x0 SD]
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [7727 7882 0x0 SD]
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [7727 7918 0x0 SD]
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [7727 7919 0x0 SD]
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [7727 7728 0x0 SD]
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat data of [7727 7731 0x0 SD]
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
is_leaf: item location seems wrong: *OLD*[7727 7728 0x0 SD], item_len 2059, item_location 0, free_space(entry_count) 57024
vs-5150: search_by_key: invalid format found in block 8980. Fsck?
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
VM: refill_inactive, wrong page on list.
Unable to handle kernel paging request at virtual address 0d696910
 printing eip:
c0125f0f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0125f0f>]
EFLAGS: 00010282
eax: c025a360   ebx: c105a004   ecx: c1476000   edx: 0d696910
esi: c105a020   edi: 00000011   ebp: 00000000   esp: c1477fc8
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1477000)
Stack: c1476000 c01e2f27 c1476239 0008e000 c01e2f27 c012632d 00000006 00010f00 
       cffe7fb8 00000000 c01054c8 00000000 00000078 c0219fd4 
Call Trace: [<c012632d>] [<c01054c8>] 

Code: 89 02 ff 0d 58 a3 25 c0 e9 45 01 00 00 8d 74 26 00 8b 43 40 
 

--------------0819FA9CF5D90A41E841192C--

