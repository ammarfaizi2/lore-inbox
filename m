Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTEVMlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 08:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTEVMlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 08:41:47 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:56588 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261798AbTEVMlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 08:41:36 -0400
Subject: 2.4.21-rc2 oopses on ThinkPad X31
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NqpKh2TJV+ywk2VZC43X"
Organization: Trudheim Technology Limited
Message-Id: <1053608076.2207.4.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 22 May 2003 13:54:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NqpKh2TJV+ywk2VZC43X
Content-Type: multipart/mixed; boundary="=-5t3IPrMKkz8wIrBi8sfE"


--=-5t3IPrMKkz8wIrBi8sfE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

I'm back with more oopses and I can already hear the groans. This time,
there is no VMware modules anywhere in sight to mess things up. Please
find attached dmesg output in normal and ksymoopsed form as well as the
output of lsmod. If there is any other information that would be handy,
let me know and I'll stick it on the web somewhere.=20

/Anders


--=-5t3IPrMKkz8wIrBi8sfE
Content-Disposition: attachment; filename=dmesg.out
Content-Type: text/plain; name=dmesg.out; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Unable to handle kernel NULL pointer dereference at virtual address 0000000=
4
 printing eip:
c01382b0
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01382b0>]    Not tainted
EFLAGS: 00010092
eax: 00000000   ebx: c1238d00   ecx: c1238d30   edx: 00000000
esi: 0000ad9b   edi: 0002ef60   ebp: c0296870   esp: d134bee0
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 25470, stackpage=3Dd134b000)
Stack: c02968dc c1000020 c1238d30 c0296850 c1030020 00000203 ffffffff 00005=
6cd=20
       000b9000 c09ca2e4 001c8000 000000ba c012e318 c1238d30 edb11b40 c783f=
b40=20
       d134a000 40c00000 d73db40c 409c8000 00000000 c012c95b edb11b40 d73db=
408=20
Call Trace:    [<c012e318>] [<c012c95b>] [<c012f8d3>] [<c011bfe4>] [<c0120d=
24>]
  [<c0120ef3>] [<c010920f>]

Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 d1 64=20

kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00010202
eax: 010000cc   ebx: c123a500   ecx: 0000be1a   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: ddc59eec
ds: 0018   es: 0018   ss: 0018
Process gzip (pid: 25556, stackpage=3Dddc59000)
Stack: 00001000 0104a000 0000ae1a 00000292 00000000 c0296850 c02969d4 00000=
1ff=20
       00000000 000001d2 c01387f1 ef333c00 c0296850 c02969d0 00000000 00001=
04b=20
       00000000 efc18de8 00000000 c01331d2 de149464 0000104b efc18de8 00001=
000=20
Call Trace:    [<c01387f1>] [<c01331d2>] [<c013f9a3>] [<c010920f>]

Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20

kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00210202
eax: 010000cc   ebx: c123ed60   ecx: 0000bf9c   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: ea7f5e6c
ds: 0018   es: 0018   ss: 0018
Process gnome-gtkhtml-e (pid: 25643, stackpage=3Dea7f5000)
Stack: 00001000 c0296850 0000af9c 00200296 00000000 c0296850 c02969d4 00000=
1ff=20
       00000000 000001d2 c01387f1 e2811900 c0296850 c02969d0 e29959b0 00104=
025=20
       00000001 e28116c0 e2995c90 c012da1e cbf9d000 00000000 0008fc7c 40f24=
0c0=20
Call Trace:    [<c01387f1>] [<c012da1e>] [<c012dd6b>] [<c0119d64>] [<c01231=
18>]
  [<c01231ac>] [<c0119ac0>] [<c0109300>]

Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20
 kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00210202
eax: 010000cc   ebx: c123ed00   ecx: 0000bf9a   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: ea7f5e5c
ds: 0018   es: 0018   ss: 0018
Process gnome-gtkhtml-e (pid: 25645, stackpage=3Dea7f5000)
Stack: 00001000 00000000 0000af9a 00200296 00000000 c0296850 c02969d4 00000=
1ff=20
       00000000 000001d2 c01387f1 00000114 c0296850 c02969d0 def8fa60 d41f0=
840=20
       00000001 dc862ee0 cc1b06b4 c012dbc8 d41f0840 401ad000 00000000 c012d=
469=20
Call Trace:    [<c01387f1>] [<c012dbc8>] [<c012d469>] [<c012dd6b>] [<c0119d=
64>]
  [<c012ebd9>] [<f0fdeee9>] [<c0126f2c>] [<c01228b2>] [<c01227bb>] [<c010a9=
c9>]
  [<c0119ac0>] [<c0109300>]

Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20
 kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00010202
