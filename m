Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286223AbSAAHSe>; Tue, 1 Jan 2002 02:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287773AbSAAHSZ>; Tue, 1 Jan 2002 02:18:25 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:33945 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S286223AbSAAHSQ>; Tue, 1 Jan 2002 02:18:16 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] in 2.4.17 after 10 days uptime
Date: Tue, 1 Jan 2002 02:18:01 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1A09YTT3W3NG2A0193W2"
Message-Id: <20020101071802.6E8533F2B6@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1A09YTT3W3NG2A0193W2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I started getting these bugs after about 10 days uptime.  There is a patch set for reiserfs applied
along with a few minor patches (ide-tape, disk stats for up to hdg).  The kernel is tainted by:

oscar# taint
filename:    /lib/modules/2.4.17/kernel/net/khttpd/khttpd.o
filename:    /lib/modules/2.4.17/kernel/net/netlink/netlink_dev.o
oscar# alias | grep taint
taint='modinfo `modprobe -l` | sed -ne "/^filename/h; /^license.*none/{g;p;}"'

Hardware has been stable and went over 30 days with 2.4.16 without problems.  The system is
based on debian unstable (and its living up to its name with kde apps vs libpng3 vs libqt2 problems).

Happy New Year!
Ed Tomlinson

--------------Boundary-00=_1A09YTT3W3NG2A0193W2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bug.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="bug.log"

ksymoops 2.4.3 on i586 2.4.17.  Options used
     -V (default)
     -k 20011231063052.ksyms (specified)
     -l 20011230063029.modules (specified)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Dec 31 01:32:34 oscar kernel: kernel BUG at page_alloc.c:207!
Dec 31 01:32:34 oscar kernel: invalid operand: 0000
Dec 31 01:32:34 oscar kernel: CPU:    0
Dec 31 01:32:34 oscar kernel: EIP:    0010:[rmqueue+474/544]    Tainted: P
Dec 31 01:32:34 oscar kernel: EFLAGS: 00010286
Dec 31 01:32:34 oscar kernel: eax: 00000020   ebx: c022ddc0   ecx: c022ca60   edx: 000045d4
Dec 31 01:32:34 oscar kernel: esi: c1295540   edi: 00000000   ebp: 00000001   esp: cb1e5e54
Dec 31 01:32:34 oscar kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 01:32:34 oscar kernel: Process setiathome (pid: 29402, stackpage=cb1e5000)
Dec 31 01:32:34 oscar kernel: Stack: c01f92da 000000cf c022df1c 00000100 00000000 c022dda8 00009555 00000286
Dec 31 01:32:34 oscar kernel:        00000000 c022dda8 c0127a9b 000001d2 cacf0720 00000001 cacf0720 c022df18
Dec 31 01:32:34 oscar kernel:        000001d2 ffffff00 c01277c6 00104025 c011eff8 410c7000 cacf0720 00000001
Dec 31 01:32:34 oscar kernel: Call Trace: [__alloc_pages+159/352] [_alloc_pages+22/24] [do_anonymous_page+48/164] [do_no_page+51/284] [handle_mm_fault+82/180]
Dec 31 01:32:34 oscar kernel: Code: 0f 0b 83 c4 08 90 8b 46 18 a8 80 74 19 68 d1 00 00 00 68 da
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000004 Before first symbol
   5:   90                        nop    
Code;  00000006 Before first symbol
   6:   8b 46 18                  mov    0x18(%esi),%eax
Code;  00000008 Before first symbol
   9:   a8 80                     test   $0x80,%al
Code;  0000000a Before first symbol
   b:   74 19                     je     26 <_EIP+0x26> 00000026 Before first symbol
Code;  0000000c Before first symbol
   d:   68 d1 00 00 00            push   $0xd1
Code;  00000012 Before first symbol
  12:   68 da 00 00 00            push   $0xda

Dec 31 06:25:25 oscar kernel: kernel BUG at page_alloc.c:76!
Dec 31 06:25:25 oscar kernel: invalid operand: 0000
Dec 31 06:25:25 oscar kernel: CPU:    0
Dec 31 06:25:25 oscar kernel: EIP:    0010:[__free_pages_ok+52/672]    Tainted: P
Dec 31 06:25:25 oscar kernel: EFLAGS: 00010282
Dec 31 06:25:25 oscar kernel: eax: 0000001f   ebx: c1295540   ecx: c022ca60   edx: 00004b0b
Dec 31 06:25:25 oscar kernel: esi: c1295540   edi: 00000000   ebp: 00000000   esp: c183bf1c
Dec 31 06:25:25 oscar kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 06:25:25 oscar kernel: Process kswapd (pid: 4, stackpage=c183b000)
Dec 31 06:25:25 oscar kernel: Stack: c01f92da 0000004c c1295540 c1295540 00000000 00000009 c012eb69 c1295540
Dec 31 06:25:25 oscar kernel:        000001d0 c129555c c0126561 c0127bc4 c129555c c0126c07 00000020 000001d0
Dec 31 06:25:25 oscar kernel:        00000020 00000006 c183a000 00000200 00001bf3 000001d0 c022dda8 c0126e17
Dec 31 06:25:25 oscar kernel: Call Trace: [try_to_release_page+81/88] [lru_cache_del+5/20] [page_cache_release+44/48] [shrink_cache+555/772] [shrink_caches+83/132]
Dec 31 06:25:25 oscar kernel: Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00 89 f0 2b 05 8c 36 28 c0

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000004 Before first symbol
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   c:   89 f0                     mov    %esi,%eax
Code;  0000000e Before first symbol
   e:   2b 05 8c 36 28 c0         sub    0xc028368c,%eax

