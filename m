Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288829AbSAEOvD>; Sat, 5 Jan 2002 09:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSAEOuz>; Sat, 5 Jan 2002 09:50:55 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:32531 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S288831AbSAEOui>;
	Sat, 5 Jan 2002 09:50:38 -0500
Date: Sat, 5 Jan 2002 15:40:05 +0100
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [Oops]: Kernel 2.4.17: postfix startup crash, ksymoops output attached
Message-ID: <20020105144005.GA20619@obelix.gallien.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I received the following oops today when postfix (Debian version
0.0.20010502.SNAPSHOT+tls-0.7.2-1) started (well, it tried).

The system is a 700MHz Athlon (not overclocked) using a 10GB IDE hdd 
and ext3 jfs. This is my 'workstation' and was under light load only.
Kernel 2.4.17 is built for Athlons.

More details available on request. 

Here we go:

[4.] Kernel version (from /proc/version):
Linux version 2.4.17-a1 (root@asterix) (gcc version 2.95.4 20011006 
   (Debian prerelease)) #1 Sam Dez 22 13:39:51 CET 2001


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Unable to handle kernel paging request at virtual address 01010000
 printing eip:
 c013d7f0
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[<c013d7f0>]    Not tainted
 EFLAGS: 00010207
 eax: c1fde000   ebx: 0100fff0   ecx: 00000011   edx: 00002281
 esi: 00000000   edi: f6a2dfa4   ebp: 01010000   esp: f6a2df14
 ds: 0018   es: 0018   ss: 0018
 Process qmgr (pid: 2528, stackpage=f6a2d000)
 Stack: f6a2df74 00000000 f6a2dfa4 f6656280 c1fde000 f0b3700b 00002281 00000001
        c0135a30 f666dac0 f6a2df74 f6a2df74 c01360d8 f666dac0 f6a2df74 00000000
       f0b37000 00000000 f6a2dfa4 00000009 c013582d 00000009 f0b3700c 00000000
Call Trace: [<c0135a30>] [<c01360d8>] [<c013582d>] [<c013632a>] [<c01366b5>] [<c0133909>] [<c012d2f3>] [<c0106c4b>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75

--------------------------------------------

Ksymoops output :

ksymoops 2.4.1 on i686 2.4.17-a1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-a1/ (default)
     -m /boot/System.map-2.4.17-a1 (specified)

Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says fa8bf344, /lib/modules/2.4.17-a1/kernel/drivers/scsi/sr_mod.o says fa8bf260.  Ignoring /lib/modules/2.4.17-a1/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says fa8987d0, /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o says fa897c40.  Ignoring /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says fa88b924, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88b604.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says fa88b928, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88b608.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says fa88b92c, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88b60c.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says fa88b920, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88b600.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Unable to handle kernel paging request at virtual address 01010000
 c013d7f0
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[<c013d7f0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010207
 eax: c1fde000   ebx: 0100fff0   ecx: 00000011   edx: 00002281
 esi: 00000000   edi: f6a2dfa4   ebp: 01010000   esp: f6a2df14
 ds: 0018   es: 0018   ss: 0018
 Process qmgr (pid: 2528, stackpage=f6a2d000)
 Stack: f6a2df74 00000000 f6a2dfa4 f6656280 c1fde000 f0b3700b 00002281 00000001
        c0135a30 f666dac0 f6a2df74 f6a2df74 c01360d8 f666dac0 f6a2df74 00000000
       f0b37000 00000000 f6a2dfa4 00000009 c013582d 00000009 f0b3700c 00000000
Call Trace: [<c0135a30>] [<c01360d8>] [<c013582d>] [<c013632a>] [<c01366b5>] [<c0133909>] [<c012d2f3>] [<c0106c4b>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75

>>EIP; c013d7f0 <d_lookup+60/100>   <=====
Trace; c0135a30 <cached_lookup+10/60>
Trace; c01360d8 <link_path_walk+4a8/6e0>
Trace; c013582d <getname+5d/a0>
Trace; c013632a <path_walk+1a/20>
Trace; c01366b5 <__user_walk+35/50>
Trace; c0133909 <sys_stat64+19/70>
Trace; c012d2f3 <sys_close+43/60>
Trace; c0106c4b <system_call+33/38>
Code;  c013d7f0 <d_lookup+60/100>
00000000 <_EIP>:
Code;  c013d7f0 <d_lookup+60/100>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c013d7f3 <d_lookup+63/100>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c013d7f7 <d_lookup+67/100>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c013d7fa <d_lookup+6a/100>
   a:   75 7c                     jne    88 <_EIP+0x88> c013d878 <d_lookup+e8/100>
Code;  c013d7fc <d_lookup+6c/100>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c013d800 <d_lookup+70/100>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c013d803 <d_lookup+73/100>
  13:   75 00                     jne    15 <_EIP+0x15> c013d805 <d_lookup+75/100>

[6.] A small shell script or example program which triggers the
     problem (if possible)

N.A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
asterix:/var/tmp# /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux asterix 2.4.17-a1 #1 Sam Dez 22 13:39:51 CET 2001 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.11
e2fsprogs              1.25
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nls_iso8859-1 sr_mod cdrom isofs nfs lockd sunrpc
	parport_pc lp parport matroxfb_maven matroxfb_crtc2 cs46xx ac97_codec
	soundcore i2c-matroxfb i2c-algo-bit i2c-core apm ide-scsi rtc


[7.2.] Processor information (from /proc/cpuinfo):

asterix:/usr/src/linux# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 706.293
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
bogomips        : 1409.02

[7.3.] Module information (from /proc/modules):
asterix:/usr/src/linux# cat /proc/modules
nls_iso8859-1           2880   0 (autoclean)
sr_mod                 13144   0 (autoclean)
cdrom                  28960   0 (autoclean) [sr_mod]
isofs                  17600   0 (autoclean)
nfs                    70908   0 (autoclean)
lockd                  48288   0 (autoclean) [nfs]
sunrpc                 59700   0 (autoclean) [nfs lockd]
parport_pc             14596   1 (autoclean)
lp                      6176   0 (autoclean)
parport                24960   1 (autoclean) [parport_pc lp]
matroxfb_maven          9152   0 (unused)
matroxfb_crtc2          6816   0 (unused)
cs46xx                 54888   0 (autoclean)
ac97_codec              9696   0 (autoclean) [cs46xx]
soundcore               3588   3 (autoclean) [cs46xx]
i2c-matroxfb            3200   0 (unused)
i2c-algo-bit            7148   3 [i2c-matroxfb]
i2c-core               12992   0 [matroxfb_maven i2c-algo-bit]
apm                     9164   1
ide-scsi                7648   0
rtc                     5592   0 (autoclean)