eax: 010000cc   ebx: c123eca0   ecx: 0000bf98   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: c191be48
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=3Dc191b000)
Stack: 00001000 efe080c0 0000af98 00000296 00000000 c0296850 c02969b4 00000=
1ff=20
       00000000 000000f0 c01387f1 00000000 c0296850 c02969b0 c0141df5 00000=
000=20
       efcca40c eec212a4 00001fcb c0130a02 c0143f97 efe07320 00001000 00001=
000=20
Call Trace:    [<c01387f1>] [<c0141df5>] [<c0130a02>] [<c0143f97>] [<c0143e=
3e>]
  [<c0144058>] [<c0141a46>] [<f0841048>] [<f0849537>] [<f08406c5>] [<f08495=
c3>]
  [<f082de38>] [<c0144eb8>] [<c014431c>] [<c01445fd>] [<c0105000>] [<c01074=
fe>]
  [<c0144530>]

Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20


--=-5t3IPrMKkz8wIrBi8sfE
Content-Disposition: attachment; filename=dmesg_ksymoopsed.txt
Content-Type: text/plain; name=dmesg_ksymoopsed.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.8 on i686 2.4.21-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc2/ (default)
     -m /boot/System.map-2.4.21-rc2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
4
c01382b0
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01382b0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092
eax: 00000000   ebx: c1238d00   ecx: c1238d30   edx: 00000000
esi: 0000ad9b   edi: 0002ef60   ebp: c0296870   esp: d134bee0
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 25470, stackpage=3Dd134b000)
Stack: c02968dc c1000020 c1238d30 c0296850 c1030020 00000203 ffffffff 00005=
6cd=20
       000b9000 c09ca2e4 001c8000 000000ba c012e318 c1238d30 edb11b40 c783f=
b40=20
       d134a000 40c00000 d73db40c 409c8000 00000000 c012c95b edb11b40 d73db=
408=20
Call Trace:    [<c012e318>] [<c012c95b>] [<c012f8d3>] [<c011bfe4>] [<c0120d=
24>]
  [<c0120ef3>] [<c010920f>]
Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 d1 64=20


>>EIP; c01382b0 <__free_pages_ok+200/2b0>   <=3D=3D=3D=3D=3D

>>ebx; c1238d00 <_end+f1455c/304e88bc>
>>ecx; c1238d30 <_end+f1458c/304e88bc>
>>ebp; c0296870 <contig_page_data+d0/340>
>>esp; d134bee0 <_end+1102773c/304e88bc>

Trace; c012e318 <zap_pte_range+108/149>
Trace; c012c95b <zap_page_range+8b/100>
Trace; c012f8d3 <exit_mmap+d3/160>
Trace; c011bfe4 <mmput+44/a0>
Trace; c0120d24 <do_exit+d4/270>
Trace; c0120ef3 <sys_exit+13/20>
Trace; c010920f <system_call+33/38>

Code;  c01382b0 <__free_pages_ok+200/2b0>
00000000 <_EIP>:
Code;  c01382b0 <__free_pages_ok+200/2b0>   <=3D=3D=3D=3D=3D
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=3D=3D=3D=3D=3D
Code;  c01382b3 <__free_pages_ok+203/2b0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c01382b5 <__free_pages_ok+205/2b0>
   5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c01382bc <__free_pages_ok+20c/2b0>
   c:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c01382c2 <__free_pages_ok+212/2b0>
  12:   d1 64 00 00               shll   0x0(%eax,%eax,1)

kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00010202
eax: 010000cc   ebx: c123a500   ecx: 0000be1a   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: ddc59eec
ds: 0018   es: 0018   ss: 0018
Process gzip (pid: 25556, stackpage=3Dddc59000)
Stack: 00001000 0104a000 0000ae1a 00000292 00000000 c0296850 c02969d4 00000=
1ff=20
       00000000 000001d2 c01387f1 ef333c00 c0296850 c02969d0 00000000 00001=
04b=20
       00000000 efc18de8 00000000 c01331d2 de149464 0000104b efc18de8 00001=
000=20
Call Trace:    [<c01387f1>] [<c01331d2>] [<c013f9a3>] [<c010920f>]
Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20


>>EIP; c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D

>>ebx; c123a500 <_end+f15d5c/304e88bc>
>>edi; c1000020 <_end+cdb87c/304e88bc>
>>ebp; c0296850 <contig_page_data+b0/340>
>>esp; ddc59eec <_end+1d935748/304e88bc>

