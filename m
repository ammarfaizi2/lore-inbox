Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268171AbRG2VQX>; Sun, 29 Jul 2001 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbRG2VQO>; Sun, 29 Jul 2001 17:16:14 -0400
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:13575 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268171AbRG2VP7>; Sun, 29 Jul 2001 17:15:59 -0400
Date: Sun, 29 Jul 2001 23:16:05 +0200
From: Erik Hensema <erik@hensema.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: OOPS: oops in 2.4.7/cached_lookup()
Message-ID: <20010729231605.A7275@hensema.xs4all.nl>
Reply-To: erik@hensema.xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, my workstation oopses on updatedb every night when running 2.4.7. All
other 2.4.x version seem to work flawlessly.

I am not on the list. I will follow online archives, but please Cc: me on
replies for speedy responses.

[1.] One line summary of the problem:    

Oops in cached_lookup() in 2.4.7.

[2.] Full description of the problem/report:

When running updatedb at night, the find process causes an oops. No other
process causes an oops. All Linux versions up to 2.4.6 were fine, but 2.4.7
is not.

[3.] Keywords (i.e., modules, networking, kernel):

oops, filesystem, find.

[4.] Kernel version (from /proc/version):

2.4.7

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)


ksymoops 2.4.0 on i586 2.4.6.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (specified)
     -m /System.map.2.4.7 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jul 27 16:48:17 dexter kernel: Unable to handle kernel paging request at virtual address 80000004
Jul 27 16:48:17 dexter kernel: c0134dc6
Jul 27 16:48:17 dexter kernel: *pde = 00000000
Jul 27 16:48:17 dexter kernel: Oops: 0000
Jul 27 16:48:17 dexter kernel: CPU:    0
Jul 27 16:48:17 dexter kernel: EIP:    0010:[path_walk+1262/1864]
Jul 27 16:48:17 dexter kernel: EFLAGS: 00010286
Jul 27 16:48:17 dexter kernel: eax: 80000000   ebx: c57dbf68   ecx: 0c340b5a   edx: c5ea10c0
Jul 27 16:48:17 dexter kernel: esi: 00000000   edi: c154bbe0   ebp: c57dbfa4   esp: c57dbf4c
Jul 27 16:48:17 dexter kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 16:48:17 dexter kernel: Process find (pid: 2832, stackpage=c57db000)
Jul 27 16:48:17 dexter kernel: Stack: c9f20000 00000000 c57dbfa4 bffff2cc c01344fe 00000008 00000000 c9f20000 
Jul 27 16:48:17 dexter kernel:        0000000f 0c340b5a c01353d6 c9f2000f c57dbfa4 c57dbfa4 40149e30 0805e3af 
Jul 27 16:48:17 dexter kernel:        c0132695 0805e3af 00000008 c57dbfa4 c57da000 40149e30 c5ea10c0 c13353c0 
Jul 27 16:48:17 dexter kernel: Call Trace: [getname+94/156] [__user_walk+58/84] [sys_lstat64+21/108] [sys_close+67/84] [system_call+51/64] 
Jul 27 16:48:17 dexter kernel: Code: 8b 40 04 85 c0 74 11 53 52 ff d0 89 c6 83 c4 08 85 f6 0f 8c 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 04                  mov    0x4(%eax),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 11                     je     18 <_EIP+0x18> 00000018 Before first symbol
Code;  00000007 Before first symbol
   7:   53                        push   %ebx
Code;  00000008 Before first symbol
   8:   52                        push   %edx
Code;  00000009 Before first symbol
   9:   ff d0                     call   *%eax
Code;  0000000b Before first symbol
   b:   89 c6                     mov    %eax,%esi
Code;  0000000d Before first symbol
   d:   83 c4 08                  add    $0x8,%esp
Code;  00000010 Before first symbol
  10:   85 f6                     test   %esi,%esi
Code;  00000012 Before first symbol
  12:   0f 8c 00 00 00 00         jl     18 <_EIP+0x18> 00000018 Before first symbol

Jul 28 00:18:07 dexter kernel: Unable to handle kernel paging request at virtual address 80000000
Jul 28 00:18:07 dexter kernel: c01346d2
Jul 28 00:18:07 dexter kernel: *pde = 00000000
Jul 28 00:18:07 dexter kernel: Oops: 0000
Jul 28 00:18:07 dexter kernel: CPU:    0
Jul 28 00:18:07 dexter kernel: EIP:    0010:[cached_lookup+30/80]
Jul 28 00:18:07 dexter kernel: EFLAGS: 00010286
Jul 28 00:18:07 dexter kernel: eax: 80000000   ebx: c5ea10c0   ecx: 00000000   edx: 00000006
Jul 28 00:18:07 dexter kernel: esi: 00000000   edi: c1554080   ebp: c38fdfa4   esp: c38fdf38
Jul 28 00:18:07 dexter kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 00:18:07 dexter kernel: Process find (pid: 5225, stackpage=c38fd000)
Jul 28 00:18:07 dexter kernel: Stack: c38fdf68 c0134de9 c6292a20 c38fdf68 00000000 c3242000 00000000 c38fdfa4 
Jul 28 00:18:07 dexter kernel:        bffff5cc c01344fe 00000008 00000000 c3242000 00000006 da68846c c01353d6 
Jul 28 00:18:07 dexter kernel:        c3242006 c38fdfa4 c38fdfa4 40149e30 0805de70 c0132695 0805de70 00000008 
Jul 28 00:18:07 dexter kernel: Call Trace: [path_walk+1297/1864] [getname+94/156] [__user_walk+58/84] [sys_lstat64+21/108] [sys_close+67/84] [system_call+51/64] 
Jul 28 00:18:07 dexter kernel: Code: 8b 00 85 c0 74 26 ff 74 24 10 53 ff d0 83 c4 08 85 c0 75 18 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
   2:   85 c0                     test   %eax,%eax
Code;  00000004 Before first symbol
   4:   74 26                     je     2c <_EIP+0x2c> 0000002c Before first symbol
Code;  00000006 Before first symbol
   6:   ff 74 24 10               pushl  0x10(%esp,1)
Code;  0000000a Before first symbol
   a:   53                        push   %ebx
Code;  0000000b Before first symbol
   b:   ff d0                     call   *%eax
Code;  0000000d Before first symbol
   d:   83 c4 08                  add    $0x8,%esp
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   75 18                     jne    2c <_EIP+0x2c> 0000002c Before first symbol

[6.] A small shell script or example program which triggers the
     problem (if possible)

updatedb

[7.] Environment

Suse 7.1, pretty standard.

[7.1.] Software (add the output of the ver_linux script here)


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux dexter 2.4.6 #3 Wed Jul 4 11:17:49 CEST 2001 i586 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
mount                  2.10q
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.22
Linux C Library        x    1 root     root      1382179 Feb 28 22:21 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         ne 8390 ipt_MASQUERADE ip_nat_ftp ipt_state ipt_LOG ipt_limit iptable_nat iptable_filter ip_conntrack_ftp ip_conntrack ip_tables tulip es1370 soundcore

(same modules loaded under 2.4.7)

[7.2.] Processor information (from /proc/cpuinfo):


processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 0
cpu MHz		: 300.687
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx syscall 3dnow
bogomips	: 599.65

A 300 Mhz AMD K6-2

[7.3.] Module information (from /proc/modules):

See output of ver_linux.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

Not applicable, AFAIK. Please mail for more info, I'm happy to provide it.

-- 
Erik Hensema (erik@hensema.xs4all.nl)