Dec 31 10:13:29 oscar kernel: kernel BUG at page_alloc.c:76!
Dec 31 10:13:29 oscar kernel: invalid operand: 0000
Dec 31 10:13:29 oscar kernel: CPU:    0
Dec 31 10:13:29 oscar kernel: EIP:    0010:[__free_pages_ok+52/672]    Tainted: P
Dec 31 10:13:29 oscar kernel: EFLAGS: 00010286
Dec 31 10:13:29 oscar kernel: eax: 0000001f   ebx: c1295540   ecx: c022ca60   edx: 00004e61
Dec 31 10:13:29 oscar kernel: esi: c1295540   edi: c4b6fcb0   ebp: 00000000   esp: d7eb5ef0
Dec 31 10:13:29 oscar kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 10:13:29 oscar kernel: Process galeon-bin (pid: 9915, stackpage=d7eb5000)
Dec 31 10:13:29 oscar kernel: Stack: c01f92da 0000004c c1295540 00022000 c4b6fcb0 4130a000 c1040000 c022ddc0
Dec 31 10:13:29 oscar kernel:        00000213 ffffffff 00007958 c0127bc4 c1295540 c0127fdd c1295540 c011df3a
Dec 31 10:13:29 oscar kernel:        c1295540 000f6000 c011e2f3 0a555025 c75a12c0 cacf0a40 40f0a000 00319000
Dec 31 10:13:29 oscar kernel: Call Trace: [page_cache_release+44/48] [free_page_and_swap_cache+49/52] [__free_pte+58/64] [zap_page_range+387/556] [exit_mmap+183/300]
Dec 31 10:13:29 oscar kernel: Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00 89 f0 2b 05 8c 36 28 c0

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000004 Before first symbol
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  0000000c Before first symbol
   c:   89 f0                     mov    %esi,%eax
Code;  0000000e Before first symbol
   e:   2b 05 8c 36 28 c0         sub    0xc028368c,%eax

Jan  1 01:44:57 oscar kernel:  sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  1 01:44:57 oscar kernel: e2b0729f
Jan  1 01:44:57 oscar kernel: *pde = 00000000
Jan  1 01:44:57 oscar kernel: Oops: 0000
Jan  1 01:44:57 oscar kernel: CPU:    0
Jan  1 01:44:57 oscar kernel: EIP:    0010:[softdog:__insmod_softdog_O/lib/modules/2.4.17/kernel/drivers/char/s+-593249/96]
Jan  1 01:44:57 oscar kernel: EFLAGS: 00010287
Jan  1 01:44:57 oscar kernel: eax: 00000000   ebx: c6e18900   ecx: 00000005   edx: 00001000
Jan  1 01:44:57 oscar kernel: esi: 00000000   edi: 00000000   ebp: d1d24000   esp: cfa1bebc
Jan  1 01:44:57 oscar kernel: ds: 0018   es: 0018   ss: 0018
Jan  1 01:44:57 oscar kernel: Process usb-storage-0 (pid: 8948, stackpage=cfa1b000)
Jan  1 01:44:57 oscar kernel: Stack: cecad800 00000000 df4b9e00 df4b9e00 00000009 00000005 cecad858 00000009
Jan  1 01:44:57 oscar kernel:        00086463 00800003 00000a01 00000000 00000000 02008000 0000001f 00000000
Jan  1 01:44:57 oscar kernel:        00000000 00000000 00000000 00000000 00000000 00000000 32203030 30302030
Jan  1 01:44:57 oscar kernel: Call Trace: [schedule+754/796] [softdog:__insmod_softdog_O/lib/modules/2.4.17/kernel/drivers/char/s+-604519/96] [__down_interruptible+183/196] [softdog:__insmod_softdog_O/lib/modules/2.4.17/kernel/drivers/char/s+-606259/96]
Jan  1 01:44:57 oscar kernel: Code: 8b 14 b8 85 d2 75 07 8b 43 1c 39 38 75 3f 8b 9c 24 9c 00 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 14 b8                  mov    (%eax,%edi,4),%edx
Code;  00000002 Before first symbol
   3:   85 d2                     test   %edx,%edx
Code;  00000004 Before first symbol
   5:   75 07                     jne    e <_EIP+0xe> 0000000e Before first symbol
Code;  00000006 Before first symbol
   7:   8b 43 1c                  mov    0x1c(%ebx),%eax
Code;  0000000a Before first symbol
   a:   39 38                     cmp    %edi,(%eax)
Code;  0000000c Before first symbol
   c:   75 3f                     jne    4d <_EIP+0x4d> 0000004c Before first symbol
Code;  0000000e Before first symbol
   e:   8b 9c 24 9c 00 00 00      mov    0x9c(%esp,1),%ebx


--------------Boundary-00=_1A09YTT3W3NG2A0193W2--
