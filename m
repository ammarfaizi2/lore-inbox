Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUCCUUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUCCUUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:20:51 -0500
Received: from av8.netikka.fi ([213.250.83.8]:1695 "EHLO mail.linuxvaasa.com")
	by vger.kernel.org with ESMTP id S261178AbUCCUTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:19:40 -0500
Message-ID: <40463DD9.1040200@netikka.fi>
Date: Wed, 03 Mar 2004 22:19:37 +0200
From: Johnny Strom <jonny.strom@netikka.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Multiple oopses with 2.4.25
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

It seems that I have the same problem as in this
mail:

http://www.ussg.iu.edu/hypermail/linux/kernel/0403.0/0635.html


I also get multiple oopse's with 2.4.25 plus the latest
ipsec kernel patch form http://www.freeswan.org/.

I have to reset the computer to get it working again,
below is the oopse's:


CC me I am not on the ml.



Mar  1 04:03:39 vpn kernel: kernel BUG at vmscan.c:388!
Mar  1 04:03:39 vpn kernel: invalid operand: 0000
Mar  1 04:03:39 vpn kernel: CPU:    0
Mar  1 04:03:39 vpn kernel: EIP:    0010:[<c012bd7d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar  1 04:03:39 vpn kernel: EFLAGS: 00010202
Mar  1 04:03:39 vpn kernel: eax: 00000040   ebx: c1015f20   ecx: 
00000392   edx: c101d108
Mar  1 04:03:39 vpn kernel: esi: c1015f04   edi: 00000000   ebp: 
c02be398   esp: c1577f54
Mar  1 04:03:39 vpn kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 04:03:39 vpn kernel: Process kswapd (pid: 4, stackpage=c1577000)
Mar  1 04:03:39 vpn kernel: Stack: c1576000 00000c80 0000419d 000001d0 
0000000c 00000020 000001d0 c02be398
Mar  1 04:03:39 vpn kernel:        c02be398 c012bf0f c1577f98 0000003c 
000001d0 00000020 c012bf70 c1577f98
Mar  1 04:03:39 vpn kernel:        00000000 00000000 c02be398 00000001 
c1576000 00000000 c012c11c c02be2c0
Mar  1 04:03:39 vpn kernel: Call Trace:    [<c012bf0f>] [<c012bf70>] 
[<c012c11c>] [<c012c176>] [<c012c29d>]
Mar  1 04:03:39 vpn kernel:   [<c0105000>] [<c0105626>] [<c012c200>]
Mar  1 04:03:39 vpn kernel: Code: 0f 0b 84 01 b8 4c 27 c0 e9 ee fc ff ff 
c7 00 00 00 00 00 e8


 >>EIP; c012bd7d <shrink_cache+38d/3b0>   <=====

 >>ebp; c02be398 <contig_page_data+d8/3ac>

Trace; c012bf0f <shrink_caches+2f/40>
Trace; c012bf70 <try_to_free_pages_zone+50/d0>
Trace; c012c11c <kswapd_balance_pgdat+5c/a0>
Trace; c012c176 <kswapd_balance+16/30>
Trace; c012c29d <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105626 <arch_kernel_thread+26/30>
Trace; c012c200 <kswapd+0/c0>

Code;  c012bd7d <shrink_cache+38d/3b0>
00000000 <_EIP>:
Code;  c012bd7d <shrink_cache+38d/3b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012bd7f <shrink_cache+38f/3b0>
    2:   84 01                     test   %al,(%ecx)
Code;  c012bd81 <shrink_cache+391/3b0>
    4:   b8 4c 27 c0 e9            mov    $0xe9c0274c,%eax
Code;  c012bd86 <shrink_cache+396/3b0>
    9:   ee                        out    %al,(%dx)
Code;  c012bd87 <shrink_cache+397/3b0>
    a:   fc                        cld
Code;  c012bd88 <shrink_cache+398/3b0>
    b:   ff                        (bad)
Code;  c012bd89 <shrink_cache+399/3b0>
    c:   ff c7                     inc    %edi
Code;  c012bd8b <shrink_cache+39b/3b0>
    e:   00 00                     add    %al,(%eax)
Code;  c012bd8d <shrink_cache+39d/3b0>
   10:   00 00                     add    %al,(%eax)
Code;  c012bd8f <shrink_cache+39f/3b0>
   12:   00 e8                     add    %ch,%al

Mar  1 04:03:39 vpn kernel:  kernel BUG at vmscan.c:388!
Mar  1 04:03:39 vpn kernel: invalid operand: 0000
Mar  1 04:03:39 vpn kernel: CPU:    0
Mar  1 04:03:39 vpn kernel: EIP:    0010:[<c012bd7d>]    Not tainted
Mar  1 04:03:39 vpn kernel: EFLAGS: 00010202
Mar  1 04:03:39 vpn kernel: eax: 00000040   ebx: c1015f20   ecx: 
00017480   edx: dbee4000
Mar  1 04:03:39 vpn kernel: esi: c1015f04   edi: 00000000   ebp: 
c02be398   esp: dbee5e38
Mar  1 04:03:39 vpn kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 04:03:39 vpn kernel: Process cat (pid: 18126, stackpage=dbee5000)
Mar  1 04:03:39 vpn kernel: Stack: dbee4000 00000c80 000041f1 000001d2 
00000020 00000020 000001d2 c02be398
Mar  1 04:03:39 vpn kernel:        c02be398 c012bf0f dbee5e7c 0000003c 
000001d2 00000020 c012bf70 dbee5e7c
Mar  1 04:03:39 vpn kernel:        00000000 00000000 00000000 dbee4000 
00000001 c02be398 c012cefe 00011a70
Mar  1 04:03:39 vpn kernel: Call Trace:    [<c012bf0f>] [<c012bf70>] 
[<c012cefe>] [<c012d258>] [<c015a93f>]
Mar  1 04:03:39 vpn kernel:   [<c012520b>] [<c01258fc>] [<c0125cde>] 
[<c0126140>] [<c012628a>] [<c0126140>]
Mar  1 04:03:39 vpn kernel:   [<c0133355>] [<c0106ff3>]
Mar  1 04:03:39 vpn kernel: Code: 0f 0b 84 01 b8 4c 27 c0 e9 ee fc ff ff 
c7 00 00 00 00 00 e8


 >>EIP; c012bd7d <shrink_cache+38d/3b0>   <=====

 >>ebp; c02be398 <contig_page_data+d8/3ac>

Trace; c012bf0f <shrink_caches+2f/40>
Trace; c012bf70 <try_to_free_pages_zone+50/d0>
Trace; c012cefe <balance_classzone+4e/230>
Trace; c012d258 <__alloc_pages+178/270>
Trace; c015a93f <ext3_readpage+f/20>
Trace; c012520b <page_cache_read+6b/c0>
Trace; c01258fc <generic_file_readahead+cc/170>
Trace; c0125cde <do_generic_file_read+30e/470>
Trace; c0126140 <file_read_actor+0/b0>
Trace; c012628a <generic_file_read+9a/180>
Trace; c0126140 <file_read_actor+0/b0>
Trace; c0133355 <sys_read+85/100>
Trace; c0106ff3 <system_call+33/40>

Code;  c012bd7d <shrink_cache+38d/3b0>
00000000 <_EIP>:
Code;  c012bd7d <shrink_cache+38d/3b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012bd7f <shrink_cache+38f/3b0>
    2:   84 01                     test   %al,(%ecx)
Code;  c012bd81 <shrink_cache+391/3b0>
    4:   b8 4c 27 c0 e9            mov    $0xe9c0274c,%eax
Code;  c012bd86 <shrink_cache+396/3b0>
    9:   ee                        out    %al,(%dx)
Code;  c012bd87 <shrink_cache+397/3b0>
    a:   fc                        cld
Code;  c012bd88 <shrink_cache+398/3b0>
    b:   ff                        (bad)
Code;  c012bd89 <shrink_cache+399/3b0>
    c:   ff c7                     inc    %edi
Code;  c012bd8b <shrink_cache+39b/3b0>
    e:   00 00                     add    %al,(%eax)
Code;  c012bd8d <shrink_cache+39d/3b0>
   10:   00 00                     add    %al,(%eax)
Code;  c012bd8f <shrink_cache+39f/3b0>
   12:   00 e8                     add    %ch,%al



Mar  1 04:03:39 vpn kernel:  kernel BUG at vmscan.c:388!
Mar  1 04:03:39 vpn kernel: invalid operand: 0000
Mar  1 04:03:39 vpn kernel: CPU:    0
Mar  1 04:03:39 vpn kernel: EIP:    0010:[<c012bd7d>]    Not tainted
Mar  1 04:03:39 vpn kernel: EFLAGS: 00010202
Mar  1 04:03:39 vpn kernel: eax: 00000040   ebx: c1015f20   ecx: 
0001745d   edx: d9d92000
Mar  1 04:03:39 vpn kernel: esi: c1015f04   edi: 00000000   ebp: 
c02be398   esp: d9d93e38
Mar  1 04:03:39 vpn kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 04:03:39 vpn kernel: Process cat (pid: 18178, stackpage=d9d93000)
Mar  1 04:03:39 vpn kernel: Stack: d9d92000 00000c80 000041ed 000001d2 
00000020 00000020 000001d2 c02be398
Mar  1 04:03:39 vpn kernel:        c02be398 c012bf0f d9d93e7c 0000003c 
000001d2 00000020 c012bf70 d9d93e7c
Mar  1 04:03:39 vpn kernel:        00000000 00000000 00000000 d9d92000 
00000001 c02be398 c012cefe 00000065
Mar  1 04:03:39 vpn kernel: Call Trace:    [<c012bf0f>] [<c012bf70>] 
[<c012cefe>] [<c012d258>] [<c015a93f>]
Mar  1 04:03:39 vpn kernel:   [<c012520b>] [<c01258fc>] [<c0125cde>] 
[<c0126140>] [<c012628a>] [<c0126140>]
Mar  1 04:03:39 vpn kernel:   [<c0133355>] [<c0106ff3>]
Mar  1 04:03:39 vpn kernel: Code: 0f 0b 84 01 b8 4c 27 c0 e9 ee fc ff ff 
c7 00 00 00 00 00 e8


 >>EIP; c012bd7d <shrink_cache+38d/3b0>   <=====

 >>ebp; c02be398 <contig_page_data+d8/3ac>

Trace; c012bf0f <shrink_caches+2f/40>
Trace; c012bf70 <try_to_free_pages_zone+50/d0>
Trace; c012cefe <balance_classzone+4e/230>
Trace; c012d258 <__alloc_pages+178/270>
Trace; c015a93f <ext3_readpage+f/20>
Trace; c012520b <page_cache_read+6b/c0>
Trace; c01258fc <generic_file_readahead+cc/170>
Trace; c0125cde <do_generic_file_read+30e/470>
Trace; c0126140 <file_read_actor+0/b0>
Trace; c012628a <generic_file_read+9a/180>
Trace; c0126140 <file_read_actor+0/b0>
Trace; c0133355 <sys_read+85/100>
Trace; c0106ff3 <system_call+33/40>

Code;  c012bd7d <shrink_cache+38d/3b0>
00000000 <_EIP>:
Code;  c012bd7d <shrink_cache+38d/3b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012bd7f <shrink_cache+38f/3b0>
    2:   84 01                     test   %al,(%ecx)
Code;  c012bd81 <shrink_cache+391/3b0>
    4:   b8 4c 27 c0 e9            mov    $0xe9c0274c,%eax
Code;  c012bd86 <shrink_cache+396/3b0>
    9:   ee                        out    %al,(%dx)
Code;  c012bd87 <shrink_cache+397/3b0>
    a:   fc                        cld
Code;  c012bd88 <shrink_cache+398/3b0>
    b:   ff                        (bad)
Code;  c012bd89 <shrink_cache+399/3b0>
    c:   ff c7                     inc    %edi
Code;  c012bd8b <shrink_cache+39b/3b0>
    e:   00 00                     add    %al,(%eax)
Code;  c012bd8d <shrink_cache+39d/3b0>
   10:   00 00                     add    %al,(%eax)
Code;  c012bd8f <shrink_cache+39f/3b0>
   12:   00 e8                     add    %ch,%al

Mar  1 04:03:39 vpn kernel:  kernel BUG at vmscan.c:388!
Mar  1 04:03:39 vpn kernel: invalid operand: 0000
Mar  1 04:03:39 vpn kernel: CPU:    0
Mar  1 04:03:39 vpn kernel: EIP:    0010:[<c012bd7d>]    Not tainted
Mar  1 04:03:39 vpn kernel: EFLAGS: 00010202
Mar  1 04:03:39 vpn kernel: eax: 00000040   ebx: c1015f20   ecx: 
00017457   edx: dc6e2000
Mar  1 04:03:39 vpn kernel: esi: c1015f04   edi: 00000000   ebp: 
c02be398   esp: dc6e3e24
Mar  1 04:03:39 vpn kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 04:03:39 vpn kernel: Process onlyservice (pid: 18191, 
stackpage=dc6e3000)
Mar  1 04:03:39 vpn kernel: Stack: dc6e2000 00000c80 000041ed 000001d2 
00000020 00000020 000001d2 c02be398
Mar  1 04:03:39 vpn kernel:        c02be398 c012bf0f dc6e3e68 0000003c 
000001d2 00000020 c012bf70 dc6e3e68
Mar  1 04:03:39 vpn kernel:        00000000 00000000 00000000 dc6e2000 
00000001 c02be398 c012cefe c0126ae1
Mar  1 04:03:39 vpn kernel: Call Trace:    [<c012bf0f>] [<c012bf70>] 
[<c012cefe>] [<c0126ae1>] [<c012d258>]
Mar  1 04:03:39 vpn kernel:   [<c01228f1>] [<c0122c09>] [<c01110c3>] 
[<c012af43>] [<c012436b>] [<c01232c9>]
Mar  1 04:03:39 vpn kernel:   [<c0110f70>] [<c0107104>]
Mar  1 04:03:39 vpn kernel: Code: 0f 0b 84 01 b8 4c 27 c0 e9 ee fc ff ff 
c7 00 00 00 00 00 e8


 >>EIP; c012bd7d <shrink_cache+38d/3b0>   <=====

 >>ebp; c02be398 <contig_page_data+d8/3ac>

Trace; c012bf0f <shrink_caches+2f/40>
Trace; c012bf70 <try_to_free_pages_zone+50/d0>
Trace; c012cefe <balance_classzone+4e/230>
Trace; c0126ae1 <filemap_nopage+191/200>
Trace; c012d258 <__alloc_pages+178/270>
Trace; c01228f1 <do_anonymous_page+61/130>
Trace; c0122c09 <handle_mm_fault+59/c0>
Trace; c01110c3 <do_page_fault+153/4c7>
Trace; c012af43 <kmem_cache_free+13/20>
Trace; c012436b <do_brk+11b/210>
Trace; c01232c9 <sys_brk+d9/110>
Trace; c0110f70 <do_page_fault+0/4c7>
Trace; c0107104 <error_code+34/40>

Code;  c012bd7d <shrink_cache+38d/3b0>
00000000 <_EIP>:
Code;  c012bd7d <shrink_cache+38d/3b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012bd7f <shrink_cache+38f/3b0>
    2:   84 01                     test   %al,(%ecx)
Code;  c012bd81 <shrink_cache+391/3b0>
    4:   b8 4c 27 c0 e9            mov    $0xe9c0274c,%eax
Code;  c012bd86 <shrink_cache+396/3b0>
    9:   ee                        out    %al,(%dx)
Code;  c012bd87 <shrink_cache+397/3b0>
    a:   fc                        cld
Code;  c012bd88 <shrink_cache+398/3b0>
    b:   ff                        (bad)
Code;  c012bd89 <shrink_cache+399/3b0>
    c:   ff c7                     inc    %edi
Code;  c012bd8b <shrink_cache+39b/3b0>
    e:   00 00                     add    %al,(%eax)
Code;  c012bd8d <shrink_cache+39d/3b0>
   10:   00 00                     add    %al,(%eax)
Code;  c012bd8f <shrink_cache+39f/3b0>
   12:   00 e8                     add    %ch,%al

It still continues with more oopses...


I don't think I have any hardvare problems and this is
my system:



lspci
00:00.0 Host bridge: Intel Corp. 82865G [Springdale-G] Chipset Host 
Bridge (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82865G [Springdale-G] 
Chipset Integrated Graphics Device (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB USB (Hub #3) (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB USB EHCI Controller #2 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB ICH5 IDE (rev 02)
00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio 
(rev 02)
01:08.0 Ethernet controller: Intel Corp. 82801EB (ICH5) PRO/100 VE 
Ethernet Controller (rev 01)


/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 9
cpu MHz         : 2660.064
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5308.41



gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)



cat /var/log/dmesg
Linux version 2.4.25 (root) (gcc version 3.2.2 20030222 (Red Hat Linux 
3.2.2-5)) #1 Wed Feb 18 21:33:18 EET 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ef30000 (usable)
  BIOS-e820: 000000001ef30000 - 000000001ef40000 (ACPI data)
  BIOS-e820: 000000001ef40000 - 000000001eff0000 (ACPI NVS)
  BIOS-e820: 000000001eff0000 - 000000001f000000 (reserved)
  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126768
zone(0): 4096 pages.
zone(1): 122672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=305 
BOOT_FILE=/boot/bzImage
Initializing CPU#0
Detected 2660.064 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5308.41 BogoMIPS
Memory: 498848k/507072k available (1434k kernel code, 7836k reserved, 
442k data, 276k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 9 for device 01:08.0
eth0: PCI device 8086:1050 (Intel Corp.), 00:0C:F1:79:95:27, IRQ 9.
   Board assembly 000000-000, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0xed626fe2).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 424M
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.2
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
ICH5-SATA: IDE controller at PCI slot 00:1f.2
PCI: Found IRQ 10 for device 00:1f.2
PCI: Sharing IRQ 10 with 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.1
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 10
     ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
blk: queue c0342000, I/O limit 4095Mb (mask 0xffffffff)
hdc: GCR-8523B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, 
UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Intel 810 + AC97 Audio, version 0.24, 21:34:04 Feb 18 2004
PCI: Found IRQ 3 for device 00:1f.5
PCI: Sharing IRQ 3 with 00:1f.3
i810_audio: Pure MMIO interfaces not yet supported.
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:1d.7
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801EB USB2
ehci_hcd 00:1d.7: irq 9, pci mem df802c00
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 00:1d.7
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 8 ports detected
host/usb-uhci.c: $Revision: 1.275 $ time 21:34:09 Feb 18 2004
host/usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 00:02.0
PCI: Sharing IRQ 11 with 00:1d.3
PCI: Setting latency timer of device 00:1d.0 to 64
host/usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
host/usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 5
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:1d.2
PCI: Sharing IRQ 10 with 00:1f.1
PCI: Sharing IRQ 10 with 00:1f.2
PCI: Setting latency timer of device 00:1d.2 to 64
host/usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.3
PCI: Sharing IRQ 11 with 00:02.0
PCI: Sharing IRQ 11 with 00:1d.0
PCI: Setting latency timer of device 00:1d.3 to 64
host/usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver usbscanner
scanner.c: 0.4.16:USB Scanner Driver
usb.c: registered new driver usblp
printer.c: v0.13: USB Printer Device Class driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 2.05
ip_conntrack version 2.1 (3961 buckets, 31688 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,5): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1136009
EXT3-fs: ide0(3,5): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
Adding Swap: 566456k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.




#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_X86_F00F_WORKS_OK is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_IP22 is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IRC=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_AMANDA=y
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_IPSEC=y

#
# IPSec options (FreeS/WAN)
#
CONFIG_IPSEC_AUTH_HMAC_MD5=y
CONFIG_IPSEC_AUTH_HMAC_SHA1=y
CONFIG_IPSEC_ENC_3DES=y

#
#  ESP always enabled with tunnel mode
#
# CONFIG_IPSEC_IPCOMP is not set
CONFIG_IPSEC_DEBUG=y

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200 is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_K8 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_ATI is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_SMB_UNIX is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=y
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_AD1980 is not set
# CONFIG_SOUND_WM97XX is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI=y
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_SL811HS_ALT is not set
# CONFIG_USB_SL811HS is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set

#
#   SCSI support is needed for USB Storage
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
#     Input core support is needed for USB HID input layer or HIDBP support
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=y

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set