Trace; c01387f1 <__alloc_pages+41/180>
Trace; c01331d2 <generic_file_write+322/820>
Trace; c013f9a3 <sys_write+93/150>
Trace; c010920f <system_call+33/38>

Code;  c0138576 <rmqueue+216/240>
00000000 <_EIP>:
Code;  c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0138578 <rmqueue+218/240>
   2:   e7 00                     out    %eax,$0x0
Code;  c013857a <rmqueue+21a/240>
   4:   b2 6f                     mov    $0x6f,%dl
Code;  c013857c <rmqueue+21c/240>
   6:   26 c0 8b 43 18 a9 80      rorb   $0x0,%es:0x80a91843(%ebx)
Code;  c0138583 <rmqueue+223/240>
   d:   00=20
Code;  c0138584 <rmqueue+224/240>
   e:   00 00                     add    %al,(%eax)
Code;  c0138586 <rmqueue+226/240>
  10:   74 08                     je     1a <_EIP+0x1a>
Code;  c0138588 <rmqueue+228/240>
  12:   0f 0b                     ud2a  =20

kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00210202
eax: 010000cc   ebx: c123ed60   ecx: 0000bf9c   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: ea7f5e6c
ds: 0018   es: 0018   ss: 0018
Process gnome-gtkhtml-e (pid: 25643, stackpage=3Dea7f5000)
Stack: 00001000 c0296850 0000af9c 00200296 00000000 c0296850 c02969d4 00000=
1ff=20
       00000000 000001d2 c01387f1 e2811900 c0296850 c02969d0 e29959b0 00104=
025=20
       00000001 e28116c0 e2995c90 c012da1e cbf9d000 00000000 0008fc7c 40f24=
0c0=20
Call Trace:    [<c01387f1>] [<c012da1e>] [<c012dd6b>] [<c0119d64>] [<c01231=
18>]
  [<c01231ac>] [<c0119ac0>] [<c0109300>]
Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20


>>EIP; c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D

>>ebx; c123ed60 <_end+f1a5bc/304e88bc>
>>edi; c1000020 <_end+cdb87c/304e88bc>
>>ebp; c0296850 <contig_page_data+b0/340>
>>esp; ea7f5e6c <_end+2a4d16c8/304e88bc>

Trace; c01387f1 <__alloc_pages+41/180>
Trace; c012da1e <do_anonymous_page+5e/130>
Trace; c012dd6b <handle_mm_fault+7b/140>
Trace; c0119d64 <do_page_fault+2a4/4d7>
Trace; c0123118 <do_sysctl+98/d0>
Trace; c01231ac <sys_sysctl+5c/70>
Trace; c0119ac0 <do_page_fault+0/4d7>
Trace; c0109300 <error_code+34/3c>

Code;  c0138576 <rmqueue+216/240>
00000000 <_EIP>:
Code;  c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0138578 <rmqueue+218/240>
   2:   e7 00                     out    %eax,$0x0
Code;  c013857a <rmqueue+21a/240>
   4:   b2 6f                     mov    $0x6f,%dl
Code;  c013857c <rmqueue+21c/240>
   6:   26 c0 8b 43 18 a9 80      rorb   $0x0,%es:0x80a91843(%ebx)
Code;  c0138583 <rmqueue+223/240>
   d:   00=20
Code;  c0138584 <rmqueue+224/240>
   e:   00 00                     add    %al,(%eax)
Code;  c0138586 <rmqueue+226/240>
  10:   74 08                     je     1a <_EIP+0x1a>
Code;  c0138588 <rmqueue+228/240>
  12:   0f 0b                     ud2a  =20

 kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00210202
eax: 010000cc   ebx: c123ed00   ecx: 0000bf9a   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: ea7f5e5c
ds: 0018   es: 0018   ss: 0018
Process gnome-gtkhtml-e (pid: 25645, stackpage=3Dea7f5000)
Stack: 00001000 00000000 0000af9a 00200296 00000000 c0296850 c02969d4 00000=
1ff=20
       00000000 000001d2 c01387f1 00000114 c0296850 c02969d0 def8fa60 d41f0=
840=20
       00000001 dc862ee0 cc1b06b4 c012dbc8 d41f0840 401ad000 00000000 c012d=
469=20
Call Trace:    [<c01387f1>] [<c012dbc8>] [<c012d469>] [<c012dd6b>] [<c0119d=
64>]
  [<c012ebd9>] [<f0fdeee9>] [<c0126f2c>] [<c01228b2>] [<c01227bb>] [<c010a9=
c9>]
  [<c0119ac0>] [<c0109300>]
Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20


>>EIP; c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D

