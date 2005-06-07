Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVFGKDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVFGKDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 06:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVFGKDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 06:03:53 -0400
Received: from www.x-cellent.com ([212.121.145.100]:9416 "EHLO
	mail.x-cellent.com") by vger.kernel.org with ESMTP id S261820AbVFGKD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 06:03:29 -0400
Message-ID: <61988.212.34.68.5.1118138597.squirrel@212.34.68.5>
In-Reply-To: <1115657098.2128.6.camel@dom2>
References: <1115657098.2128.6.camel@dom2>
Date: Tue, 7 Jun 2005 12:03:17 +0200 (CEST)
Subject: 2.6.12-rc5 Kernel OOPS 
From: "Stefan Majer" <stefan@x-cellent.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i had the following OOPS last night.
I had the same OOPS even with 2.6.11.7 see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111566098400626&w=2

I can easily try every patch you want.
I start compiling -rc6 now.

please cc me directly because im not subscribed.


Unable to handle kernel paging request at virtual address ffffffff
Unable to handle kernel paging request at virtual address ffffffff
 printing eip:
c01318f8
*pde = 00001067
c01318f8
*pde = 00001067
*pte = 00000000
Oops: 0000 [#1]
Oops: 0000 [#1]
Modules linked in: aic7xxx scsi_transport_spi
CPU:    0
EIP:    0060:[<c01318f8>]    Not tainted VLI
CPU:    0
EIP:    0060:[<c01318f8>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.12-rc5)
EIP is at test_clear_page_writeback+0x98/0xd0
eax: 00000004   ebx: cf4aa6dc   ecx: 00000086   edx: ffffffff
EFLAGS: 00010286   (2.6.12-rc5)
eax: 00000004   ebx: cf4aa6dc   ecx: 00000086   edx: ffffffff
esi: ffffffff   edi: c10108c0   ebp: 00000282   esp: cf6bfd24
esi: ffffffff   edi: c10108c0   ebp: 00000282   esp: cf6bfd24
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 53, threadinfo=cf6be000 task=c1274060)
Stack: 00000004 ffffffff 00000282 c10108c0 c61dffbc c61dffbc 00000000
c012b7e9
       c10108c0 c61dffbc c01895cb c10108c0 c10108c0 c0347390 00000001
c1359e00
       00000000 00000000 cf4aa63c cf6bfd9c 00000212 00000246 00000034
00000000
Call Trace:
ds: 007b   es: 007b   ss: 0068
Stack: 00000004 ffffffff 00000282 c10108c0 c61dffbc c61dffbc 00000000
c012b7e9
       c10108c0 c61dffbc c01895cb c10108c0 c10108c0 c0347390 00000001
c1359e00
       00000000 00000000 cf4aa63c cf6bfd9c 00000212 00000246 00000034
00000000
Call Trace:
 [<c012b7e9>] end_page_writeback+0x29/0x50
 [<c01895cb>] reiserfs_write_full_page+0x1db/0x410
 [<c0189846>] reiserfs_writepage+0x26/0x40
 [<c0135773>] pageout+0xb3/0x140
 [<c012afa4>] __remove_from_page_cache+0x24/0x50
 [<c01359e2>] shrink_list+0x1e2/0x3e0
 [<c0135d90>] shrink_cache+0x100/0x270
 [<c0130dc3>] get_writeback_state+0x43/0x50
 [<c0130de8>] get_dirty_limits+0x18/0xd0
 [<c01354ca>] shrink_slab+0x8a/0x190
 [<c013633d>] shrink_zone+0xad/0xe0
 [<c0136824>] balance_pgdat+0x294/0x380
 [<c01369e6>] kswapd+0xd6/0xf0
 [<c01231a0>] autoremove_wake_function+0x0/0x60
 [<c012b7e9>] end_page_writeback+0x29/0x50
 [<c01895cb>] reiserfs_write_full_page+0x1db/0x410
 [<c0189846>] reiserfs_writepage+0x26/0x40
 [<c0135773>] pageout+0xb3/0x140
 [<c012afa4>] __remove_from_page_cache+0x24/0x50
 [<c01359e2>] shrink_list+0x1e2/0x3e0
 [<c0135d90>] shrink_cache+0x100/0x270
 [<c0130dc3>] get_writeback_state+0x43/0x50
 [<c0130de8>] get_dirty_limits+0x18/0xd0
 [<c01354ca>] shrink_slab+0x8a/0x190
 [<c013633d>] shrink_zone+0xad/0xe0
 [<c0136824>] balance_pgdat+0x294/0x380
 [<c01369e6>] kswapd+0xd6/0xf0
 [<c01231a0>] autoremove_wake_function+0x0/0x60
 [<c01231a0>] autoremove_wake_function+0x0/0x60
 [<c0136910>] kswapd+0x0/0xf0
 [<c0100da5>] kernel_thread_helper+0x5/0x10
Code: 0c 8b 7c 24 14 8b 74 24 10 8b 6c 24 18 83 c4 1c c3 8b 47 0c eb cc c7
44 24 04 ff ff ff ff c7 04 24 04 00 00 00 e8 49 eb ff ff eb <a6> 8d b4 26
00 00 00 00 0f ba 37 0d 19 db 85 db 75 04 89 de eb
 [<c01231a0>] autoremove_wake_function+0x0/0x60
 [<c0136910>] kswapd+0x0/0xf0
 [<c0100da5>] kernel_thread_helper+0x5/0x10
Code: 0c 8b 7c 24 14 8b 74 24 10 8b 6c 24 18 83 c4 1c c3 8b 47 0c eb cc c7
44 24 04 ff ff ff ff c7 04 24 04 00 00 00 e8 49 eb ff ff eb <a6> 8d b4 26
00 00 00 00 0f ba 37 0d 19 db 85 db 75 04 89 de eb


>>EIP; c01318f8 <__pagevec_lru_add_active+98/b0>   <=====

>>ebx; cf4aa6dc <pg0+f0cc6dc/3fc20400>
>>edx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>esi; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>edi; c10108c0 <pg0+c328c0/3fc20400>
>>esp; cf6bfd24 <pg0+f2e1d24/3fc20400>

Trace; c012b7e9 <out_of_memory+19/b0>
Trace; c01895cb <get_neighbors+4b/150>
Trace; c0189846 <wait_tb_buffers_until_unlocked+6/340>
Trace; c0135773 <do_wp_page+203/2a0>
Trace; c012afa4 <.text.lock.filemap+d/69>
Trace; c01359e2 <vmtruncate+42/120>
Trace; c0135d90 <do_swap_page+230/240>
Trace; c0130dc3 <s_start+13/c0>
Trace; c0130de8 <s_start+38/c0>
Trace; c01354ca <remap_page_range+10a/1b0>
Trace; c013633d <handle_mm_fault+9d/140>
Trace; c0136824 <.text.lock.mincore+29/45>
Trace; c01369e6 <sys_mlock+16/f0>
Trace; c01231a0 <clock_nanosleep_restart+50/71>
Trace; c01231a0 <clock_nanosleep_restart+50/71>
Trace; c0136910 <do_mlock+0/c0>
Trace; c0100da5 <inflate_codes+475/4a0>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01318cd <__pagevec_lru_add_active+6d/b0>
00000000 <_EIP>:
Code;  c01318cd <__pagevec_lru_add_active+6d/b0>
   0:   0c 8b                     or     $0x8b,%al
Code;  c01318cf <__pagevec_lru_add_active+6f/b0>
   2:   7c 24                     jl     28 <_EIP+0x28>
Code;  c01318d1 <__pagevec_lru_add_active+71/b0>
   4:   14 8b                     adc    $0x8b,%al
Code;  c01318d3 <__pagevec_lru_add_active+73/b0>
   6:   74 24                     je     2c <_EIP+0x2c>
Code;  c01318d5 <__pagevec_lru_add_active+75/b0>
   8:   10 8b 6c 24 18 83         adc    %cl,0x8318246c(%ebx)
Code;  c01318db <__pagevec_lru_add_active+7b/b0>
   e:   c4 1c c3                  les    (%ebx,%eax,8),%ebx
Code;  c01318de <__pagevec_lru_add_active+7e/b0>
  11:   8b 47 0c                  mov    0xc(%edi),%eax
Code;  c01318e1 <__pagevec_lru_add_active+81/b0>
  14:   eb cc                     jmp    ffffffe2 <_EIP+0xffffffe2>
Code;  c01318e3 <__pagevec_lru_add_active+83/b0>
  16:   c7 44 24 04 ff ff ff      movl   $0xffffffff,0x4(%esp)
Code;  c01318ea <__pagevec_lru_add_active+8a/b0>
  1d:   ff
Code;  c01318eb <__pagevec_lru_add_active+8b/b0>
  1e:   c7 04 24 04 00 00 00      movl   $0x4,(%esp)
Code;  c01318f2 <__pagevec_lru_add_active+92/b0>
  25:   e8 49 eb ff ff            call   ffffeb73 <_EIP+0xffffeb73>
Code;  c01318f7 <__pagevec_lru_add_active+97/b0>
  2a:   eb                        .byte 0xeb

This decode from eip onwards should be reliable

Code;  c01318f8 <__pagevec_lru_add_active+98/b0>
00000000 <_EIP>:
Code;  c01318f8 <__pagevec_lru_add_active+98/b0>   <=====
   0:   a6                        cmpsb  %es:(%edi),%ds:(%esi)   <=====
Code;  c01318f9 <__pagevec_lru_add_active+99/b0>
   1:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c0131900 <__pagevec_lru_add_active+a0/b0>
   8:   0f ba 37 0d               btrl   $0xd,(%edi)
Code;  c0131904 <__pagevec_lru_add_active+a4/b0>
   c:   19 db                     sbb    %ebx,%ebx
Code;  c0131906 <__pagevec_lru_add_active+a6/b0>
   e:   85 db                     test   %ebx,%ebx
Code;  c0131908 <__pagevec_lru_add_active+a8/b0>
  10:   75 04                     jne    16 <_EIP+0x16>
Code;  c013190a <__pagevec_lru_add_active+aa/b0>
  12:   89 de                     mov    %ebx,%esi
Code;  c013190c <__pagevec_lru_add_active+ac/b0>
  14:   eb                        .byte 0xeb

Details as follows:

Linux castor 2.6.12-rc5 #1 Thu Jun 2 14:03:05 CEST 2005 i686 AMD Duron(tm)
AuthenticAMD GNU/Linux

Gnu C                  3.3.5-20050130
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   056
Modules Loaded         aic7xxx scsi_transport_spi

Linux version 2.6.12-rc5 (root@castor) (gcc version 3.3.5-20050130 (Gentoo
3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #1 Thu Jun 2
14:03:05 CEST
2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f8000 (ACPI data)
 BIOS-e820: 000000000f7f8000 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59376 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Allocating PCI resources starting at 0f800000 (gap: 0f800000:ef400000)
Built 1 zonelists
Kernel command line: root=/dev/hda3
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1297.930 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 248008k/253888k available (1966k kernel code, 5304k reserved, 841k
data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2539.52 BogoMIPS (lpj=1269760)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdae1, last bus=1
PCI: Using configuration type 1
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
Boot video device is 0000:01:00.0
PCI: Using IRQ router default [1106/3177] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:11.1 doesn't match PIRQ mask - try
pci=usepirqmask
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:39:99:AE, IRQ 5.
  Board assembly 734938-005, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
eth1: VIA Rhine II at 0xdfff9f00, 00:0b:6a:07:34:bd, IRQ 11.
eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller at PCI slot 0000:00:09.0
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0xdffe0000
PDC20268: 100% native mode on irq 10
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: IC35L120AVV207-0, ATA DISK drive
hdf: IC35L120AVV207-0, ATA DISK drive
ide2 at 0xec00-0xec07,0xe802 on irq 10
Probing IDE interface ide3...
hdg: IC35L120AVV207-0, ATA DISK drive
ide3 at 0xe400-0xe407,0xe002 on irq 10
VP_IDE: IDE controller at PCI slot 0000:00:11.1
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST320423A, ATA DISK drive
hdb: SAMSUNG SP1213N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG SP1213N, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide4...
Probing IDE interface ide5...
hde: max request size: 1024KiB
hde: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63,
UDMA(100)
hde: cache flushes supported
 /dev/ide/host2/bus0/target0/lun0: unknown partition table
hdf: max request size: 1024KiB
hdf: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63,
UDMA(100)
hdf: cache flushes supported
 /dev/ide/host2/bus0/target1/lun0: unknown partition table
hdg: max request size: 1024KiB
hdg: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63,
UDMA(100)
hdg: cache flushes supported
 /dev/ide/host2/bus1/target0/lun0: unknown partition table
hda: max request size: 128KiB
hda: 40011300 sectors (20485 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(33)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdb: max request size: 1024KiB
hdb: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(33)
hdb: cache flushes supported
 /dev/ide/host0/bus0/target1/lun0: unknown partition table
hdc: max request size: 1024KiB
hdc: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100)
hdc: cache flushes supported
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
st: Version 20050312, fixed bufsize 32768, s/g segs 256
mice: PS/2 mouse device common for all mice
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1304.000 MB/sec
raid5: using function: pIII_sse (1304.000 MB/sec)
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max trans
age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 140k freed
Adding 1005472k swap on /dev/hda2.  Priority:-1 extents:1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: BNCHMARK  Model: DLT1              Rev: 391B
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target0:0:3: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:3): 6.600MB/s transfers (16bit)
 target0:0:3: Domain Validation skipping write tests
(scsi0:A:3): 20.000MB/s transfers (10.000MHz, offset 15, 16bit)
 target0:0:3: Ending Domain Validation
Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
md: raidstart(pid 5455) used deprecated START_ARRAY ioctl. This will not
be supported beyond 2.6
md: autorun ...
md: considering hdg ...
md:  adding hdg ...
md:  adding hdf ...
md:  adding hde ...
md:  adding hdc ...
md:  adding hdb ...
md: created md0
md: bind<hdb>
md: bind<hdc>
md: bind<hde>
md: bind<hdf>
md: bind<hdg>
md: running: <hdg><hdf><hde><hdc><hdb>
raid5: device hdg operational as raid disk 4
raid5: device hdf operational as raid disk 3
raid5: device hde operational as raid disk 2
raid5: device hdc operational as raid disk 1
raid5: device hdb operational as raid disk 0
raid5: allocated 5240kB for md0
raid5: raid level 5 set md0 active with 5 out of 5 devices, algorithm 2
RAID5 conf printout:
 --- rd:5 wd:5 fd:0
 disk 0, o:1, dev:hdb
 disk 1, o:1, dev:hdc
 disk 2, o:1, dev:hde
 disk 3, o:1, dev:hdf
 disk 4, o:1, dev:hdg
md: ... autorun DONE.
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max trans
age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
ReiserFS: md0: found reiserfs format "3.6" with standard journal
spurious 8259A interrupt: IRQ7.
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
st0: Block limits 2 - 16777214 bytes.
nfs warning: mount version older than kernel
eth0: TX underrun, threshold adjusted.
eth0: TX underrun, threshold adjusted.
eth0: TX underrun, threshold adjusted.
eth0: TX underrun, threshold adjusted.
eth0: TX underrun, threshold adjusted.
eth0: TX underrun, threshold adjusted.



Greetings from Munich

Stefan Majer
