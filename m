Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132936AbREEQzG>; Sat, 5 May 2001 12:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbREEQy5>; Sat, 5 May 2001 12:54:57 -0400
Received: from wb1-a.mail.utexas.edu ([128.83.126.134]:33802 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S132936AbREEQyr>;
	Sat, 5 May 2001 12:54:47 -0400
Message-ID: <3AF387ED.7250C0D0@mail.utexas.edu>
Date: Sat, 05 May 2001 10:56:13 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Athlon/VIA/2.4.4 kernel NULL pointer dereference.
Content-Type: multipart/mixed;
 boundary="------------CC6B986197ED21B0F01A364B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CC6B986197ED21B0F01A364B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

May  5 10:29:24 pollux kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000014

Thereafter, almost nothing on the system worked.

This was within minutes of booting, and thus isn't the result of
long-term corruption.

The system is an Athlon on an Epox 8KTA3 (=VIA), with BIOS flashed up to
17-Apr-2001.

The kernel is 2.4.4, compiled as a PIII (since I still can't get an
Athlon kernel to boot on this machine.)

The ksymoops is attached (to prevent wraps).

=====
% cat /proc/version
Linux version 2.4.4 (root@pollux.dioscuri) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #4 Sat Apr 28 19:54:44 GMT-6 2001

=====
% cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1202.769
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2398.61

=====
%  cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
3).
      Master Capable.  Latency=8.
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
64).
  Bus  0, device  10, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20267 (rev
2).
      IRQ 11.
      Master Capable.  Latency=32.
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xcc00 [0xcc07].
      I/O at 0xd000 [0xd003].
      I/O at 0xdc00 [0xdc3f].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda01ffff].
  Bus  0, device  11, function  0:
    Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 1).

      IRQ 5.
      I/O at 0xe000 [0xe007].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xda020000 [0xda0200ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
130).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd4000000 [0xd5ffffff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6003fff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd77fffff].

=====

Bobby Bryant
Austin, Texas


--------------CC6B986197ED21B0F01A364B
Content-Type: text/plain; charset=us-ascii;
 name="temp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temp.txt"

ksymoops 2.4.0 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May  5 10:29:24 pollux kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
May  5 10:29:24 pollux kernel: c014b9ca
May  5 10:29:24 pollux kernel: *pde = 00000000
May  5 10:29:24 pollux kernel: Oops: 0000
May  5 10:29:24 pollux kernel: CPU:    0
May  5 10:29:24 pollux kernel: EIP:    0010:[ext2_new_block+158/2072]
May  5 10:29:24 pollux kernel: EIP:    0010:[<c014b9ca>]
Using defaults from ksymoops -t elf32-i386 -a i386
May  5 10:29:24 pollux kernel: EFLAGS: 00010216
May  5 10:29:24 pollux kernel: eax: 00000000   ebx: ef204400   ecx: e9299a00   edx: e9e5fd9c
May  5 10:29:24 pollux kernel: esi: efd71a00   edi: 0000ccd9   ebp: 00000000   esp: e9e5fd38
May  5 10:29:24 pollux kernel: ds: 0018   es: 0018   ss: 0018
May  5 10:29:24 pollux kernel: Process netscape-commun (pid: 1260, stackpage=e9e5f000)
May  5 10:29:24 pollux kernel: Stack: e9299a00 00040000 e9e5fe14 00000000 00000000 00000000 efd71a00 00000014 
May  5 10:29:24 pollux kernel:        c014d789 ea2d69c0 00000000 e9e5fddc e9e5fee8 ea2d69c0 00000000 00000000 
May  5 10:29:24 pollux kernel:        00000000 e9e5fdc0 00000001 e9e5fdac ef204400 03030000 e9e5fda8 e9e5fddc 
May  5 10:29:24 pollux kernel: Call Trace: [ext2_get_block+45/1300] [ext2_alloc_block+116/124] [ext2_alloc_branch+50/612] [ext2_getblk+111/288] [ext2_get_block+0/1300] [ext2_get_block+820/1300] [ext2_get_block+0/1300] 
May  5 10:29:24 pollux kernel: Call Trace: [<c014d789>] [<c014d3dc>] [<c014d52a>] [<c014dcdf>] [<c014d75c>] [<c014da90>] [<c014d75c>] 
May  5 10:29:24 pollux kernel:        [<c0120c80>] [<c01313e8>] [<c0131721>] [<c0131ed2>] [<c014d75c>] [<c014dee5>] [<c014d75c>] [<c0125928>] 
May  5 10:29:24 pollux kernel:        [<c012f316>] [<c0106ae7>] 
May  5 10:29:24 pollux kernel: Code: 8b 68 14 89 54 24 2c 39 6c 24 70 72 09 8b 5c 24 70 3b 58 04 

>>EIP; c014b9ca <ext2_new_block+9e/818>   <=====
Trace; c014d789 <ext2_get_block+2d/514>
Trace; c014d3dc <ext2_alloc_block+74/7c>
Trace; c014d52a <ext2_alloc_branch+32/264>
Trace; c014dcdf <ext2_getblk+6f/120>
Trace; c014d75c <ext2_get_block+0/514>
Trace; c014da90 <ext2_get_block+334/514>
Trace; c014d75c <ext2_get_block+0/514>
Trace; c0120c80 <do_anonymous_page+34/90>
Trace; c01313e8 <create_empty_buffers+18/6c>
Trace; c0131721 <__block_prepare_write+fd/248>
Trace; c0131ed2 <block_prepare_write+22/3c>
Trace; c014d75c <ext2_get_block+0/514>
Trace; c014dee5 <ext2_prepare_write+19/20>
Trace; c014d75c <ext2_get_block+0/514>
Trace; c0125928 <generic_file_write+424/5bc>
Trace; c012f316 <sys_write+92/c8>
Trace; c0106ae7 <system_call+33/38>
Code;  c014b9ca <ext2_new_block+9e/818>
00000000 <_EIP>:
Code;  c014b9ca <ext2_new_block+9e/818>   <=====
   0:   8b 68 14                  mov    0x14(%eax),%ebp   <=====
Code;  c014b9cd <ext2_new_block+a1/818>
   3:   89 54 24 2c               mov    %edx,0x2c(%esp,1)
Code;  c014b9d1 <ext2_new_block+a5/818>
   7:   39 6c 24 70               cmp    %ebp,0x70(%esp,1)
Code;  c014b9d5 <ext2_new_block+a9/818>
   b:   72 09                     jb     16 <_EIP+0x16> c014b9e0 <ext2_new_block+b4/818>
Code;  c014b9d7 <ext2_new_block+ab/818>
   d:   8b 5c 24 70               mov    0x70(%esp,1),%ebx
Code;  c014b9db <ext2_new_block+af/818>
  11:   3b 58 04                  cmp    0x4(%eax),%ebx


1 warning issued.  Results may not be reliable.

--------------CC6B986197ED21B0F01A364B--

