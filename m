Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281822AbRKWOYU>; Fri, 23 Nov 2001 09:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281776AbRKWOYN>; Fri, 23 Nov 2001 09:24:13 -0500
Received: from [194.158.195.131] ([194.158.195.131]:37760 "HELO ns1.4enet.by")
	by vger.kernel.org with SMTP id <S281560AbRKWOXz>;
	Fri, 23 Nov 2001 09:23:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: =?koi8-r?b?4sXSxdrBIPLPzcHO?= <b_rom_s@4enet.by>
Reply-To: b_rom_s@4enet.by
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Morning Kernel oops
Date: Fri, 23 Nov 2001 16:25:34 -0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011123142404Z281560-17408+17846@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(in bad English)
1. Morning Kernel oops

2. Start KDE at morning will result kernel oops, all other daytime everything 
is OK. This situation located at two unplugged hosts with different 
configurations. Problems was started when i have updated window manager

a) Linux  2.4.10 host 1
/dev/sda6 on / type reiserfs (rw)
KDE2.1.1 : 
Oopses every time kde loading after updatedb script or after "find / -fstype 
nfs -prune -o print command":

Nov 22 10:56:51 ns1 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000000
Nov 22 10:56:51 ns1 kernel: c013ca08
Nov 22 10:56:51 ns1 kernel: *pde = 00000000
Nov 22 10:56:51 ns1 kernel: Oops: 0000
Nov 22 10:56:51 ns1 kernel: CPU:    0
Nov 22 10:56:51 ns1 kernel: EIP:    0010:[d_lookup+92/244]
Nov 22 10:56:51 ns1 kernel: EFLAGS: 00010213
Nov 22 10:56:51 ns1 kernel: eax: cfeb5e98   ebx: fffffff0   ecx: 0000000f   
edx: b725b32f
Nov 22 10:56:51 ns1 kernel: esi: 00000000   edi: cddb3ba0   ebp: 00000000   
esp: c072fefc
Nov 22 10:56:51 ns1 kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 10:56:51 ns1 kernel: Process ksplash (pid: 1031, stackpage=c072f000)
Nov 22 10:56:51 ns1 kernel: Stack: c072ff58 00000000 cddb3ba0 c072ffa4 
cfeb5e98 c0b3a02c b725b32f 0000000b
Nov 22 10:56:51 ns1 kernel:        c0134cc4 cddbb960 c072ff58 c072ff58 
c0135342 cddbb960 c072ff58 00000000
Nov 22 10:56:51 ns1 kernel:        c0b3a000 00000000 c072ffa4 00000000 
c0134add 00000009 00000000 c0b3a02c
Nov 22 10:56:51 ns1 kernel: Call Trace: [cached_lookup+16/84] 
[path_walk+1178/1736] [getname+93/156] [__user_walk+60/88] 
[sys_access+137/292]
Nov 22 10:56:51 ns1 kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 
24 24 39 43 0c 75

Code;  c0139f68 <flock64_to_posix_lock+98/110>
00000000 <_EIP>:
Code;  c0139f68 <flock64_to_posix_lock+98/110>
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  c0139f6b <flock64_to_posix_lock+9b/110>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c0139f6f <flock64_to_posix_lock+9f/110>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0139f72 <flock64_to_posix_lock+a2/110>
   a:   75 74                     jne    80 <_EIP+0x80> c0139fe8 
<lease_alloc+8/f0>
Code;  c0139f74 <flock64_to_posix_lock+a4/110>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0139f78 <flock64_to_posix_lock+a8/110>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0139f7b <flock64_to_posix_lock+ab/110>
  13:   75 00                     jne    15 <_EIP+0x15> c0139f7d 
<flock64_to_posix_lock+ad/110>


