Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSE2N4R>; Wed, 29 May 2002 09:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSE2N4Q>; Wed, 29 May 2002 09:56:16 -0400
Received: from topbg-gw.peers.Sofia.0rbitel.net ([212.95.178.150]:780 "HELO
	ns.unixsol.bg") by vger.kernel.org with SMTP id <S315278AbSE2Nz7>;
	Wed, 29 May 2002 09:55:59 -0400
Message-ID: <3CF4DDEE.5070704@unixsol.org>
Date: Wed, 29 May 2002 16:55:58 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020517
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 oopses (filesystem related)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you need more information, I'll be happy to supply it.

/proc/version
-------------
Linux version 2.4.18 (root@player) (gcc version 2.95.3 20010315 (release)) #1 Sun May 5 06:13:51 EEST 2002

lsmod
-----
Module                  Size  Used by    Not tainted
stradis                31136   1
videodev                2912   3  [stradis]

mount
-----
/dev/hda1 on / type ext3 (rw)
/dev/hda3 on /home type ext3 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)

dmesg
-----
Linux version 2.4.18 (root@player) (gcc version 2.95.3 20010315 (release)) #1 Sun May 5 06:13:51 EEST 2002
BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
   BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
   BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
   BIOS-e820: 0000000000100000 - 000000001fec0000 (usable)
   BIOS-e820: 000000001fec0000 - 000000001fef8000 (ACPI data)
   BIOS-e820: 000000001fef8000 - 000000001ff00000 (ACPI NVS)
   BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
   BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