>>ebx; c123ed00 <_end+f1a55c/304e88bc>
>>edi; c1000020 <_end+cdb87c/304e88bc>
>>ebp; c0296850 <contig_page_data+b0/340>
>>esp; ea7f5e5c <_end+2a4d16b8/304e88bc>

Trace; c01387f1 <__alloc_pages+41/180>
Trace; c012dbc8 <do_no_page+d8/200>
Trace; c012d469 <do_wp_page+c9/270>
Trace; c012dd6b <handle_mm_fault+7b/140>
Trace; c0119d64 <do_page_fault+2a4/4d7>
Trace; c012ebd9 <do_mmap_pgoff+469/590>
Trace; f0fdeee9 <[usb-uhci]rh_init_int_timer+59/60>
Trace; c0126f2c <run_timer_list+14c/170>
Trace; c01228b2 <bh_action+22/40>
Trace; c01227bb <tasklet_hi_action+3b/70>
Trace; c010a9c9 <do_IRQ+99/b0>
Trace; c0119ac0 <do_page_fault+0/4d7>
Trace; c0109300 <error_code+34/3c>

Code;  c0138576 <rmqueue+216/240>
00000000 <_EIP>:
Code;  c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0138578 <rmqueue+218/240>
   2:   e7 00                     out    %eax,$0x0
Code;  c013857a <rmqueue+21a/240>
   4:   b2 6f                     mov    $0x6f,%dl
Code;  c013857c <rmqueue+21c/240>
   6:   26 c0 8b 43 18 a9 80      rorb   $0x0,%es:0x80a91843(%ebx)
Code;  c0138583 <rmqueue+223/240>
   d:   00=20
Code;  c0138584 <rmqueue+224/240>
   e:   00 00                     add    %al,(%eax)
Code;  c0138586 <rmqueue+226/240>
  10:   74 08                     je     1a <_EIP+0x1a>
Code;  c0138588 <rmqueue+228/240>
  12:   0f 0b                     ud2a  =20

 kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0138576>]    Not tainted
EFLAGS: 00010202
eax: 010000cc   ebx: c123eca0   ecx: 0000bf98   edx: 00001000
esi: 0002ef60   edi: c1000020   ebp: c0296850   esp: c191be48
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=3Dc191b000)
Stack: 00001000 efe080c0 0000af98 00000296 00000000 c0296850 c02969b4 00000=
1ff=20
       00000000 000000f0 c01387f1 00000000 c0296850 c02969b0 c0141df5 00000=
000=20
       efcca40c eec212a4 00001fcb c0130a02 c0143f97 efe07320 00001000 00001=
000=20
Call Trace:    [<c01387f1>] [<c0141df5>] [<c0130a02>] [<c0143f97>] [<c0143e=
3e>]
  [<c0144058>] [<c0141a46>] [<f0841048>] [<f0849537>] [<f08406c5>] [<f08495=
c3>]
  [<f082de38>] [<c0144eb8>] [<c014431c>] [<c01445fd>] [<c0105000>] [<c01074=
fe>]
  [<c0144530>]
Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b=20


>>EIP; c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D

>>ebx; c123eca0 <_end+f1a4fc/304e88bc>
>>edi; c1000020 <_end+cdb87c/304e88bc>
>>ebp; c0296850 <contig_page_data+b0/340>
>>esp; c191be48 <_end+15f76a4/304e88bc>

Trace; c01387f1 <__alloc_pages+41/180>
Trace; c0141df5 <get_unused_buffer_head+45/90>
Trace; c0130a02 <find_or_create_page+72/f0>
Trace; c0143f97 <hash_page_buffers+c7/f0>
Trace; c0143e3e <grow_dev_page+2e/c0>
Trace; c0144058 <grow_buffers+98/100>
Trace; c0141a46 <getblk+46/80>
Trace; f0841048 <[reiserfs]do_journal_end+1e8/ba0>
Trace; f0849537 <[reiserfs].rodata.end+565c/58e5>
Trace; f08406c5 <[reiserfs]flush_old_commits+135/1d0>
Trace; f08495c3 <[reiserfs].rodata.end+56e8/58e5>
Trace; f082de38 <[reiserfs]reiserfs_write_super+28/30>
Trace; c0144eb8 <sync_supers+128/150>
Trace; c014431c <sync_old_buffers+1c/50>
Trace; c01445fd <kupdate+cd/100>
Trace; c0105000 <_stext+0/0>
Trace; c01074fe <arch_kernel_thread+2e/40>
Trace; c0144530 <kupdate+0/100>