Nov 22 10:56:52 ns1 kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 22 10:56:52 ns1 kernel: c013ca08
Nov 22 10:56:52 ns1 kernel: *pde = 00000000
Nov 22 10:56:52 ns1 kernel: Oops: 0000
Nov 22 10:56:52 ns1 kernel: CPU:    0
Nov 22 10:56:52 ns1 kernel: EIP:    0010:[d_lookup+92/244]
Nov 22 10:56:52 ns1 kernel: EFLAGS: 00010217
Nov 22 10:56:52 ns1 kernel: eax: cfea9eb8   ebx: fffffff0   ecx: 0000000f   
edx: cb164785
Nov 22 10:56:52 ns1 kernel: esi: 00000000   edi: cdd4e840   ebp: 00000000   
esp: c0719f0c
Nov 22 10:56:52 ns1 kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 10:56:52 ns1 kernel: Process kdeinit (pid: 1053, stackpage=c0719000)
Nov 22 10:56:52 ns1 kernel: Stack: c0719f68 00000000 cdd4e840 c0719fa4 
cfea9eb8 ce501019 cb164785 00000012
Nov 22 10:56:52 ns1 kernel:        c0134cc4 cdd52b20 c0719f68 c0719f68 
c0135342 cdd52b20 c0719f68 00000000
Nov 22 10:56:52 ns1 kernel:        ce501000 00000000 c0719fa4 bffff040 
c0134add 00000008 00000000 ce501019
Nov 22 10:56:52 ns1 kernel: Call Trace: [cached_lookup+16/84] 
[path_walk+1178/1736] [getname+93/156] [__user_walk+60/88] 
[sys_lstat64+22/112]
Nov 22 10:56:52 ns1 kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 
24 24 39 43 0c 75

Code;  c0139f68 <flock64_to_posix_lock+98/110>
00000000 <_EIP>:
Code;  c0139f68 <flock64_to_posix_lock+98/110>
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  c0139f6b <flock64_to_posix_lock+9b/110>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c0139f6f <flock64_to_posix_lock+9f/110>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0139f72 <flock64_to_posix_lock+a2/110>
   a:   75 74                     jne    80 <_EIP+0x80> c0139fe8 
<lease_alloc+8/f0>
Code;  c0139f74 <flock64_to_posix_lock+a4/110>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0139f78 <flock64_to_posix_lock+a8/110>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0139f7b <flock64_to_posix_lock+ab/110>
  13:   75 00                     jne    15 <_EIP+0x15> c0139f7d 
<flock64_to_posix_lock+ad/110>

and so on...

b) Linux  2.4.10 host 1
/dev/sda6 on / type reiserfs (rw)
KDE2.2.1 : 
Oopses every morning while kde loading,  not after updatedb script nor after 
"find / -fstype nfs -prune -o print command"

Nov 23 09:35:21 ns1 kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 23 09:35:21 ns1 kernel: c013ca08
Nov 23 09:35:21 ns1 kernel: *pde = 00000000
Nov 23 09:35:21 ns1 kernel: Oops: 0000
Nov 23 09:35:21 ns1 kernel: CPU:    0
Nov 23 09:35:21 ns1 kernel: EIP:    0010:[d_lookup+92/244]
Nov 23 09:35:21 ns1 kernel: EFLAGS: 00013203
Nov 23 09:35:21 ns1 kernel: eax: cfe9f980   ebx: fffffff0   ecx: 0000000f   
edx: 29d10a8c
Nov 23 09:35:21 ns1 kernel: esi: 00000000   edi: c7b57d80   ebp: 00000000   
esp: cd535ed8
Nov 23 09:35:21 ns1 kernel: ds: 0018   es: 0018   ss: 0018
Nov 23 09:35:21 ns1 kernel: Process X (pid: 14153, stackpage=cd535000)
Nov 23 09:35:21 ns1 kernel: Stack: cd535f34 00000000 c7b57d80 cd535f8c 
cfe9f980 c24e4011 29d10a8c 00000008
Nov 23 09:35:21 ns1 kernel:        c0134cc4 cd3a9720 cd535f34 cd535f34 
c0135342 cd3a9720 cd535f34 00000000
Nov 23 09:35:21 ns1 kernel:        c24e4000 00000000 00000000 00000001 
c017a2be 00000001 00000000 c24e4011
Nov 23 09:35:21 ns1 kernel: Call Trace: [cached_lookup+16/84] 
[path_walk+1178/1736] [reiserfs_delete_inode+126/144] [open_namei+134/1452] 
[filp_open+59/92]
Nov 23 09:35:21 ns1 kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 
24 24 39 43 0c 75

Code;  c0139f68 <flock64_to_posix_lock+98/110>
00000000 <_EIP>:
Code;  c0139f68 <flock64_to_posix_lock+98/110>
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  c0139f6b <flock64_to_posix_lock+9b/110>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c0139f6f <flock64_to_posix_lock+9f/110>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0139f72 <flock64_to_posix_lock+a2/110>
   a:   75 74                     jne    80 <_EIP+0x80> c0139fe8 
<lease_alloc+8/f0>
Code;  c0139f74 <flock64_to_posix_lock+a4/110>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0139f78 <flock64_to_posix_lock+a8/110>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0139f7b <flock64_to_posix_lock+ab/110>
  13:   75 00                     jne    15 <_EIP+0x15> c0139f7d 
