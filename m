Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319580AbSH3PDE>; Fri, 30 Aug 2002 11:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319581AbSH3PDE>; Fri, 30 Aug 2002 11:03:04 -0400
Received: from mout1.freenet.de ([194.97.50.132]:64483 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S319580AbSH3PC7>;
	Fri, 30 Aug 2002 11:02:59 -0400
Date: Fri, 30 Aug 2002 15:41:16 +0200
To: linux-kernel@vger.kernel.org
Subject: [Oops]: Kernel BUG at dcache.c:345 (kernel 2.4.19)
Message-ID: <20020830134115.GA1711@orga.eichstaetter-triathlon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Markus Blatt <Markus.Blatt@web.de>
X-Warning: web.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Starting from kernel version 2.4.18 I irregularly get kernel oopses
which do not seem to depend on using special applications but rather
on the amount auf memory used.

kernel version: Linux version 2.4.19 (root@orga) (gcc version 2.95.4
20011002 (Debian prerelease)) #1 Sam Aug 10 11:47:22 CEST 2002

Output of ksyoops of /var/log/messages:

ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 26 11:56:55 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 26 11:56:55 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 26 11:56:55 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 26 11:56:55 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 27 10:57:07 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 27 10:57:07 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 27 10:57:07 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 27 10:57:07 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 28 09:47:43 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 28 09:47:43 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 28 09:47:43 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 28 09:47:43 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 28 17:31:36 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 28 17:31:36 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 28 17:31:36 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 28 17:31:36 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 29 11:09:32 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 29 11:09:32 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 29 11:09:32 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 29 11:09:32 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 29 13:50:39 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 29 13:50:39 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 29 13:50:39 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 29 13:50:39 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 29 23:01:47 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 29 23:01:47 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 29 23:01:47 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 29 23:01:47 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 30 00:01:33 orga kernel: c0134d65
Aug 30 00:01:33 orga kernel: Oops: 0002
Aug 30 00:01:33 orga kernel: CPU:    0
Aug 30 00:01:33 orga kernel: EIP:    0010:[__remove_inode_queue+21/28]    Not tainted
Aug 30 00:01:33 orga kernel: EFLAGS: 00010282
Aug 30 00:01:33 orga kernel: eax: cd4c2eec   ebx: c661139c   ecx: 000001d0   edx: c661c7bd
Aug 30 00:01:33 orga kernel: esi: c66110c4   edi: c661139c   ebp: c7f91f00   esp: c7f91f00
Aug 30 00:01:33 orga kernel: ds: 0018   es: 0018   ss: 0018
Aug 30 00:01:33 orga kernel: Process kswapd (pid: 5, stackpage=c7f91000)
Aug 30 00:01:33 orga kernel: Stack: c7f91f1c c0137106 c661139c c1088c6c 000001d0 0000000a c1088c6c c7f91f2c 
Aug 30 00:01:33 orga kernel:        c013575d c661139c c1088c6c c7f91f60 c012d491 c1088c6c 000001d0 00000020 
Aug 30 00:01:33 orga kernel:        000001d0 00000020 00000020 c7f90000 000000f1 00000959 000001d0 c021e8b4 
Aug 30 00:01:33 orga kernel: Call Trace:    [try_to_free_buffers+94/248] [try_to_release_page+69/80] [shrink_cache+481/756] [shrink_caches+85/144] [try_to_free_pages+64/100]
Aug 30 00:01:33 orga kernel: Code: 89 50 04 89 02 5d c3 55 89 e5 8b 55 08 31 c9 8d 42 18 39 42 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; cd4c2eec <END_OF_CODE+4c2ec05/????>
>>ebx; c661139c <_end+6375ba8/857880c>
>>edx; c661c7bd <_end+6380fc9/857880c>
>>esi; c66110c4 <_end+63758d0/857880c>
>>edi; c661139c <_end+6375ba8/857880c>
>>ebp; c7f91f00 <_end+7cf670c/857880c>
>>esp; c7f91f00 <_end+7cf670c/857880c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 02                     mov    %eax,(%edx)
Code;  00000005 Before first symbol
   5:   5d                        pop    %ebp
Code;  00000006 Before first symbol
   6:   c3                        ret    
Code;  00000007 Before first symbol
   7:   55                        push   %ebp
Code;  00000008 Before first symbol
   8:   89 e5                     mov    %esp,%ebp
Code;  0000000a Before first symbol
   a:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  0000000d Before first symbol
   d:   31 c9                     xor    %ecx,%ecx
Code;  0000000f Before first symbol
   f:   8d 42 18                  lea    0x18(%edx),%eax
Code;  00000012 Before first symbol
  12:   39 42 00                  cmp    %eax,0x0(%edx)

Aug 30 09:35:21 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 30 09:35:21 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 30 09:35:21 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 30 09:35:21 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 30 10:56:04 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 30 10:56:04 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 30 10:56:04 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 30 10:56:04 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 30 11:52:01 orga kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Aug 30 13:53:57 orga kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 30 13:53:57 orga kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug 30 13:53:57 orga kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x398-0x39f 0x4d0-0x4d7
Aug 30 13:53:57 orga kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 30 13:53:57 orga kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Aug 30 14:03:10 orga kernel: kernel BUG at dcache.c:345!
Aug 30 14:03:10 orga kernel: invalid operand: 0000
Aug 30 14:03:10 orga kernel: CPU:    0
Aug 30 14:03:10 orga kernel: EIP:    0010:[prune_dcache+93/320]    Not tainted
Aug 30 14:03:10 orga kernel: EFLAGS: 00010206
Aug 30 14:03:10 orga kernel: eax: 0000000a   ebx: c6232f08   ecx: c1166478   edx: c6232e94
Aug 30 14:03:10 orga kernel: esi: c6232ef0   edi: c6015844   ebp: c7f91f54   esp: c7f91f48
Aug 30 14:03:10 orga kernel: ds: 0018   es: 0018   ss: 0018
Aug 30 14:03:10 orga kernel: Process kswapd (pid: 5, stackpage=c7f91000)
Aug 30 14:03:10 orga kernel: Stack: 00000005 000001d0 00000020 c7f91f60 c0143e7c 000001d6 c7f91f84 c012d6d4 
Aug 30 14:03:10 orga kernel:        00000006 000001d0 00000006 000001d0 c021e8b4 00000006 c021e8b4 c7f91f9c 
Aug 30 14:03:10 orga kernel:        c012d73c 00000020 c021e8b4 00000001 c7f90000 c7f91fb4 c012d7e0 c021e800 
Aug 30 14:03:10 orga kernel: Call Trace:    [shrink_dcache_memory+28/56] [shrink_caches+104/144] [try_to_free_pages+64/100] [kswapd_balance_pgdat+76/160] [kswapd_balance+26/56]
Aug 30 14:03:10 orga kernel: Code: 0f 0b 59 01 40 51 1f c0 8d 46 10 8b 48 04 8b 53 f8 89 4a 04 


>>ebx; c6232f08 <_end+5f97714/857880c>
>>ecx; c1166478 <_end+ecac84/857880c>
>>edx; c6232e94 <_end+5f976a0/857880c>
>>esi; c6232ef0 <_end+5f976fc/857880c>
>>edi; c6015844 <_end+5d7a050/857880c>
>>ebp; c7f91f54 <_end+7cf6760/857880c>
>>esp; c7f91f48 <_end+7cf6754/857880c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   59                        pop    %ecx
Code;  00000003 Before first symbol
   3:   01 40 51                  add    %eax,0x51(%eax)
Code;  00000006 Before first symbol
   6:   1f                        pop    %ds
Code;  00000007 Before first symbol
   7:   c0 8d 46 10 8b 48 04      rorb   $0x4,0x488b1046(%ebp)
Code;  0000000e Before first symbol
   e:   8b 53 f8                  mov    0xfffffff8(%ebx),%edx
Code;  00000011 Before first symbol
  11:   89 4a 04                  mov    %ecx,0x4(%edx)

Aug 30 14:29:49 orga kernel:  <1>Unable to handle kernel paging request at virtual address 72dc2ef0
Aug 30 14:29:49 orga kernel: c0134d65
Aug 30 14:29:49 orga kernel: Oops: 0002
Aug 30 14:29:49 orga kernel: CPU:    0
Aug 30 14:29:49 orga kernel: EIP:    0010:[__remove_inode_queue+21/28]    Not tainted
Aug 30 14:29:49 orga kernel: EFLAGS: 00010282
Aug 30 14:29:49 orga kernel: eax: 72dc2eec   ebx: c66d2e2c   ecx: c1166258   edx: c66dc67b
Aug 30 14:29:49 orga kernel: esi: c66d2bbc   edi: c66d2efc   ebp: c6c33e7c   esp: c6c33e7c
Aug 30 14:29:49 orga kernel: ds: 0018   es: 0018   ss: 0018
Aug 30 14:29:49 orga kernel: Process dpkg (pid: 1554, stackpage=c6c33000)
Aug 30 14:29:49 orga kernel: Stack: c6c33e98 c0137106 c66d2e2c c1111a1c 00000000 c66d2efc c1111a1c c6c33ea8 
Aug 30 14:29:53 orga kernel:        c013575d c66d2efc 00001000 c6c33ec4 c01357c1 c1111a1c 00000000 c1111a1c 
Aug 30 14:29:53 orga kernel:        00000000 00000000 c6c33ed8 c01266db c1111a1c 00000000 00000001 c6c33eec 
Aug 30 14:29:53 orga kernel: Call Trace:    [try_to_free_buffers+94/248] [try_to_release_page+69/80] [discard_bh_page+89/120] [do_flushpage+31/44] [truncate_complete_page+21/76]
Aug 30 14:29:53 orga kernel: Code: 89 50 04 89 02 5d c3 55 89 e5 8b 55 08 31 c9 8d 42 18 39 42 


>>eax; 72dc2eec Before first symbol
>>ebx; c66d2e2c <_end+6437638/857880c>
>>ecx; c1166258 <_end+ecaa64/857880c>
>>edx; c66dc67b <_end+6440e87/857880c>
>>esi; c66d2bbc <_end+64373c8/857880c>
>>edi; c66d2efc <_end+6437708/857880c>
>>ebp; c6c33e7c <_end+6998688/857880c>
>>esp; c6c33e7c <_end+6998688/857880c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 02                     mov    %eax,(%edx)
Code;  00000005 Before first symbol
   5:   5d                        pop    %ebp
Code;  00000006 Before first symbol
   6:   c3                        ret    
Code;  00000007 Before first symbol
   7:   55                        push   %ebp
Code;  00000008 Before first symbol
   8:   89 e5                     mov    %esp,%ebp
Code;  0000000a Before first symbol
   a:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  0000000d Before first symbol
   d:   31 c9                     xor    %ecx,%ecx
Code;  0000000f Before first symbol
   f:   8d 42 18                  lea    0x18(%edx),%eax
Code;  00000012 Before first symbol
  12:   39 42 00                  cmp    %eax,0x0(%edx)


1 warning issued.  Results may not be reliable.


My Hardware is a Sony Vaio PCG-N505X with a Celeron (Mendocino) 366 MHz

Outut of the ver_linux skript:

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         parport_pc lp parport 3c574_cs ds yenta_socket
pcmcia_core usb-uhci usbcore ide-cd sr_mod cdrom sd_mod scsi_mod serial
rtc

Output of cat /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 10
cpu MHz         : 331.583
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 661.91

Output of cat /proc/modules
parport_pc             21224   1 (autoclean)
lp                      6112   0 (autoclean)
parport                25216   1 (autoclean) [parport_pc lp]
3c574_cs                8580   1
ds                      6720   1 [3c574_cs]
yenta_socket           10368   1
pcmcia_core            40032   0 [3c574_cs ds yenta_socket]
usb-uhci               21156   0 (unused)
usbcore                60928   1 [usb-uhci]
ide-cd                 26784   0 (autoclean)
sr_mod                 13272   0 (autoclean) (unused)
cdrom                  27136   0 (autoclean) [ide-cd sr_mod]
sd_mod                 10812   0 (autoclean) (unused)
scsi_mod               89560   2 (autoclean) [sr_mod sd_mod]
serial                 43360   0 (autoclean)
rtc                     5756   0 (autoclean)

Output of cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0300-031f : 3c574_cs
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
8000-803f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
fc8c-fc8f : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
fc90-fc9f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  fc90-fc97 : ide0
  fc98-fc9f : ide1
fca0-fcbf : Intel Corp. 82371AB/EB/MB PIIX4 USB
  fca0-fcbf : usb-uhci
fcc0-fcff : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
	  
Output of cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001e95dc : Kernel code
  001e95dd-0024d75f : Kernel data
07ff0000-07fffbff : ACPI Tables
07fffc00-07ffffff : ACPI Non-volatile Storage
10000000-10000fff : Ricoh Co Ltd RL5c475
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
a0000000-a0000fff : card services
fd000000-fdffffff : Neomagic Corporation [MagicMedia 256AV]
fe800000-febfffff : Neomagic Corporation [MagicMedia 256AV]
fec00000-fecfffff : Neomagic Corporation [MagicMedia 256AV]
fedf7000-fedf77ff : Sony Corporation CXD3222 i.LINK Controller
fedf7c00-fedf7dff : Sony Corporation CXD3222 i.LINK Controller
fedf8000-fedfffff : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
fff80000-ffffffff : reserved

Output of lspci -vvv:
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
	Subsystem: Sony Corporation: Unknown device 805c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=64M]

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fc90 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at fca0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 8060
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fedf7000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fedf7c00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
	Subsystem: Sony Corporation: Unknown device 805e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at fcc0 [size=64]
	Region 2: I/O ports at fc8c [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 805d
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 8061
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

No scsi devices.

As the problem might by connect to the filesystem here is the output of
cat /proc/filesystems
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
        ext3
        ext2
nodev   ramfs
nodev   devfs
nodev   autofs
nodev   devpts
nodev   usbdevfs
nodev   usbfs

I hope my information is somewhat helpfull for finding the bug.

Regards,

Markus Blatt


