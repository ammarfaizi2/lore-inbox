Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSFDQ7K>; Tue, 4 Jun 2002 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSFDQ7J>; Tue, 4 Jun 2002 12:59:09 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:3859 "EHLO
	prosun.first.gmd.de") by vger.kernel.org with ESMTP
	id <S315232AbSFDQ7E>; Tue, 4 Jun 2002 12:59:04 -0400
From: Sebastian Mika <Sebastian.Mika@first.fraunhofer.de>
Organization: Fraunhofer First
To: linux-kernel@vger.kernel.org
Subject: Oopsing Athlong systems
Date: Tue, 4 Jun 2002 18:57:10 +0200
User-Agent: KMail/1.4.1
Cc: Sebastian Mika <mika@first.fraunhofer.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ARX65CTOCIIAYCDIGUB5"
Message-Id: <200206041857.10902.Sebastian.Mika@first.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ARX65CTOCIIAYCDIGUB5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi,

I have a problem with several Athlon XP/MSI systems for quite a while now. For 
some systems the problems almost completely disappeared with newer kernel 
version or bios updates. However: not on all and not completely. 

I would be very thankful if someone had at least a suggestion what to try 
next. There seem to be some people on the web experiencing similar problems. 
But the only answers they got were to improve cooling and/or power supply 
which are already over-dimensional for our system in question.

More detailed problem and system descriptions follow below. Please ask 
questions if you need to know more!

Thanks a lot,
Sebastian Mika.


Problem description:
==========================
* The system does not run stable neither with linux-2.4.[2,13,16,17]  nor with 
2.4.19-pre10.
* The system crash appears quite randomly, usually under heavier load but 
sometimes also during boot up or if the system is (more or less) idle.
* The milder effects are a killing of a running process often with the 
following or similar message in the system log:

Jun  4 17:05:05 calculon kernel: swap_dup: Bad swap file entry 00000020
Jun  4 17:05:05 calculon kernel: VM: killing process matlab
Jun  4 17:05:05 calculon kernel: swap_free: Bad swap file entry 00000020

Interestingly this also happens if there is **NO** swap space configured! 
Afterwards the system is usually still usable although not very stable.
* Alternatively, the system produces an Oops message. I attached the output of 
ksymoops for the two latest occurrence in OOPS.txt and OOPS-2.txt.
* The system seems to be slightly more stable when being operated at 100MHz 
front side bus rather than 133MHz.
* This is the fifth system (all Athlon with MSI mainboard and VIA chipset) 
having this sort of problem. The other systems are relatively stable now with 
the 2.4.18 kernel. All systems have the latest BIOS updates from MSI.
* We did extensive testing to sort out hardware problems. Especially RAM and 
CPU seem to be fine.
* SPECIAL: The system boots a local kernel and has local swap/tmp but the rest 
of the OS is on a NFS server. However, 20 other systems do not have any 
problem with absolutely identical software setup.



System
==========================
Processor: Athlon XP 1800+ (with very good cooling system)
Mainboard: MSI K7T266 Pro2 (VIA KT266 chipset)
RAM: 3*256 DDR-RAM CL2.5
Video: Elsa Gladiac 511 AGP Geforce2MX
Network:  3Com Corporation 3c905C-TX PCI
Power Supply: Enermax 350Watt
Disks/CD: 
- hda: Maxtor 4G120J6, ATA DISK drive
- hdc: CD-950E/TKU, ATAPI CD/DVD-ROM drive
both on on-board VIA vt8233 UDMA 100 controller
Kernel: 2.4.19-pre10
Kernel-Boot-Options: "nfsroot=BLABLA disableapic" (disapleapic helped on a 
similar system).
gcc version 2.95.2 19991024 (release)
binutils-2.10.0.33-24
-- 
Sebastian Mika             http://www.first.fraunhofer.de/~mika/
Fraunhofer - First
Kekulestr. 7                                      Tel: +49 (30) 6392 1906
12489 Berlin, Germany                   Fax: +49 (30) 6392 1805

--------------Boundary-00=_ARX65CTOCIIAYCDIGUB5
Content-Type: text/plain;
  charset="us-ascii";
  name="OOPS.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="OOPS.txt"