<flock64_to_posix_lock+ad/110>

c) Linux 2.4.0 host  2
/dev/sda6 on / type reiserfs (rw)
KDE 2.1.1
Same as a)

Nov 16 10:28:35 ns2 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000020
Nov 16 10:28:35 ns2 kernel: c01433bc
Nov 16 10:28:35 ns2 kernel: *pde = 00000000
Nov 16 10:28:35 ns2 kernel: Oops: 0000
Nov 16 10:28:35 ns2 kernel: CPU:    0
Nov 16 10:28:35 ns2 kernel: EIP:    0010:[find_inode+28/72]
Nov 16 10:28:35 ns2 kernel: EFLAGS: 00010207
Nov 16 10:28:35 ns2 kernel: eax: 00000000   ebx: 00000000   ecx: 0000001c   
edx: 000019e2
Nov 16 10:28:35 ns2 kernel: esi: 00000000   edi: 00000000   ebp: 00009b70   
esp: c8e43e20
Nov 16 10:28:35 ns2 kernel: ds: 0018   es: 0018   ss: 0018
Nov 16 10:28:35 ns2 kernel: Process ksplash (pid: 4977, stackpage=c8e43000)
Nov 16 10:28:35 ns2 kernel: Stack: 00000000 cfeccf10 00009b70 cf969000 
c0143781 cf969000 00009b70 cfeccf10
Nov 16 10:28:35 ns2 kernel:        00000000 c8e43e74 00000000 c8e43ef8 
c8e43e94 c64139c0 c01824a0 cf969000
Nov 16 10:28:35 ns2 kernel:        00009b70 00000000 c8e43e74 00000000 
00000001 000098dc c017ed48 cf969000
Nov 16 10:28:35 ns2 kernel: Call Trace: [iget4+69/204] [reiserfs_iget+36/100] 
[reiserfs_lookup+148/196] [real_lookup+83/196] [path_walk+1381/1964] 
[getname+91/152] [__user_walk+60/88]
Nov 16 10:28:35 ns2 kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 8c 00 00 
00 75 e3 85 ff 74

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6e 20                  cmp    %ebp,0x20(%esi)
Code;  00000003 Before first symbol
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 
<END_OF_CODE+2f1e8421/????>
Code;  00000005 Before first symbol
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  00000009 Before first symbol
   9:   39 86 8c 00 00 00         cmp    %eax,0x8c(%esi)
Code;  0000000f Before first symbol
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 
<END_OF_CODE+2f1e8421/????>
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first 
symbol

Nov 22 09:35:50 ns2 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000020
Nov 22 09:35:50 ns2 kernel: c01433bc
Nov 22 09:35:50 ns2 kernel: *pde = 00000000
Nov 22 09:35:50 ns2 kernel: Oops: 0000
Nov 22 09:35:50 ns2 kernel: CPU:    0
Nov 22 09:35:50 ns2 kernel: EIP:    0010:[find_inode+28/72]
Nov 22 09:35:50 ns2 kernel: EFLAGS: 00010203
Nov 22 09:35:50 ns2 kernel: eax: 00000000   ebx: 00000000   ecx: 0000001c   
edx: 00001084
Nov 22 09:35:50 ns2 kernel: esi: 00000000   edi: 00000000   ebp: 0000a212   
esp: c44f7e20
Nov 22 09:35:50 ns2 kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 09:35:50 ns2 kernel: Process kdeinit (pid: 13871, stackpage=c44f7000)
Nov 22 09:35:50 ns2 kernel: Stack: 00000000 cfec8420 0000a212 cf969000 
c0143781 cf969000 0000a212 cfec8420
Nov 22 09:35:51 ns2 kernel:        00000000 c44f7e74 00000000 c44f7ef8 
c44f7e94 c817cee0 c01824a0 cf969000
Nov 22 09:35:51 ns2 kernel:        0000a212 00000000 c44f7e74 00000000 
00000001 0000a1e5 c017ed48 cf969000
Nov 22 09:35:51 ns2 kernel: Call Trace: [iget4+69/204] [reiserfs_iget+36/100] 
[reiserfs_lookup+148/196] [real_lookup+83/196] [path_walk+1381/1964] 
[getname+91/152] [__user_walk+60/88]
Nov 22 09:35:51 ns2 kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 8c 00 00 
00 75 e3 85 ff 74

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6e 20                  cmp    %ebp,0x20(%esi)
Code;  00000003 Before first symbol
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 
<END_OF_CODE+2f1e8421/????>
Code;  00000005 Before first symbol
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  00000009 Before first symbol
   9:   39 86 8c 00 00 00         cmp    %eax,0x8c(%esi)