Code;  c0138576 <rmqueue+216/240>
00000000 <_EIP>:
Code;  c0138576 <rmqueue+216/240>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0138578 <rmqueue+218/240>
   2:   e7 00                     out    %eax,$0x0
Code;  c013857a <rmqueue+21a/240>
   4:   b2 6f                     mov    $0x6f,%dl
Code;  c013857c <rmqueue+21c/240>
   6:   26 c0 8b 43 18 a9 80      rorb   $0x0,%es:0x80a91843(%ebx)
Code;  c0138583 <rmqueue+223/240>
   d:   00=20
Code;  c0138584 <rmqueue+224/240>
   e:   00 00                     add    %al,(%eax)
Code;  c0138586 <rmqueue+226/240>
  10:   74 08                     je     1a <_EIP+0x1a>
Code;  c0138588 <rmqueue+228/240>
  12:   0f 0b                     ud2a  =20


1 warning issued.  Results may not be reliable.

--=-5t3IPrMKkz8wIrBi8sfE
Content-Disposition: attachment; filename=lsmod.out
Content-Type: text/plain; name=lsmod.out; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Module                  Size  Used by    Not tainted
snd-pcm-oss            41092   0 (autoclean)
snd-mixer-oss          14008   1 (autoclean) [snd-pcm-oss]
sr_mod                 14648   0 (autoclean) (unused)
ipt_MASQUERADE          1368   1 (autoclean)
ipt_multiport            760   2 (autoclean)
ipt_LOG                 3384   2 (autoclean)
ipt_state                568   5 (autoclean)
iptable_filter          1708   1 (autoclean)
ip_nat_irc              2544   0 (autoclean) (unused)
ip_conntrack_irc        3248   1 (autoclean)
ip_nat_ftp              3280   0 (autoclean) (unused)
iptable_nat            17006   3 (autoclean) [ipt_MASQUERADE ip_nat_irc ip_=
nat_ftp]
ip_tables              12288   8 (autoclean) [ipt_MASQUERADE ipt_multiport =
ipt_LOG ipt_state iptable_filter iptable_nat]
ip_conntrack_ftp        4272   1 (autoclean)
ip_conntrack           18820   4 (autoclean) [ipt_MASQUERADE ipt_state ip_n=
at_irc ip_conntrack_irc ip_nat_ftp iptable_nat ip_conntrack_ftp]
usbserial              19996   0 (autoclean) (unused)
hid                    20484   0 (unused)
keybdev                 2180   0 (unused)
ds                      7156   2
yenta_socket           10848   2
pcmcia_core            48416   0 [ds yenta_socket]
isa-pnp                33488   0 (unused)
rfcomm                 32160   0 (unused)
af_packet              13960   1 (autoclean)
l2cap                  17360   2 (autoclean)
bluez                  33508   1 (autoclean) [rfcomm l2cap]
mousedev                4628   1
joydev                  6304   0
evdev                   4800   0 (unused)
input                   3488   0 [hid keybdev mousedev joydev evdev]
usb-uhci               24208   0 (unused)
ehci-hcd               25708   0 (unused)
usbcore                71852   1 [usbserial hid usb-uhci ehci-hcd]
raw1394                18936   0 (unused)
ohci1394               25936   0 (unused)
ieee1394               47012   0 [raw1394 ohci1394]
e100                   48360   1
ipv6                  163508  -1 (autoclean)
snd-intel8x0           18308   1
snd-pcm                64644   0 [snd-pcm-oss snd-intel8x0]
snd-timer              15432   0 [snd-pcm]
snd-ac97-codec         39560   0 [snd-intel8x0]
snd-page-alloc          5628   0 [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3504   0 [snd-intel8x0]
snd-rawmidi            14240   0 [snd-mpu401-uart]
snd-seq-device          4528   0 [snd-rawmidi]
snd                    32356   0 [snd-pcm-oss snd-mixer-oss snd-intel8x0 sn=
d-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3908   3 [snd]
ide-scsi               10832   0
ide-cd                 33408   0
cdrom                  30272   0 [sr_mod ide-cd]
ext3                   69600   1 (autoclean)
jbd                    52976   1 (autoclean) [ext3]
loop                   10264   0 (autoclean)
reiserfs              189872   8
lvm-mod                58752  19

--=-5t3IPrMKkz8wIrBi8sfE--

--=-NqpKh2TJV+ywk2VZC43X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+zMiMLYywqksgYBoRAjG2AJ46pSroXAzbw26y9zoxYQLNP8O/BQCeO9J2
B3zwOiR1sJ20hunflVnSAS0=
=ER4O
-----END PGP SIGNATURE-----

--=-NqpKh2TJV+ywk2VZC43X--