On node 0 totalpages: 130752
zone(0): 4096 pages.
zone(1): 126656 pages.
zone(2): 0 pages.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=linux ro root=301
Initializing CPU#0
Detected 996.333 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1985.74 BogoMIPS
Memory: 512716k/523008k available (972k kernel code, 9904k reserved, 302k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(TM) CPU                1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 996.2971 MHz.
..... host bus clock speed is 99.6296 MHz.
cpu: 0, clocks: 996296, slice: 498148
CPU0<T0:996288,T1:498128,D:12,S:498148,C:996296>
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 17
PIIX4: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: ST380021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
Partition check:
  hda: hda1 hda2 hda3
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 01:08.0
eth0: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller, 00:03:47:CC:E7:9B, IRQ 10.
   Board assembly 000000-000, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Adding Swap: 265064k swap-space (priority -1)
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux video capture interface: v1.00
stradis0: SDM2xx found
PCI: Found IRQ 3 for device 01:0d.0
stradis1: SDM2xx found
PCI: Found IRQ 15 for device 01:0c.0
PCI: Sharing IRQ 15 with 00:1f.3
stradis: 2 card(s) found.
i2c setup read timeout
i2c read timeout
stradis0: config = 00 01 04 13 26 0f 10 00 01 ba 53 02 03 01 38 0e 8e 00 0b 00 00 00 00 00 00 00 00 00 00 01 00 cc a4 6c 09 eb 10 00 0a 00 02 02 64 65 63 78 6c 61 00 00 42
i2c setup read timeout
i2c read timeout
stradis1: config = 00 01 04 13 26 0f 10 00 01 d3 53 02 03 01 30 0f 15 00 0b 00 00 00 00 00 00 00 00 00 00 01 00 cc a4 55 09 d4 10 00 0a 00 02 02 64 65 63 78 6c 61 00 00 42
i2c setup read timeout
i2c read timeout
stradis0: loading decxla
stradis0: FPGA Loaded
wait-for-debi-done maxwait: 1926
stradis0: CS4341 initialized (0)
stradis1: loading decxla
stradis1: FPGA Loaded
stradis1: CS4341 initialized (0)
stradis0: IBM MPEGCD21 Initialized
stradis1: IBM MPEGCD21 Initialized

oopses
------
May 28 09:26:36 player kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
May 28 09:26:36 player kernel:  printing eip:
May 28 09:26:36 player kernel: c015712d
May 28 09:26:36 player kernel: *pde = 00000000
May 28 09:26:36 player kernel: Oops: 0000
May 28 09:26:36 player kernel: CPU:    0
May 28 09:26:36 player kernel: EIP:    0010:[__journal_remove_journal_head+9/216]    Not tainted
May 28 09:26:36 player kernel: EFLAGS: 00010296
May 28 09:26:36 player kernel: eax: 00000001   ebx: 00000000   ecx: dc812300   edx: d8f9a6a0
May 28 09:26:36 player kernel: esi: d8f9a6a0   edi: d4aeeec0   ebp: c6282820   esp: dfa91e78
May 28 09:26:36 player kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:26:36 player kernel: Process kjournald (pid: 20, stackpage=dfa91000)
May 28 09:26:36 player kernel: Stack: d8f9a6a0 c6282850 c015354a d8f9a6a0 c6282850 d41a2050 d41a2000 d41a2000
May 28 09:26:36 player kernel:        00000000 00000000 ddc7a280 d1d4c420 d41a2094 d41a2050 00000000 00000000
May 28 09:26:36 player kernel:        00000000 00000000 d5e42220 c2515e20 00000303 d05058c0 cfdee5a0 cfd1de60
May 28 09:26:36 player kernel: Call Trace: [journal_commit_transaction+586/3543] [schedule+692/732] [kjournald+267/412] [commit_timeout+0/12] [kernel_thread+40/56]
May 28 09:26:36 player kernel:
May 28 09:26:36 player kernel: Code: 83 7b 04 00 7d 23 68 9d 21 20 c0 68 bc 06 00 00 68 31 19 20

May 29 14:59:11 player kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 14:59:11 player kernel:  printing eip:
May 29 14:59:11 player kernel: c01204f7
May 29 14:59:11 player kernel: *pde = 00000000
May 29 14:59:11 player kernel: Oops: 0000
May 29 14:59:11 player kernel: CPU:    0
May 29 14:59:11 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 14:59:11 player kernel: EFLAGS: 00010282
May 29 14:59:11 player kernel: eax: fffffffe   ebx: d3783d40   ecx: 00000011   edx: 0000608e
May 29 14:59:11 player kernel: esi: d38b4890   edi: 000002fc   ebp: c1898238   esp: cf9aff00
May 29 14:59:11 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 14:59:11 player kernel: Process playtv.pl (pid: 221, stackpage=cf9af000)
May 29 14:59:11 player kernel: Stack: d3783d40 00000020 000002dc 00000020 d3783d40 c0120a95 c12d29c0 c189813c
May 29 14:59:11 player kernel:        d38b4890 000002bd 0000001f 00000bb1 c0120ca2 00000001 d3783d40 d38b47e0
May 29 14:59:11 player kernel:        c12d29c0 00000000 d3783d40 ffffffea 00008000 00001000 00000001 00000000
May 29 14:59:11 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 14:59:11 player kernel:    [system_call+51/56]
May 29 14:59:11 player kernel:
May 29 14:59:11 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 14:59:20 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 14:59:20 player kernel:  printing eip:
May 29 14:59:20 player kernel: c0120c6b
May 29 14:59:20 player kernel: *pde = 00000000
May 29 14:59:20 player kernel: Oops: 0000
May 29 14:59:20 player kernel: CPU:    0
May 29 14:59:20 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 14:59:20 player kernel: EFLAGS: 00010282
May 29 14:59:20 player kernel: eax: fffffffe   ebx: c10730c0   ecx: 00000011   edx: 0000608e
May 29 14:59:20 player kernel: esi: c1898238   edi: d38b4890   ebp: 000002fc   esp: ca655f44
May 29 14:59:20 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 14:59:20 player kernel: Process playtv.pl (pid: 17750, stackpage=ca655000)
May 29 14:59:20 player kernel: Stack: 00000000 d3783c40 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 14:59:20 player kernel:        d38b47e0 c01211b5 d3783c40 d3783c60 ca655f8c c01210dc 00000000 d3783c40
May 29 14:59:20 player kernel:        ffffffea 00008000 00004000 00004000 08154c90 00000000 c012bf86 d3783c40
May 29 14:59:20 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 14:59:20 player kernel:
May 29 14:59:20 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 15:05:00 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:05:00 player kernel:  printing eip:
May 29 15:05:00 player kernel: c01204f7
May 29 15:05:00 player kernel: *pde = 00000000
May 29 15:05:00 player kernel: Oops: 0000
May 29 15:05:00 player kernel: CPU:    0
May 29 15:05:00 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 15:05:00 player kernel: EFLAGS: 00010282
May 29 15:05:00 player kernel: eax: fffffffe   ebx: cc5414a0   ecx: 00000011   edx: 0000608e
May 29 15:05:00 player kernel: esi: d1450190   edi: 0000353d   ebp: c1898238   esp: c9d6df00
May 29 15:05:00 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:05:00 player kernel: Process playtv.pl (pid: 17764, stackpage=c9d6d000)
May 29 15:05:00 player kernel: Stack: cc5414a0 00000001 0000353c 00000020 cc5414a0 c0120a95 c168f580 c18981b8
May 29 15:05:00 player kernel:        d1450190 0000351d 0000001f 0000c800 c0120ca2 00000001 cc5414a0 d14500e0
May 29 15:05:00 player kernel:        c168f580 00000000 cc5414a0 ffffffea 00008000 00001000 00000001 00000000
May 29 15:05:00 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 15:05:00 player kernel:    [system_call+51/56]
May 29 15:05:00 player kernel:
May 29 15:05:00 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 15:09:17 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:09:17 player kernel:  printing eip:
May 29 15:09:17 player kernel: c01204f7
May 29 15:09:17 player kernel: *pde = 00000000
May 29 15:09:17 player kernel: Oops: 0000
May 29 15:09:17 player kernel: CPU:    0
May 29 15:09:17 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 15:09:17 player kernel: EFLAGS: 00010282
May 29 15:09:17 player kernel: eax: fffffffe   ebx: cca3dc40   ecx: 00000011   edx: 0000608e
May 29 15:09:17 player kernel: esi: d3c50190   edi: 00003533   ebp: c1898238   esp: ded4ff00
May 29 15:09:17 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:09:17 player kernel: Process playtv.pl (pid: 17946, stackpage=ded4f000)
May 29 15:09:17 player kernel: Stack: cca3dc40 00000017 0000351c 00000020 cca3dc40 c0120a95 c1271640 c1898160
May 29 15:09:17 player kernel:        d3c50190 000034fd 0000001f 0000c800 c0120ca2 00000001 cca3dc40 d3c500e0
May 29 15:09:17 player kernel:        c1271640 00000000 cca3dc40 ffffffea 00008000 00001000 00000001 00000000
May 29 15:09:17 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 15:09:17 player kernel:    [system_call+51/56]
May 29 15:09:17 player kernel:
May 29 15:09:17 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 15:13:43 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:13:43 player kernel:  printing eip:
May 29 15:13:43 player kernel: c01204f7
May 29 15:13:43 player kernel: *pde = 00000000
May 29 15:13:43 player kernel: Oops: 0000
May 29 15:13:43 player kernel: CPU:    0
May 29 15:13:43 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 15:13:43 player kernel: EFLAGS: 00010282
May 29 15:13:43 player kernel: eax: fffffffe   ebx: cc541f20   ecx: 00000011   edx: 0000608e
May 29 15:13:43 player kernel: esi: d3c50370   edi: 00003524   ebp: c1898238   esp: cb765f00
May 29 15:13:43 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:13:43 player kernel: Process playtv.pl (pid: 18088, stackpage=cb765000)
May 29 15:13:43 player kernel: Stack: cc541f20 00000008 0000351c 00000020 cc541f20 c0120a95 c13b8fc0 c189819c
May 29 15:13:43 player kernel:        d3c50370 000034fd 0000001f 0000c800 c0120ca2 00000001 cc541f20 d3c502c0
May 29 15:13:43 player kernel:        c13b8fc0 00000000 cc541f20 ffffffea 00008000 00001000 00000001 00000000
May 29 15:13:43 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 15:13:43 player kernel:    [system_call+51/56]
May 29 15:13:43 player kernel:
May 29 15:13:43 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 15:18:07 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:18:07 player kernel:  printing eip:
May 29 15:18:07 player kernel: c01204f7
May 29 15:18:07 player kernel: *pde = 00000000
May 29 15:18:07 player kernel: Oops: 0000
May 29 15:18:07 player kernel: CPU:    0
May 29 15:18:07 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 15:18:07 player kernel: EFLAGS: 00010282
May 29 15:18:07 player kernel: eax: fffffffe   ebx: cca3d4c0   ecx: 00000011   edx: 0000608e
May 29 15:18:07 player kernel: esi: d3c50550   edi: 00003515   ebp: c1898238   esp: c9d6df00
May 29 15:18:07 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:18:07 player kernel: Process playtv.pl (pid: 18238, stackpage=c9d6d000)
May 29 15:18:07 player kernel: Stack: cca3d4c0 00000019 000034fc 00000020 cca3d4c0 c0120a95 c1333900 c1898158
May 29 15:18:07 player kernel:        d3c50550 000034dd 0000001f 0000c800 c0120ca2 00000001 cca3d4c0 d3c504a0
May 29 15:18:07 player kernel:        c1333900 00000000 cca3d4c0 ffffffea 00008000 00001000 00000001 00000000
May 29 15:18:07 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 15:18:07 player kernel:    [system_call+51/56]
May 29 15:18:07 player kernel:
May 29 15:18:07 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 15:35:31 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:35:31 player kernel:  printing eip:
May 29 15:35:31 player kernel: c01204f7
May 29 15:35:31 player kernel: *pde = 00000000
May 29 15:35:31 player kernel: Oops: 0000
May 29 15:35:31 player kernel: CPU:    0
May 29 15:35:31 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 15:35:31 player kernel: EFLAGS: 00010282
May 29 15:35:31 player kernel: eax: fffffffe   ebx: ce4abbe0   ecx: 00000011   edx: 0000608e
May 29 15:35:31 player kernel: esi: d1065eb0   edi: 00002a55   ebp: c1898238   esp: ded4ff00
May 29 15:35:31 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:35:31 player kernel: Process playtv.pl (pid: 18380, stackpage=ded4f000)
May 29 15:35:31 player kernel: Stack: ce4abbe0 00000019 00002a3c 00000020 ce4abbe0 c0120a95 c126fb80 c1898158
May 29 15:35:31 player kernel:        d1065eb0 00002a1d 0000001f 0000c800 c0120ca2 00000001 ce4abbe0 d1065e00
May 29 15:35:31 player kernel:        c126fb80 00000000 ce4abbe0 ffffffea 00008000 00001000 00000001 00000000
May 29 15:35:31 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 15:35:31 player kernel:    [system_call+51/56]
May 29 15:35:31 player kernel:
May 29 15:35:31 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 15:45:35 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:45:35 player kernel:  printing eip:
May 29 15:45:35 player kernel: c01204f7
May 29 15:45:35 player kernel: *pde = 00000000
May 29 15:45:35 player kernel: Oops: 0000
May 29 15:45:35 player kernel: CPU:    0
May 29 15:45:35 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 15:45:35 player kernel: EFLAGS: 00010282
May 29 15:45:35 player kernel: eax: fffffffe   ebx: cca3d7c0   ecx: 00000011   edx: 0000608e
May 29 15:45:35 player kernel: esi: d38b4890   edi: 000002fc   ebp: c1898238   esp: cb765f00
May 29 15:45:35 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:45:35 player kernel: Process playtv.pl (pid: 18938, stackpage=cb765000)
May 29 15:45:35 player kernel: Stack: cca3d7c0 00000002 000002fa 00000020 cca3d7c0 c0120a95 c1777e00 c18981b8
May 29 15:45:35 player kernel:        d38b4890 000002dc 0000001f 00000bb1 c0120ca2 00000001 cca3d7c0 d38b47e0
May 29 15:45:35 player kernel:        c1777e00 00000000 cca3d7c0 ffffffea 00008000 00001000 00000001 00000000
May 29 15:45:35 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 15:45:35 player kernel:    [system_call+51/56]
May 29 15:45:35 player kernel:
May 29 15:45:35 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 15:45:44 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:45:44 player kernel:  printing eip:
May 29 15:45:44 player kernel: c0120c6b
May 29 15:45:44 player kernel: *pde = 00000000
May 29 15:45:44 player kernel: Oops: 0000
May 29 15:45:44 player kernel: CPU:    0
May 29 15:45:44 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 15:45:44 player kernel: EFLAGS: 00010282
May 29 15:45:44 player kernel: eax: fffffffe   ebx: c15e8700   ecx: 00000011   edx: 0000608e
May 29 15:45:44 player kernel: esi: c1898238   edi: d38b4890   ebp: 000002fc   esp: c9d6df44
May 29 15:45:44 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:45:44 player kernel: Process playtv.pl (pid: 19266, stackpage=c9d6d000)
May 29 15:45:44 player kernel: Stack: 00000000 d3bf8160 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 15:45:44 player kernel:        d38b47e0 c01211b5 d3bf8160 d3bf8180 c9d6df8c c01210dc 00000000 d3bf8160
May 29 15:45:44 player kernel:        ffffffea 00008000 00004000 00004000 08154c90 00000000 c012bf86 d3bf8160
May 29 15:45:44 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 15:45:44 player kernel:
May 29 15:45:44 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 15:54:52 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:54:52 player kernel:  printing eip:
May 29 15:54:52 player kernel: c0120c6b
May 29 15:54:52 player kernel: *pde = 00000000
May 29 15:54:52 player kernel: Oops: 0000
May 29 15:54:52 player kernel: CPU:    0
May 29 15:54:52 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 15:54:52 player kernel: EFLAGS: 00010282
May 29 15:54:52 player kernel: eax: fffffffe   ebx: c15e8700   ecx: 00000011   edx: 0000608e
May 29 15:54:52 player kernel: esi: c1898238   edi: d38b4890   ebp: 000002fc   esp: ded4ff44
May 29 15:54:52 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:54:52 player kernel: Process playtv.pl (pid: 19272, stackpage=ded4f000)
May 29 15:54:52 player kernel: Stack: 00000000 c18441a0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 15:54:52 player kernel:        d38b47e0 c01211b5 c18441a0 c18441c0 ded4ff8c c01210dc 00000000 c18441a0
May 29 15:54:52 player kernel:        ffffffea 00008000 00004000 00004000 08155f48 00000000 c012bf86 c18441a0
May 29 15:54:52 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 15:54:52 player kernel:
May 29 15:54:52 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 15:55:01 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 15:55:01 player kernel:  printing eip:
May 29 15:55:01 player kernel: c0120c6b
May 29 15:55:01 player kernel: *pde = 00000000
May 29 15:55:01 player kernel: Oops: 0000
May 29 15:55:01 player kernel: CPU:    0
May 29 15:55:01 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 15:55:01 player kernel: EFLAGS: 00010282
May 29 15:55:01 player kernel: eax: fffffffe   ebx: c15e8700   ecx: 00000011   edx: 0000608e
May 29 15:55:01 player kernel: esi: c1898238   edi: d38b4890   ebp: 000002fc   esp: cb765f44
May 29 15:55:01 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 15:55:01 player kernel: Process playtv.pl (pid: 19574, stackpage=cb765000)
May 29 15:55:01 player kernel: Stack: 00000000 cc541420 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 15:55:01 player kernel:        d38b47e0 c01211b5 cc541420 cc541440 cb765f8c c01210dc 00000000 cc541420
May 29 15:55:01 player kernel:        ffffffea 00008000 00004000 00004000 08152a38 00000000 c012bf86 cc541420
May 29 15:55:01 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 15:55:01 player kernel:
May 29 15:55:01 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:08:13 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:08:13 player kernel:  printing eip:
May 29 16:08:13 player kernel: c01204f7
May 29 16:08:13 player kernel: *pde = 00000000
May 29 16:08:13 player kernel: Oops: 0000
May 29 16:08:13 player kernel: CPU:    0
May 29 16:08:13 player kernel: EIP:    0010:[page_cache_read+75/188]    Not tainted
May 29 16:08:13 player kernel: EFLAGS: 00010282
May 29 16:08:13 player kernel: eax: fffffffe   ebx: cca3d5c0   ecx: 00000011   edx: 0000608e
May 29 16:08:13 player kernel: esi: cf791ab0   edi: 0000947b   ebp: c1898238   esp: c9d6df00
May 29 16:08:13 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:08:13 player kernel: Process playtv.pl (pid: 19580, stackpage=c9d6d000)
May 29 16:08:13 player kernel: Stack: cca3d5c0 0000001f 0000945c 00000020 cca3d5c0 c0120a95 c1020c40 c1898140
May 29 16:08:13 player kernel:        cf791ab0 0000943d 0000001f 0000c800 c0120ca2 00000001 cca3d5c0 cf791a00
May 29 16:08:13 player kernel:        c1020c40 00000000 cca3d5c0 ffffffea 00008000 00001000 00000001 00000000
May 29 16:08:13 player kernel: Call Trace: [generic_file_readahead+257/312] [do_generic_file_read+422/1028] [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228]
May 29 16:08:13 player kernel:    [system_call+51/56]
May 29 16:08:13 player kernel:
May 29 16:08:13 player kernel: Code: 39 70 08 75 f4 39 78 0c 75 ef 85 c0 74 0b 31 c0 eb 59 8d b4
May 29 16:09:14 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:09:14 player kernel:  printing eip:
May 29 16:09:14 player kernel: c0120c6b
May 29 16:09:14 player kernel: *pde = 00000000
May 29 16:09:14 player kernel: Oops: 0000
May 29 16:09:14 player kernel: CPU:    0
May 29 16:09:14 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:09:14 player kernel: EFLAGS: 00010282
May 29 16:09:14 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:09:14 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ded4ff44
May 29 16:09:14 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:09:14 player kernel: Process playtv.pl (pid: 20014, stackpage=ded4f000)
May 29 16:09:14 player kernel: Stack: 00000000 d14c0320 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:09:14 player kernel:        cf791a00 c01211b5 d14c0320 d14c0340 ded4ff8c c01210dc 00000000 d14c0320
May 29 16:09:14 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d14c0320
May 29 16:09:14 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:09:14 player kernel:
May 29 16:09:14 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:10:15 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:10:15 player kernel:  printing eip:
May 29 16:10:15 player kernel: c0120c6b
May 29 16:10:15 player kernel: *pde = 00000000
May 29 16:10:15 player kernel: Oops: 0000
May 29 16:10:15 player kernel: CPU:    0
May 29 16:10:15 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:10:15 player kernel: EFLAGS: 00010282
May 29 16:10:15 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:10:15 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:10:15 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:10:15 player kernel: Process playtv.pl (pid: 20052, stackpage=da40f000)
May 29 16:10:15 player kernel: Stack: 00000000 ce4abc60 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:10:15 player kernel:        cf791a00 c01211b5 ce4abc60 ce4abc80 da40ff8c c01210dc 00000000 ce4abc60
May 29 16:10:15 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 ce4abc60
May 29 16:10:15 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:10:15 player kernel:
May 29 16:10:15 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:11:17 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:11:17 player kernel:  printing eip:
May 29 16:11:17 player kernel: c0120c6b
May 29 16:11:17 player kernel: *pde = 00000000
May 29 16:11:17 player kernel: Oops: 0000
May 29 16:11:17 player kernel: CPU:    0
May 29 16:11:17 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:11:17 player kernel: EFLAGS: 00010282
May 29 16:11:17 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:11:17 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:11:17 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:11:17 player kernel: Process playtv.pl (pid: 20090, stackpage=c9d6d000)
May 29 16:11:17 player kernel: Stack: 00000000 d3bf82e0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:11:17 player kernel:        cf791a00 c01211b5 d3bf82e0 d3bf8300 c9d6df8c c01210dc 00000000 d3bf82e0
May 29 16:11:17 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d3bf82e0
May 29 16:11:17 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:11:17 player kernel:
May 29 16:11:17 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:12:18 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:12:18 player kernel:  printing eip:
May 29 16:12:18 player kernel: c0120c6b
May 29 16:12:18 player kernel: *pde = 00000000
May 29 16:12:18 player kernel: Oops: 0000
May 29 16:12:18 player kernel: CPU:    0
May 29 16:12:18 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:12:18 player kernel: EFLAGS: 00010282
May 29 16:12:18 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:12:18 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ded4ff44
May 29 16:12:18 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:12:18 player kernel: Process playtv.pl (pid: 20128, stackpage=ded4f000)
May 29 16:12:18 player kernel: Stack: 00000000 cca3d6c0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:12:18 player kernel:        cf791a00 c01211b5 cca3d6c0 cca3d6e0 ded4ff8c c01210dc 00000000 cca3d6c0
May 29 16:12:18 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3d6c0
May 29 16:12:18 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:12:18 player kernel:
May 29 16:12:18 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:13:19 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:13:19 player kernel:  printing eip:
May 29 16:13:19 player kernel: c0120c6b
May 29 16:13:19 player kernel: *pde = 00000000
May 29 16:13:19 player kernel: Oops: 0000
May 29 16:13:19 player kernel: CPU:    0
May 29 16:13:19 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:13:19 player kernel: EFLAGS: 00010282
May 29 16:13:19 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:13:19 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:13:19 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:13:19 player kernel: Process playtv.pl (pid: 20166, stackpage=da40f000)
May 29 16:13:19 player kernel: Stack: 00000000 cca3ddc0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:13:19 player kernel:        cf791a00 c01211b5 cca3ddc0 cca3dde0 da40ff8c c01210dc 00000000 cca3ddc0
May 29 16:13:19 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3ddc0
May 29 16:13:19 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:13:19 player kernel:
May 29 16:13:19 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:14:20 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:14:20 player kernel:  printing eip:
May 29 16:14:20 player kernel: c0120c6b
May 29 16:14:20 player kernel: *pde = 00000000
May 29 16:14:20 player kernel: Oops: 0000
May 29 16:14:20 player kernel: CPU:    0
May 29 16:14:20 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:14:20 player kernel: EFLAGS: 00010282
May 29 16:14:20 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:14:20 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:14:20 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:14:20 player kernel: Process playtv.pl (pid: 20204, stackpage=c9d6d000)
May 29 16:14:20 player kernel: Stack: 00000000 d3bf87e0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:14:20 player kernel:        cf791a00 c01211b5 d3bf87e0 d3bf8800 c9d6df8c c01210dc 00000000 d3bf87e0
May 29 16:14:20 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d3bf87e0
May 29 16:14:20 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:14:20 player kernel:
May 29 16:14:20 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:15:21 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:15:21 player kernel:  printing eip:
May 29 16:15:21 player kernel: c0120c6b
May 29 16:15:21 player kernel: *pde = 00000000
May 29 16:15:21 player kernel: Oops: 0000
May 29 16:15:21 player kernel: CPU:    0
May 29 16:15:21 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:15:21 player kernel: EFLAGS: 00010282
May 29 16:15:21 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:15:21 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ded4ff44
May 29 16:15:21 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:15:21 player kernel: Process playtv.pl (pid: 20242, stackpage=ded4f000)
May 29 16:15:21 player kernel: Stack: 00000000 ce4ab7e0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:15:21 player kernel:        cf791a00 c01211b5 ce4ab7e0 ce4ab800 ded4ff8c c01210dc 00000000 ce4ab7e0
May 29 16:15:21 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 ce4ab7e0
May 29 16:15:21 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:15:21 player kernel:
May 29 16:15:21 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:16:23 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:16:23 player kernel:  printing eip:
May 29 16:16:23 player kernel: c0120c6b
May 29 16:16:23 player kernel: *pde = 00000000
May 29 16:16:23 player kernel: Oops: 0000
May 29 16:16:23 player kernel: CPU:    0
May 29 16:16:23 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:16:23 player kernel: EFLAGS: 00010282
May 29 16:16:23 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:16:23 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:16:23 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:16:23 player kernel: Process playtv.pl (pid: 20280, stackpage=da40f000)
May 29 16:16:23 player kernel: Stack: 00000000 cca3da40 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:16:23 player kernel:        cf791a00 c01211b5 cca3da40 cca3da60 da40ff8c c01210dc 00000000 cca3da40
May 29 16:16:23 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3da40
May 29 16:16:23 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:16:23 player kernel:
May 29 16:16:23 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:17:24 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:17:24 player kernel:  printing eip:
May 29 16:17:24 player kernel: c0120c6b
May 29 16:17:24 player kernel: *pde = 00000000
May 29 16:17:24 player kernel: Oops: 0000
May 29 16:17:24 player kernel: CPU:    0
May 29 16:17:24 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:17:24 player kernel: EFLAGS: 00010282
May 29 16:17:24 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:17:24 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:17:24 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:17:24 player kernel: Process playtv.pl (pid: 20318, stackpage=c9d6d000)
May 29 16:17:24 player kernel: Stack: 00000000 cc541c20 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:17:24 player kernel:        cf791a00 c01211b5 cc541c20 cc541c40 c9d6df8c c01210dc 00000000 cc541c20
May 29 16:17:24 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cc541c20
May 29 16:17:24 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:17:24 player kernel:
May 29 16:17:24 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:18:25 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:18:25 player kernel:  printing eip:
May 29 16:18:25 player kernel: c0120c6b
May 29 16:18:25 player kernel: *pde = 00000000
May 29 16:18:25 player kernel: Oops: 0000
May 29 16:18:25 player kernel: CPU:    0
May 29 16:18:25 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:18:25 player kernel: EFLAGS: 00010282
May 29 16:18:25 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:18:25 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ded4ff44
May 29 16:18:25 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:18:25 player kernel: Process playtv.pl (pid: 20356, stackpage=ded4f000)
May 29 16:18:25 player kernel: Stack: 00000000 d14c0220 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:18:25 player kernel:        cf791a00 c01211b5 d14c0220 d14c0240 ded4ff8c c01210dc 00000000 d14c0220
May 29 16:18:25 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d14c0220
May 29 16:18:25 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:18:25 player kernel:
May 29 16:18:25 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:19:26 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:19:26 player kernel:  printing eip:
May 29 16:19:26 player kernel: c0120c6b
May 29 16:19:26 player kernel: *pde = 00000000
May 29 16:19:26 player kernel: Oops: 0000
May 29 16:19:26 player kernel: CPU:    0
May 29 16:19:26 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:19:26 player kernel: EFLAGS: 00010282
May 29 16:19:26 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:19:26 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:19:26 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:19:26 player kernel: Process playtv.pl (pid: 20394, stackpage=da40f000)
May 29 16:19:26 player kernel: Stack: 00000000 cca3d940 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:19:26 player kernel:        cf791a00 c01211b5 cca3d940 cca3d960 da40ff8c c01210dc 00000000 cca3d940
May 29 16:19:26 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3d940
May 29 16:19:26 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:19:26 player kernel:
May 29 16:19:26 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:20:27 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:20:27 player kernel:  printing eip:
May 29 16:20:27 player kernel: c0120c6b
May 29 16:20:27 player kernel: *pde = 00000000
May 29 16:20:27 player kernel: Oops: 0000
May 29 16:20:27 player kernel: CPU:    0
May 29 16:20:27 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:20:27 player kernel: EFLAGS: 00010282
May 29 16:20:27 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:20:27 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ccfbdf44
May 29 16:20:27 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:20:27 player kernel: Process playtv.pl (pid: 20432, stackpage=ccfbd000)
May 29 16:20:27 player kernel: Stack: 00000000 d3783bc0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:20:27 player kernel:        cf791a00 c01211b5 d3783bc0 d3783be0 ccfbdf8c c01210dc 00000000 d3783bc0
May 29 16:20:27 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d3783bc0
May 29 16:20:27 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:20:27 player kernel:
May 29 16:20:27 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:21:28 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:21:28 player kernel:  printing eip:
May 29 16:21:28 player kernel: c0120c6b
May 29 16:21:28 player kernel: *pde = 00000000
May 29 16:21:28 player kernel: Oops: 0000
May 29 16:21:28 player kernel: CPU:    0
May 29 16:21:28 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:21:28 player kernel: EFLAGS: 00010282
May 29 16:21:28 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:21:28 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:21:28 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:21:28 player kernel: Process playtv.pl (pid: 20470, stackpage=c9d6d000)
May 29 16:21:28 player kernel: Stack: 00000000 cca3d8c0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:21:28 player kernel:        cf791a00 c01211b5 cca3d8c0 cca3d8e0 c9d6df8c c01210dc 00000000 cca3d8c0
May 29 16:21:28 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3d8c0
May 29 16:21:28 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:21:28 player kernel:
May 29 16:21:28 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:22:30 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:22:30 player kernel:  printing eip:
May 29 16:22:30 player kernel: c0120c6b
May 29 16:22:30 player kernel: *pde = 00000000
May 29 16:22:30 player kernel: Oops: 0000
May 29 16:22:30 player kernel: CPU:    0
May 29 16:22:30 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:22:30 player kernel: EFLAGS: 00010282
May 29 16:22:30 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:22:30 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:22:30 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:22:30 player kernel: Process playtv.pl (pid: 20508, stackpage=da40f000)
May 29 16:22:30 player kernel: Stack: 00000000 d14c0420 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:22:30 player kernel:        cf791a00 c01211b5 d14c0420 d14c0440 da40ff8c c01210dc 00000000 d14c0420
May 29 16:22:30 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d14c0420
May 29 16:22:30 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:22:30 player kernel:
May 29 16:22:30 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:23:31 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:23:31 player kernel:  printing eip:
May 29 16:23:31 player kernel: c0120c6b
May 29 16:23:31 player kernel: *pde = 00000000
May 29 16:23:31 player kernel: Oops: 0000
May 29 16:23:31 player kernel: CPU:    0
May 29 16:23:31 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:23:31 player kernel: EFLAGS: 00010282
May 29 16:23:31 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:23:31 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ccfbdf44
May 29 16:23:31 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:23:31 player kernel: Process playtv.pl (pid: 20546, stackpage=ccfbd000)
May 29 16:23:31 player kernel: Stack: 00000000 cca3d240 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:23:31 player kernel:        cf791a00 c01211b5 cca3d240 cca3d260 ccfbdf8c c01210dc 00000000 cca3d240
May 29 16:23:31 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3d240
May 29 16:23:31 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:23:31 player kernel:
May 29 16:23:31 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:24:32 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:24:32 player kernel:  printing eip:
May 29 16:24:32 player kernel: c0120c6b
May 29 16:24:32 player kernel: *pde = 00000000
May 29 16:24:32 player kernel: Oops: 0000
May 29 16:24:32 player kernel: CPU:    0
May 29 16:24:32 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:24:32 player kernel: EFLAGS: 00010282
May 29 16:24:32 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:24:32 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:24:32 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:24:32 player kernel: Process playtv.pl (pid: 20584, stackpage=c9d6d000)
May 29 16:24:32 player kernel: Stack: 00000000 cc5419a0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:24:32 player kernel:        cf791a00 c01211b5 cc5419a0 cc5419c0 c9d6df8c c01210dc 00000000 cc5419a0
May 29 16:24:32 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cc5419a0
May 29 16:24:32 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:24:32 player kernel:
May 29 16:24:32 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:25:33 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:25:33 player kernel:  printing eip:
May 29 16:25:33 player kernel: c0120c6b
May 29 16:25:33 player kernel: *pde = 00000000
May 29 16:25:33 player kernel: Oops: 0000
May 29 16:25:33 player kernel: CPU:    0
May 29 16:25:33 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:25:33 player kernel: EFLAGS: 00010282
May 29 16:25:33 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:25:33 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:25:33 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:25:33 player kernel: Process playtv.pl (pid: 20622, stackpage=da40f000)
May 29 16:25:33 player kernel: Stack: 00000000 cc5410a0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:25:33 player kernel:        cf791a00 c01211b5 cc5410a0 cc5410c0 da40ff8c c01210dc 00000000 cc5410a0
May 29 16:25:33 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cc5410a0
May 29 16:25:33 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:25:33 player kernel:
May 29 16:25:33 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:26:12 player sshd[20681]: Accepted password for root from 10.0.1.78 port 57498 ssh2
May 29 16:26:34 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:26:34 player kernel:  printing eip:
May 29 16:26:34 player kernel: c0120c6b
May 29 16:26:34 player kernel: *pde = 00000000
May 29 16:26:34 player kernel: Oops: 0000
May 29 16:26:34 player kernel: CPU:    0
May 29 16:26:34 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:26:34 player kernel: EFLAGS: 00010282
May 29 16:26:34 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:26:34 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: ccfbdf44
May 29 16:26:34 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:26:34 player kernel: Process playtv.pl (pid: 20660, stackpage=ccfbd000)
May 29 16:26:34 player kernel: Stack: 00000000 cca3df40 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:26:34 player kernel:        cf791a00 c01211b5 cca3df40 cca3df60 ccfbdf8c c01210dc 00000000 cca3df40
May 29 16:26:34 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cca3df40
May 29 16:26:34 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:26:34 player kernel:
May 29 16:26:34 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:27:36 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:27:36 player kernel:  printing eip:
May 29 16:27:36 player kernel: c0120c6b
May 29 16:27:36 player kernel: *pde = 00000000
May 29 16:27:36 player kernel: Oops: 0000
May 29 16:27:36 player kernel: CPU:    0
May 29 16:27:36 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:27:36 player kernel: EFLAGS: 00010282
May 29 16:27:36 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:27:36 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:27:36 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:27:36 player kernel: Process playtv.pl (pid: 20732, stackpage=c9d6d000)
May 29 16:27:36 player kernel: Stack: 00000000 d3bf8660 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:27:36 player kernel:        cf791a00 c01211b5 d3bf8660 d3bf8680 c9d6df8c c01210dc 00000000 d3bf8660
May 29 16:27:36 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d3bf8660
May 29 16:27:36 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:27:36 player kernel:
May 29 16:27:36 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:28:37 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:28:37 player kernel:  printing eip:
May 29 16:28:37 player kernel: c0120c6b
May 29 16:28:37 player kernel: *pde = 00000000
May 29 16:28:37 player kernel: Oops: 0000
May 29 16:28:37 player kernel: CPU:    0
May 29 16:28:37 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:28:37 player kernel: EFLAGS: 00010282
May 29 16:28:37 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:28:37 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:28:37 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:28:37 player kernel: Process playtv.pl (pid: 20773, stackpage=da40f000)
May 29 16:28:37 player kernel: Stack: 00000000 cc541ba0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:28:37 player kernel:        cf791a00 c01211b5 cc541ba0 cc541bc0 da40ff8c c01210dc 00000000 cc541ba0
May 29 16:28:37 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cc541ba0
May 29 16:28:37 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:28:37 player kernel:
May 29 16:28:37 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:29:38 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:29:38 player kernel:  printing eip:
May 29 16:29:38 player kernel: c0120c6b
May 29 16:29:38 player kernel: *pde = 00000000
May 29 16:29:38 player kernel: Oops: 0000
May 29 16:29:38 player kernel: CPU:    0
May 29 16:29:38 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:29:38 player kernel: EFLAGS: 00010282
May 29 16:29:38 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:29:38 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: d8d1ff44
May 29 16:29:38 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:29:38 player kernel: Process playtv.pl (pid: 20818, stackpage=d8d1f000)
May 29 16:29:38 player kernel: Stack: 00000000 d14c05a0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:29:38 player kernel:        cf791a00 c01211b5 d14c05a0 d14c05c0 d8d1ff8c c01210dc 00000000 d14c05a0
May 29 16:29:38 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d14c05a0
May 29 16:29:38 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:29:38 player kernel:
May 29 16:29:38 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:30:39 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:30:39 player kernel:  printing eip:
May 29 16:30:39 player kernel: c0120c6b
May 29 16:30:39 player kernel: *pde = 00000000
May 29 16:30:39 player kernel: Oops: 0000
May 29 16:30:39 player kernel: CPU:    0
May 29 16:30:39 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:30:39 player kernel: EFLAGS: 00010282
May 29 16:30:39 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:30:39 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: c9d6df44
May 29 16:30:39 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:30:39 player kernel: Process playtv.pl (pid: 20862, stackpage=c9d6d000)
May 29 16:30:39 player kernel: Stack: 00000000 cc541da0 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:30:39 player kernel:        cf791a00 c01211b5 cc541da0 cc541dc0 c9d6df8c c01210dc 00000000 cc541da0
May 29 16:30:39 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 cc541da0
May 29 16:30:39 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:30:39 player kernel:
May 29 16:30:39 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:31:14 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:31:14 player kernel:  printing eip:
May 29 16:31:14 player kernel: c0120c6b
May 29 16:31:14 player kernel: *pde = 00000000
May 29 16:31:14 player kernel: Oops: 0000
May 29 16:31:14 player kernel: CPU:    0
May 29 16:31:14 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:31:14 player kernel: EFLAGS: 00010282
May 29 16:31:14 player kernel: eax: fffffffe   ebx: d3bf80e0   ecx: 00000011   edx: 0000608e
May 29 16:31:14 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: dc253f44
May 29 16:31:14 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:31:14 player kernel: Process cat (pid: 20958, stackpage=dc253000)
May 29 16:31:14 player kernel: Stack: 00000000 d3bf80e0 ffffffea 00001000 00001000 00000000 00000000 00000000
May 29 16:31:14 player kernel:        cf791a00 c01211b5 d3bf80e0 d3bf8100 dc253f8c c01210dc 00000000 d3bf80e0
May 29 16:31:14 player kernel:        ffffffea 00001000 00000000 00001000 0804af60 00000000 c012bf86 d3bf80e0
May 29 16:31:14 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:31:14 player kernel:
May 29 16:31:14 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:31:40 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:31:40 player kernel:  printing eip:
May 29 16:31:40 player kernel: c0120c6b
May 29 16:31:40 player kernel: *pde = 00000000
May 29 16:31:40 player kernel: Oops: 0000
May 29 16:31:40 player kernel: CPU:    0
May 29 16:31:40 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:31:40 player kernel: EFLAGS: 00010282
May 29 16:31:40 player kernel: eax: fffffffe   ebx: c1531f40   ecx: 00000011   edx: 0000608e
May 29 16:31:40 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: da40ff44
May 29 16:31:40 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:31:40 player kernel: Process playtv.pl (pid: 20936, stackpage=da40f000)
May 29 16:31:40 player kernel: Stack: 00000000 d3bf8860 ffffffea 00008000 00001000 00000000 00000000 00000000
May 29 16:31:40 player kernel:        cf791a00 c01211b5 d3bf8860 d3bf8880 da40ff8c c01210dc 00000000 d3bf8860
May 29 16:31:40 player kernel:        ffffffea 00008000 00002b77 00005489 081833af 00000000 c012bf86 d3bf8860
May 29 16:31:40 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:31:40 player kernel:
May 29 16:31:40 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:31:59 player kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000006
May 29 16:31:59 player kernel:  printing eip:
May 29 16:31:59 player kernel: c0120c6b
May 29 16:31:59 player kernel: *pde = 00000000
May 29 16:31:59 player kernel: Oops: 0000
May 29 16:31:59 player kernel: CPU:    0
May 29 16:31:59 player kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
May 29 16:31:59 player kernel: EFLAGS: 00010282
May 29 16:31:59 player kernel: eax: fffffffe   ebx: cc5418a0   ecx: 00000011   edx: 0000608e
May 29 16:31:59 player kernel: esi: c1898238   edi: cf791ab0   ebp: 0000947b   esp: dc253f44
May 29 16:31:59 player kernel: ds: 0018   es: 0018   ss: 0018
May 29 16:31:59 player kernel: Process cat (pid: 20992, stackpage=dc253000)
May 29 16:31:59 player kernel: Stack: 00000000 cc5418a0 ffffffea 00001000 00001000 00000000 00000000 00000000
May 29 16:31:59 player kernel:        cf791a00 c01211b5 cc5418a0 cc5418c0 dc253f8c c01210dc 00000000 cc5418a0
May 29 16:31:59 player kernel:        ffffffea 00001000 00000000 00001000 0804af60 00000000 c012bf86 cc5418a0
May 29 16:31:59 player kernel: Call Trace: [generic_file_read+129/308] [file_read_actor+0/88] [sys_read+150/228] [system_call+51/56]
May 29 16:31:59 player kernel:
May 29 16:31:59 player kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00
May 29 16:32:31 player init: Switching to runlevel: 6