ksymoops 2.4.0 on i686 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Jun  4 13:00:00 calculon kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000009
Jun  4 13:00:00 calculon kernel: c013b5f3
Jun  4 13:00:00 calculon kernel: *pde = 00000000
Jun  4 13:00:00 calculon kernel: Oops: 0000
Jun  4 13:00:00 calculon kernel: CPU:    0
Jun  4 13:00:00 calculon kernel: EIP:    0010:[flush_old_exec+403/608]    Not tainted
Jun  4 13:00:00 calculon kernel: EFLAGS: 00010246
Jun  4 13:00:00 calculon kernel: eax: 00000001   ebx: e55fa000   ecx: e55fa0a8   edx: e55fbe68
Jun  4 13:00:00 calculon kernel: esi: 00000003   edi: 00000000   ebp: e55fbcf4   esp: e55fbce0
Jun  4 13:00:00 calculon kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 13:00:00 calculon kernel: Process apm (pid: 939, stackpage=e55fb000)
Jun  4 13:00:00 calculon kernel: Stack: 00000004 e55fa000 e55fbda8 c025c3a8 eb1bbec0 e55fbe0c c014cd63 e55fbe68 
Jun  4 13:00:00 calculon kernel:        c02a40d8 c014c8f0 e55fbe68 00000000 c025c3a4 00000001 ef80d1e8 e55fbdc0 
Jun  4 13:00:00 calculon kernel:        00000000 00000000 00010202 00000000 00000000 00000000 ffffffff 00000000 
Jun  4 13:00:00 calculon kernel: Call Trace: [load_elf_binary+1139/2944] [load_elf_binary+0/2944] [do_generic_file_read+1023/1040] [search_binary_handler+107/368] [do_execve+328/416] 
Jun  4 13:00:00 calculon kernel: Code: 8b 40 08 50 e8 64 17 00 00 83 c4 08 85 c0 74 0e b8 00 e0 ff 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 08                  mov    0x8(%eax),%eax
Code;  00000003 Before first symbol
   3:   50                        push   %eax
Code;  00000004 Before first symbol
   4:   e8 64 17 00 00            call   176d <_EIP+0x176d> 0000176d Before first symbol
Code;  00000009 Before first symbol
   9:   83 c4 08                  add    $0x8,%esp
Code;  0000000c Before first symbol
   c:   85 c0                     test   %eax,%eax
Code;  0000000e Before first symbol
   e:   74 0e                     je     1e <_EIP+0x1e> 0000001e Before first symbol
Code;  00000010 Before first symbol
  10:   b8 00 e0 ff 00            mov    $0xffe000,%eax


3 warnings issued.  Results may not be reliable.

--------------Boundary-00=_ARX65CTOCIIAYCDIGUB5
Content-Type: text/plain;
  charset="us-ascii";
  name="OOPS-2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="OOPS-2.txt"

ksymoops 2.4.0 on i686 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 0000006a
Jun  4 12:20:22 calculon kernel: c013af7f
Jun  4 12:20:22 calculon kernel: *pde = 00000000
Jun  4 12:20:22 calculon kernel: Oops: 0002
Jun  4 12:20:22 calculon kernel: CPU:    0
Jun  4 12:20:22 calculon kernel: EIP:    0010:[copy_strings+399/496]    Not tainted
Jun  4 12:20:22 calculon kernel: EFLAGS: 00010246
Jun  4 12:20:22 calculon kernel: eax: 00000000   ebx: 0000001d   ecx: 00000000   edx: c195401d
Jun  4 12:20:22 calculon kernel: esi: 00000000   edi: eb5e1004   ebp: ef999e28   esp: ef999dfc
Jun  4 12:20:22 calculon kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 12:20:22 calculon kernel: Process rc (pid: 400, stackpage=ef999000)
Jun  4 12:20:22 calculon kernel: Stack: ef998000 c0000000 ef999ee8 eb5e0fdf eb5e0000 ef999ee8 c1821a20 00000001 
Jun  4 12:20:22 calculon kernel:        0001ffdf 0000001d c1954000 ef999e44 c013b007 00000000 ef999f90 ef999e68 
Jun  4 12:20:22 calculon kernel:        ef999e68 00000080 ef999f9c c013bc91 00000001 ef999f90 ef999e68 c1954000 
Jun  4 12:20:22 calculon kernel: Call Trace: [copy_strings_kernel+39/64] [do_execve+257/416] [sys_execve+47/96] [system_call+51/56] 
Jun  4 12:20:22 calculon kernel: Code: c0 74 0e 6a 4a e8 c7 c0 fd ff 8d b4 26 00 00 00 00 8b 7d ec 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c0                        (bad)  
Code;  00000001 Before first symbol
   1:   74 0e                     je     11 <_EIP+0x11> 00000011 Before first symbol
Code;  00000003 Before first symbol
   3:   6a 4a                     push   $0x4a
Code;  00000005 Before first symbol
   5:   e8 c7 c0 fd ff            call   fffdc0d1 <_EIP+0xfffdc0d1> fffdc0d1 <END_OF_CODE+3fcbbed5/????>
Code;  0000000a Before first symbol
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  00000011 Before first symbol
  11:   8b 7d ec                  mov    0xffffffec(%ebp),%edi


3 warnings issued.  Results may not be reliable.

--------------Boundary-00=_ARX65CTOCIIAYCDIGUB5--