Code;  0000000f Before first symbol
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 
<END_OF_CODE+2f1e8421/????>
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first 
symbol

and so on...

d) Linux 2.4.0 host 2
/dev/sda6 on / type reiserfs (rw)
KDE 2.2.1
Same as b)

Nov 22 09:37:34 ns2 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000020
Nov 22 09:37:34 ns2 kernel: c01433bc
Nov 22 09:37:34 ns2 kernel: *pde = 00000000
Nov 22 09:37:34 ns2 kernel: Oops: 0000
Nov 22 09:37:34 ns2 kernel: CPU:    0
Nov 22 09:37:34 ns2 kernel: EIP:    0010:[find_inode+28/72]
Nov 22 09:37:34 ns2 kernel: EFLAGS: 00010203
Nov 22 09:37:34 ns2 kernel: eax: 00000000   ebx: 00000000   ecx: 0000001c   
edx: 000010bc
Nov 22 09:37:34 ns2 kernel: esi: 00000000   edi: 00000000   ebp: 000002ca   
esp: cc45fe20
Nov 22 09:37:34 ns2 kernel: ds: 0018   es: 0018   ss: 0018
Nov 22 09:37:34 ns2 kernel: Process showconsole (pid: 14033, 
stackpage=cc45f000)
Nov 22 09:37:34 ns2 kernel: Stack: 00000000 cfec85e0 000002ca cf969000 
c0143781 cf969000 000002ca cfec85e0
Nov 22 09:37:34 ns2 kernel:        00000000 cc45fe74 00000000 cc45fef8 
cc45fe94 ca2eb520 c01824a0 cf969000
Nov 22 09:37:34 ns2 kernel:        000002ca 00000000 cc45fe74 00000000 
00000001 000002c5 c017ed48 cf969000
Nov 22 09:37:34 ns2 kernel: Call Trace: [iget4+69/204] [reiserfs_iget+36/100] 
[reiserfs_lookup+148/196] [real_lookup+83/196] [path_walk+1381/1964] 
[getname+91/152] [__user_walk+60/88]
Nov 22 09:37:34 ns2 kernel: Code: 39 6e 20 75 ef 8b 44 24 14 39 86 8c 00 00 
00 75 e3 85 ff 74

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6e 20                  cmp    %ebp,0x20(%esi)
Code;  00000003 Before first symbol
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 
<END_OF_CODE+2f1e8421/????>
Code;  00000005 Before first symbol
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  00000009 Before first symbol
   9:   39 86 8c 00 00 00         cmp    %eax,0x8c(%esi)
Code;  0000000f Before first symbol
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4> fffffff4 
<END_OF_CODE+2f1e8421/????>
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first 
symbol

e) Linux 2.4.14 host 1
sorry oopses wasn't  ksymoops-ed


Environment: 

host 1) 

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
mount                  2.10q
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1382179 Jan 19  2001 
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         ipt_multiport iptable_mangle iptable_nat ip_conntrack 
iptable_filter ip_tables md

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 6
cpu MHz         : 668.194
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1333.65

ipt_multiport            640   8 (autoclean)
iptable_mangle          1696   0 (autoclean) (unused)
iptable_nat            17616   0 (autoclean) (unused)
ip_conntrack           18912   1 (autoclean) [iptable_nat]
iptable_filter          1696   0 (autoclean) (unused)
ip_tables              12576   6 [ipt_multiport iptable_mangle iptable_nat 
iptable_filter]
md                     43232   0 (autoclean)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : Adaptec 7892A
    c000-c0ff : aic7xxx
  c400-c4ff : Realtek Semiconductor Co., Ltd. RTL-8139
    c400-c4ff : 8139too
d000-d01f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
  d000-d01f : usb-uhci
d800-d81f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
  d800-d81f : usb-uhci
dc00-dcff : Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller
e000-e03f : Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller
f000-f00f : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d25ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-002552e3 : Kernel code
  002552e4-002bbe73 : Kernel data
0fef0000-0fef2fff : ACPI Non-volatile Storage
0fef3000-0fefffff : ACPI Tables
d0000000-d3ffffff : Intel Corp. 82815 CGC [Chipset Graphics Controller]
d4000000-d5ffffff : PCI Bus #01
  d5000000-d5000fff : Adaptec 7892A
    d5000000-d5000fff : aic7xxx
  d5001000-d50010ff : Realtek Semiconductor Co., Ltd. RTL-8139
    d5001000-d50010ff : 8139too
d6000000-d607ffff : Intel Corp. 82815 CGC [Chipset Graphics Controller]
ffb00000-ffffffff : reserved

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 02)
        Subsystem: Intel Corporation 82815 815 Chipset Host Bridge and Memory 
Controller Hub
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset 
Graphics Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 1001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 
02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA Bridge 
(ICH2) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE 
U100 (rev 02) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB 
(Hub A) (rev 02) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB 
(Hub B) (rev 02) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82820 820 (Camino 2) 
Chipset AC'97 Audio Controller (rev 02)
        Subsystem: Unknown device 8384:7600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=64]

01:01.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device e2a0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Regi    Region 1: Memory at d5000000 (64-bit, non-prefetchable) 
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at d5001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03

host 2)  

Linux ns2 2.4.0-4GB #1 Mon Jan 22 16:42:16 GMT 2001 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
mount                  2.10q
modutils               2.4.1
e2fsprogs              1.19
reiserfsprogs          3.5.29
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1382179 Jan 19  2001 
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss 
snd-card-intel8x0 snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-mixer snd 
soundcore ipv6 i810 agpgart parport_pc lp parport mousedev hid input usb-uhci 
8139too ipt_multiport iptable_mangle iptable_nat ip_conntrack iptable_filter 
ip_tables usbcore aic7xxx

CPU - same as host 1)

snd-pcm-oss            19696   0 (autoclean)
snd-pcm-plugin         15632   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           5248   0 (autoclean) [snd-pcm-oss]
snd-card-intel8x0       2640   0 (autoclean)
snd-intel8x0            8464   0 (autoclean) [snd-card-intel8x0]
snd-pcm                36864   0 (autoclean) [snd-pcm-oss snd-pcm-plugin 
snd-intel8x0]
snd-timer              10784   0 (autoclean) [snd-pcm]
snd-ac97-codec         27392   0 (autoclean) [snd-intel8x0]
snd-mixer              28176   0 (autoclean) [snd-mixer-oss snd-ac97-codec]
snd                    42672   1 (autoclean) [snd-pcm-oss snd-pcm-plugin 
snd-mixer-oss snd-card-intel8x0 snd-intel8x0 snd-pcm snd-timer snd-ac97-codec 
snd-mixer]
soundcore               3664   2 (autoclean) [snd]
ipv6                  117744  -1 (autoclean)
i810                   76144   1
agpgart                21136   7 (autoclean)
parport_pc             13456   1 (autoclean)
lp                      4656   0 (autoclean)
parport                12736   1 (autoclean) [parport_pc lp]
mousedev                3968   0 (unused)
hid                    11744   0 (unused)
input                   3104   0 [mousedev hid]
usb-uhci               21712   0 (unused)
8139too                16128   1 (autoclean)
ipt_multiport            880   8 (autoclean)
iptable_mangle          1888   0 (autoclean) (unused)
iptable_nat            12448   0 (autoclean) (unused)
ip_conntrack           12544   1 (autoclean) [iptable_nat]
iptable_filter          1856   0 (autoclean) (unused)
ip_tables              10144   6 [ipt_multiport iptable_mangle iptable_nat 
iptable_filter]
usbcore                46480   1 [hid usb-uhci]
aic7xxx               131072   3

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f0-03f5 : floppy
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : PCI device 9005:0080
    c000-c0fe : aic7xxx
  c400-c4ff : PCI device 10ec:8139
    c400-c4ff : eth0
d000-d01f : PCI device 8086:2442
  d000-d01f : usb-uhci
d800-d81f : PCI device 8086:2444
  d800-d81f : usb-uhci
dc00-dcff : PCI device 8086:2445
  dc00-dcff : Intel ICH - AC'97
e000-e03f : PCI device 8086:2445
  e000-e03f : Intel ICH - Controller
f000-f00f : PCI device 8086:244b
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d25ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-00261183 : Kernel code
  00261184-002ed2ef : Kernel data
0fef0000-0fef2fff : ACPI Non-volatile Storage
0fef3000-0fefffff : ACPI Tables
d0000000-d3ffffff : PCI device 8086:1132
d4000000-d5ffffff : PCI Bus #01
  d5000000-d5000fff : PCI device 9005:0080
  d5001000-d50010ff : PCI device 10ec:8139
    d5001000-d50010ff : eth0
d6000000-d607ffff : PCI device 8086:1132
ffb00000-ffffffff : reserved

hardware same as host 1)


Summary:
hardware equal computers with different kernels, different kde crushes in 
almost same situations.
Think it is kde bug - but  oops was in kernel, not kde :)

Thanks
