Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262624AbSJGTRn>; Mon, 7 Oct 2002 15:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbSJGTRn>; Mon, 7 Oct 2002 15:17:43 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:57454 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262624AbSJGTRT>; Mon, 7 Oct 2002 15:17:19 -0400
Date: Mon, 7 Oct 2002 16:54:16 +0200
From: Andreas Bergen <andreas.bergen@online.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel-oops
Message-ID: <20021007145416.GA4695@erde.erde.bergen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear kernel-developers,

recently I get quite a lot of kernel oopses. Before 2.4.17 my system
ran very stable but since upgrading to 2.4.18 and still with 2.4.19 I
get an oops every few days.

Can you help me with these? Do you need any additional information?

Attached is the output of ksymoops.

Thanks a lot in advance
yours
  Andreas Bergen

-- 
Andreas Bergen
E-Mail: andreas.bergen@online.de
PGP-Key on keyservers.
"Freuet euch in dem Herrn allewege, und abermals sage ich: Freuet euch!" Phi 4,4

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May  4 22:10:30 erde kernel: Unable to handle kernel NULL pointer dereference at virtual address 000001
May  4 22:10:30 erde kernel: c01cfca1
May  4 22:10:30 erde kernel: *pde = 00000000
May  4 22:10:30 erde kernel: Oops: 0000
May  4 22:10:30 erde kernel: CPU:    0
May  4 22:10:30 erde kernel: EIP:    0010:[sock_poll+21/40]    Not tainted
May  4 22:10:30 erde kernel: EFLAGS: 00210282
May  4 22:10:30 erde kernel: eax: 00000000   ebx: c58d5640   ecx: 00000000   edx: 00000120
May  4 22:10:30 erde kernel: esi: c58d5640   edi: 00000000   ebp: c4681f70   esp: c4681f34
May  4 22:10:30 erde kernel: ds: 0018   es: 0018   ss: 0018
May  4 22:10:30 erde kernel: Process X (pid: 869, stackpage=c4681000)
May  4 22:10:30 erde kernel: Stack: 00000000 c013aac6 c58d5640 00000000 00000008 00000020 c5647560 0000
0145
May  4 22:10:30 erde kernel:        00400000 c4680000 000014a4 00000016 00000000 00000000 c2d13000 0000
0000
May  4 22:10:30 erde kernel:        c013af32 0000001d c4681fa8 c4681fa4 c4680000 00000000 bffff554 bfff
f75c
May  4 22:10:30 erde kernel: Call Trace: [do_select+226/476] [sys_select+842/1172] [system_call+51/64]
May  4 22:10:30 erde kernel: Code: 8b 80 28 01 00 00 51 52 53 8b 40 1c ff d0 83 c4 0c 5b c3 53
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 80 28 01 00 00         mov    0x128(%eax),%eax
Code;  00000006 Before first symbol
   6:   51                        push   %ecx
Code;  00000006 Before first symbol
   7:   52                        push   %edx
Code;  00000008 Before first symbol
   8:   53                        push   %ebx
Code;  00000008 Before first symbol
   9:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  0000000c Before first symbol
   c:   ff d0                     call   *%eax
Code;  0000000e Before first symbol
   e:   83 c4 0c                  add    $0xc,%esp
Code;  00000010 Before first symbol
  11:   5b                        pop    %ebx
Code;  00000012 Before first symbol
  12:   c3                        ret    
Code;  00000012 Before first symbol
  13:   53                        push   %ebx

May  4 22:10:30 erde kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00
000032
May  4 22:10:30 erde kernel: c0140fda
May  4 22:10:30 erde kernel: *pde = 00000000
May  4 22:10:30 erde kernel: Oops: 0000
May  4 22:10:30 erde kernel: CPU:    0
May  4 22:10:30 erde kernel: EIP:    0010:[fcntl_dirnotify+62/332]    Not tainted
May  4 22:10:30 erde kernel: EFLAGS: 00210202
May  4 22:10:30 erde kernel: eax: c17316c0   ebx: c58d5640   ecx: 00000000   edx: c58d5640
May  4 22:10:30 erde kernel: esi: 00000000   edi: 00000000   ebp: 00000001   esp: c4681de0
May  4 22:10:30 erde kernel: ds: 0018   es: 0018   ss: 0018
May  4 22:10:30 erde kernel: Process X (pid: 869, stackpage=c4681000)
May  4 22:10:30 erde kernel: Stack: c58d5640 00000000 c521d700 00000001 c012d9ba 00000000 c58d5640 0000
0000
May  4 22:10:30 erde kernel:        0000007f 00000016 c01161b8 c58d5640 c521d700 c5fa6440 c4680000 0000
000b
May  4 22:10:30 erde kernel:        00000128 c521d820 c0116793 c521d700 00000000 c5fa645c c4afcb40 c010
732e
May  4 22:10:30 erde kernel: Call Trace: [filp_close+74/100] [put_files_struct+84/188] [do_exit+187/492
May  4 22:10:30 erde kernel: Code: 66 8b 46 32 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec ff ff ff

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 8b 46 32               mov    0x32(%esi),%ax
Code;  00000004 Before first symbol
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  00000008 Before first symbol
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  0000000c Before first symbol
   d:   74 0a                     je     19 <_EIP+0x19> 00000018 Before first symbol
Code;  0000000e Before first symbol
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax


1 warning issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.18.  Options used
     -V (specified)
     -k ksyms-20020601 (specified)
     -l modules-20020601 (specified)
     -o /lib/modules/2.4.18 (specified)
     -m /boot/System.map-2.4.18 (specified)

Jun  1 16:20:22 erde kernel: Unable to handle kernel paging request at virtual address 00016f80
Jun  1 16:20:22 erde kernel: c01278cd
Jun  1 16:20:22 erde kernel: *pde = 00000000
Jun  1 16:20:22 erde kernel: Oops: 0000
Jun  1 16:20:22 erde kernel: CPU:    0
Jun  1 16:20:22 erde kernel: EIP:    0010:[kmem_cache_free+41/148]    Tainted: P
Jun  1 16:20:22 erde kernel: EFLAGS: 00210086
Jun  1 16:20:22 erde kernel: eax: 00016f80   ebx: c16f7dd8   ecx: c025217d   edx: c1000000
Jun  1 16:20:22 erde kernel: esi: c1183ea0   edi: 00200292   ebp: 00000008   esp: c3371f6c
Jun  1 16:20:22 erde kernel: ds: 0018   es: 0018   ss: 0018
Jun  1 16:20:22 erde kernel: Process kdeinit (pid: 1195, stackpage=c3371000)
Jun  1 16:20:22 erde kernel: Stack: c16f8000 00000000 c3371fa4 00000008 c0136fef c1183ea0 c16f8000 c337
0000
Jun  1 16:20:22 erde kernel:        c3371fa4 08134130 bfffe730 c01341a9 c3370000 bfffe804 c1189820 c118
62e0
Jun  1 16:20:22 erde kernel:        40ce1d1c bfffec34 bfffec50 00000008 00000001 c0106d93 08134130 bfff
e690
Jun  1 16:20:22 erde kernel: Call Trace: [__user_walk+67/80] [sys_lstat64+25/112] [system_call+51/64]
Jun  1 16:20:22 erde kernel: Code: d8 31 d2 f7 76 18 89 c3 8b 41 14 89 44 99 18 89 59 14 8b 41
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   d8 31                     fdivs  (%ecx)
Code;  00000002 Before first symbol
   2:   d2                        (bad)  
Code;  00000002 Before first symbol
   3:   f7 76 18                  divl   0x18(%esi)
Code;  00000006 Before first symbol
   6:   89 c3                     mov    %eax,%ebx
Code;  00000008 Before first symbol
   8:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  0000000a Before first symbol
   b:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)
Code;  0000000e Before first symbol
   f:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  00000012 Before first symbol
  12:   8b 41 00                  mov    0x0(%ecx),%eax


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19/ (specified)
     -m /boot/System.map-2.4.19 (specified)

Sep  5 21:09:23 erde kernel: Unable to handle kernel paging request at virtual address 00690057
Sep  5 21:09:23 erde kernel: c01307a1
Sep  5 21:09:23 erde kernel: *pde = 00000000
Sep  5 21:09:23 erde kernel: Oops: 0000
Sep  5 21:09:23 erde kernel: CPU:    0
Sep  5 21:09:23 erde kernel: EIP:    0010:[sys_read+65/240]    Not tainted
Sep  5 21:09:23 erde kernel: EFLAGS: 00010202
Sep  5 21:09:23 erde kernel: eax: 0069002f   ebx: 00000000   ecx: 00000000   edx: c2dd2620
Sep  5 21:09:23 erde kernel: esi: c0e94b60   edi: fffffff7   ebp: 00001000   esp: c4e3ffb0
Sep  5 21:09:23 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep  5 21:09:23 erde kernel: Process ksysguardd (pid: 1327, stackpage=c4e3f000)
Sep  5 21:09:23 erde kernel: Stack: c4e3e000 080721a0 bffff0e4 bfffef1c c0108813 00000004 40018000 0000
1000
Sep  5 21:09:23 erde kernel:        080721a0 bffff0e4 bfffef1c 00000003 c010002b 0000002b 00000003 4011
f2e4
Sep  5 21:09:23 erde kernel:        00000023 00000297 bfffeeec 0000002b
Sep  5 21:09:23 erde kernel: Call Trace:    [system_call+51/64]
Sep  5 21:09:23 erde kernel: Code: f6 40 28 40 74 29 66 8b 42 32 25 08 04 00 00 66 3d 00 04 75
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 28 40               testb  $0x40,0x28(%eax)
Code;  00000004 Before first symbol
   4:   74 29                     je     2f <_EIP+0x2f> 0000002e Before first symbol
Code;  00000006 Before first symbol
   6:   66 8b 42 32               mov    0x32(%edx),%ax
Code;  0000000a Before first symbol
   a:   25 08 04 00 00            and    $0x408,%eax
Code;  0000000e Before first symbol
   f:   66 3d 00 04               cmp    $0x400,%ax
Code;  00000012 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000014 Before first symbol


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
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

Warning (compare_maps): mismatch on symbol bm_get_device_context  , ksyms_base says c017d90c, System.map says c017d55c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_info  , ksyms_base says c017d8cc, System.map says c017d51c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_power_state  , ksyms_base says c017d7a0, System.map says c017d3f0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_status  , ksyms_base says c017d83c, System.map says c017d48c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_osl_generate_event  , ksyms_base says c017d3f0, System.map says c017d8e0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_register_driver  , ksyms_base says c017d960, System.map says c017d5b0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_set_device_power_state  , ksyms_base says c017d800, System.map says c017d450.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_unregister_driver  , ksyms_base says c017da38, System.map says c017d688.  Ignoring ksyms_base entry
Sep 16 14:31:18 erde kernel: kernel BUG at page_alloc.c:206!
Sep 16 14:31:18 erde kernel: invalid operand: 0000
Sep 16 14:31:18 erde kernel: CPU:    0
Sep 16 14:31:18 erde kernel: EIP:    0010:[__free_pages_ok+562/716]    Not tainted
Sep 16 14:31:18 erde kernel: EFLAGS: 00010006
Sep 16 14:31:18 erde kernel: eax: 00000000   ebx: c10f193c   ecx: 00001000   edx: 000057d8
Sep 16 14:31:18 erde kernel: esi: c10f193c   edi: 00000000   ebp: c0222e74   esp: c4cf3e54
Sep 16 14:31:18 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 14:31:18 erde kernel: Process cpp0 (pid: 2234, stackpage=c4cf3000)
Sep 16 14:31:18 erde kernel: Stack: c0223000 00000141 00000000 c0222e74 00030002 00001510 00000282 c022
2e8c
Sep 16 14:31:18 erde kernel:        00000000 c0222e74 c012bd16 000001d2 c4680c80 00000001 c4680c80 c022
2ffc
Sep 16 14:31:18 erde kernel:        000001d2 c0222e8c c012bb06 00104025 c0122cbc 0817c014 c4680c80 0000
0001
Sep 16 14:31:18 erde kernel: Call Trace:    [balance_classzone+238/468] [rmqueue+410/676] [do_swap_page
Sep 16 14:31:18 erde kernel: Code: 0f 0b ce 00 d3 83 1f c0 8b 56 04 8b 06 89 50 04 89 02 8b 44
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   ce                        into   
Code;  00000002 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000004 Before first symbol
   5:   83 1f c0                  sbbl   $0xffffffc0,(%edi)
Code;  00000008 Before first symbol
   8:   8b 56 04                  mov    0x4(%esi),%edx
Code;  0000000a Before first symbol
   b:   8b 06                     mov    (%esi),%eax
Code;  0000000c Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

Sep 16 14:31:19 erde kernel:  kernel BUG at page_alloc.c:206!
Sep 16 14:31:19 erde kernel: invalid operand: 0000
Sep 16 14:31:19 erde kernel: CPU:    0
Sep 16 14:31:19 erde kernel: EIP:    0010:[__free_pages_ok+562/716]    Not tainted
Sep 16 14:31:19 erde kernel: EFLAGS: 00013006
Sep 16 14:31:19 erde kernel: eax: 00000000   ebx: c10f193c   ecx: 00001000   edx: 000057d8
Sep 16 14:31:19 erde kernel: esi: c10f193c   edi: 00000000   ebp: c0222e74   esp: c46b9e54
Sep 16 14:31:19 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 14:31:19 erde kernel: Process X (pid: 873, stackpage=c46b9000)
Sep 16 14:31:19 erde kernel: Stack: c0223000 00000141 00000000 c0222e74 00003246 000006f2 00003282 c022
2e8c
Sep 16 14:31:19 erde kernel:        00000000 c0222e74 c012bd16 000001d2 c11a9a80 00000001 c11a9a80 c022
2ffc
Sep 16 14:31:19 erde kernel:        000001d2 c0222fe0 c012bb06 00104025 c0122cbc 088ab000 c11a9a80 0000
0001
Sep 16 14:31:19 erde kernel: Call Trace:    [balance_classzone+238/468] [rmqueue+410/676] [do_swap_page
Sep 16 14:31:19 erde kernel: Code: 0f 0b ce 00 d3 83 1f c0 8b 56 04 8b 06 89 50 04 89 02 8b 44

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   ce                        into   
Code;  00000002 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000004 Before first symbol
   5:   83 1f c0                  sbbl   $0xffffffc0,(%edi)
Code;  00000008 Before first symbol
   8:   8b 56 04                  mov    0x4(%esi),%edx
Code;  0000000a Before first symbol
   b:   8b 06                     mov    (%esi),%eax
Code;  0000000c Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

Sep 16 14:31:45 erde kernel:  kernel BUG at page_alloc.c:206!
Sep 16 14:31:45 erde kernel: invalid operand: 0000
Sep 16 14:31:45 erde kernel: CPU:    0
Sep 16 14:31:45 erde kernel: EIP:    0010:[__free_pages_ok+562/716]    Not tainted
Sep 16 14:31:45 erde kernel: EFLAGS: 00010006
Sep 16 14:31:45 erde kernel: eax: 00000000   ebx: c10f193c   ecx: 00001000   edx: 000057d8
Sep 16 14:31:45 erde kernel: esi: c10f193c   edi: 00000000   ebp: c0222e74   esp: c427de20
Sep 16 14:31:45 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 14:31:45 erde kernel: Process kdm_greet (pid: 2252, stackpage=c427d000)
Sep 16 14:31:45 erde kernel: Stack: c0223000 00000141 00000000 c0222e74 000006ee 00000371 00000286 c022
2e8c
Sep 16 14:31:45 erde kernel:        00000000 c0222e74 c012bd16 000001d2 c3409c50 00000371 c1149678 c022
2ffc
Sep 16 14:31:45 erde kernel:        000001d2 c0150444 c012bb06 00000371 c0124eca 00000371 00000006 0000
05cd
Sep 16 14:31:46 erde kernel: Code: 0f 0b ce 00 d3 83 1f c0 8b 56 04 8b 06 89 50 04 89 02 8b 44

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   ce                        into   
Code;  00000002 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000004 Before first symbol
   5:   83 1f c0                  sbbl   $0xffffffc0,(%edi)
Code;  00000008 Before first symbol
   8:   8b 56 04                  mov    0x4(%esi),%edx
Code;  0000000a Before first symbol
   b:   8b 06                     mov    (%esi),%eax
Code;  0000000c Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

Sep 16 14:31:57 erde kernel:  kernel BUG at page_alloc.c:206!
Sep 16 14:31:57 erde kernel: invalid operand: 0000
Sep 16 14:31:57 erde kernel: CPU:    0
Sep 16 14:31:57 erde kernel: EIP:    0010:[__free_pages_ok+562/716]    Not tainted
Sep 16 14:31:57 erde kernel: EFLAGS: 00010006
Sep 16 14:31:57 erde kernel: eax: 00000000   ebx: c10f193c   ecx: 00001000   edx: 000057d8
Sep 16 14:31:57 erde kernel: esi: c10f193c   edi: 00000000   ebp: c0222e74   esp: c4069e54
Sep 16 14:31:57 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 14:31:57 erde kernel: Process kdm_greet (pid: 2269, stackpage=c4069000)
Sep 16 14:31:57 erde kernel: Stack: c0223000 00000141 00000000 c0222e74 00030002 000030b2 00000282 c022
2e8c
Sep 16 14:31:57 erde kernel:        00000000 c0222e74 c012bd16 000001d2 c0c4a480 00000001 c0c4a480 c022
2ffc
Sep 16 14:31:57 erde kernel:        000001d2 c108091c c012bb06 00104025 c0122cbc bfffb89c c0c4a480 0000
0001
Sep 16 14:31:57 erde kernel: Call Trace:    [balance_classzone+238/468] [rmqueue+410/676] [do_swap_page
Sep 16 14:31:57 erde kernel: Code: 0f 0b ce 00 d3 83 1f c0 8b 56 04 8b 06 89 50 04 89 02 8b 44

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   ce                        into   
Code;  00000002 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000004 Before first symbol
   5:   83 1f c0                  sbbl   $0xffffffc0,(%edi)
Code;  00000008 Before first symbol
   8:   8b 56 04                  mov    0x4(%esi),%edx
Code;  0000000a Before first symbol
   b:   8b 06                     mov    (%esi),%eax
Code;  0000000c Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

Sep 16 14:32:08 erde kernel:  kernel BUG at page_alloc.c:206!
Sep 16 14:32:08 erde kernel: invalid operand: 0000
Sep 16 14:32:08 erde kernel: CPU:    0
Sep 16 14:32:08 erde kernel: EIP:    0010:[__free_pages_ok+562/716]    Not tainted
Sep 16 14:32:08 erde kernel: EFLAGS: 00010006
Sep 16 14:32:08 erde kernel: eax: 00000000   ebx: c10f193c   ecx: 00001000   edx: 000057d8
Sep 16 14:32:08 erde kernel: esi: c10f193c   edi: 00000000   ebp: c0222e74   esp: c15b5e7c
Sep 16 14:32:08 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 14:32:08 erde kernel: Process kdm_greet (pid: 2277, stackpage=c15b5000)
Sep 16 14:32:08 erde kernel: Stack: c0223000 00000141 00000000 c0222e74 c3776870 c012630d 00000292 c022
2e8c
Sep 16 14:32:08 erde kernel:        00000000 c0222e74 c012bd16 000001d2 c0c4aa20 00000000 c25659c0 c022
2ffc
Sep 16 14:32:08 erde kernel:        000001d2 c0c4aa20 c012bb06 c1090178 c01227d7 4021baac c0c4aa20 0000
0001
Sep 16 14:32:08 erde kernel: Call Trace:    [nopage_sequential_readahead+177/276] [balance_classzone+23
Sep 16 14:32:08 erde kernel: Code: 0f 0b ce 00 d3 83 1f c0 8b 56 04 8b 06 89 50 04 89 02 8b 44

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   ce                        into   
Code;  00000002 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000004 Before first symbol
   5:   83 1f c0                  sbbl   $0xffffffc0,(%edi)
Code;  00000008 Before first symbol
   8:   8b 56 04                  mov    0x4(%esi),%edx
Code;  0000000a Before first symbol
   b:   8b 06                     mov    (%esi),%eax
Code;  0000000c Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

Sep 16 14:32:22 erde kernel:  kernel BUG at page_alloc.c:206!
Sep 16 14:32:22 erde kernel: invalid operand: 0000
Sep 16 14:32:22 erde kernel: CPU:    0
Sep 16 14:32:22 erde kernel: EIP:    0010:[__free_pages_ok+562/716]    Not tainted
Sep 16 14:32:22 erde kernel: EFLAGS: 00010006
Sep 16 14:32:22 erde kernel: eax: 00000000   ebx: c10f193c   ecx: 00001000   edx: 000057d8
Sep 16 14:32:22 erde kernel: esi: c10f193c   edi: 00000000   ebp: c0222e74   esp: c599fe54
Sep 16 14:32:22 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 14:32:22 erde kernel: Process kdm_greet (pid: 2286, stackpage=c599f000)
Sep 16 14:32:22 erde kernel: Stack: c0223000 00000141 00000000 c0222e74 00030002 00001083 00000282 c022
2e8c
Sep 16 14:32:22 erde kernel:        00000000 c0222e74 c012bd16 000001d2 c0c4a840 00000001 c0c4a840 c022
2ffc
Sep 16 14:32:22 erde kernel:        000001d2 c106359c c012bb06 00104025 c0122cbc 080e3000 c0c4a840 0000
0001
Sep 16 14:32:22 erde kernel: Call Trace:    [balance_classzone+238/468] [rmqueue+410/676] [do_swap_page
Sep 16 14:32:22 erde kernel: Code: 0f 0b ce 00 d3 83 1f c0 8b 56 04 8b 06 89 50 04 89 02 8b 44

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   ce                        into   
Code;  00000002 Before first symbol
   3:   00 d3                     add    %dl,%bl
Code;  00000004 Before first symbol
   5:   83 1f c0                  sbbl   $0xffffffc0,(%edi)
Code;  00000008 Before first symbol
   8:   8b 56 04                  mov    0x4(%esi),%edx
Code;  0000000a Before first symbol
   b:   8b 06                     mov    (%esi),%eax
Code;  0000000c Before first symbol
   d:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000010 Before first symbol
  10:   89 02                     mov    %eax,(%edx)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax


9 warnings issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
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

Sep 20 21:00:04 erde kernel: Unable to handle kernel paging request at virtual address 01c2f6a8
Sep 20 21:00:04 erde kernel: c013d511
Sep 20 21:00:04 erde kernel: *pde = 00000000
Sep 20 21:00:04 erde kernel: Oops: 0000
Sep 20 21:00:04 erde kernel: CPU:    0
Sep 20 21:00:04 erde kernel: EIP:    0010:[sys_select+745/1172]    Not tainted
Sep 20 21:00:04 erde kernel: EFLAGS: 00210246
Sep 20 21:00:04 erde kernel: eax: 00000001   ebx: 00000004   ecx: 0041000d   edx: 01040034
Sep 20 21:00:04 erde kernel: esi: bfffe974   edi: c110cdcc   ebp: 00000000   esp: c09cdf84
Sep 20 21:00:04 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 20 21:00:04 erde kernel: Process kdeinit (pid: 6336, stackpage=c09cd000)
Sep 20 21:00:04 erde kernel: Stack: c09cc000 00000000 00000000 bfffe9f0 00000000 00000023 00000004 c110
cdc0
Sep 20 21:00:04 erde kernel:        7fffffff c110cdc0 c110cdc4 c110cdc8 c110cdcc c110cdd0 c110cdd4 c010
8813
Sep 20 21:00:04 erde kernel:        00000004 bfffe970 00000000 00000000 00000000 bfffe9f0 0000008e c010
002b
Sep 20 21:00:04 erde kernel: Call Trace:    [system_call+51/64]
Sep 20 21:00:04 erde kernel: Code: 02 05 a8 f6 c2 01 74 01 8a 8a 6c 24 34 8b 44 24 40 83 c0 1f
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   02 05 a8 f6 c2 01         add    0x1c2f6a8,%al
Code;  00000006 Before first symbol
   6:   74 01                     je     9 <_EIP+0x9> 00000008 Before first symbol
Code;  00000008 Before first symbol
   8:   8a 8a 6c 24 34 8b         mov    0x8b34246c(%edx),%cl
Code;  0000000e Before first symbol
   e:   44                        inc    %esp
Code;  0000000e Before first symbol
   f:   24 40                     and    $0x40,%al
Code;  00000010 Before first symbol
  11:   83 c0 1f                  add    $0x1f,%eax


1 warning issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
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

Sep 27 16:44:49 erde kernel: Unable to handle kernel paging request at virtual address 008e4078
Sep 27 16:44:49 erde kernel: c0108821
Sep 27 16:44:49 erde kernel: *pde = 00000000
Sep 27 16:44:49 erde kernel: Oops: 0000
Sep 27 16:44:49 erde kernel: CPU:    0
Sep 27 16:44:49 erde kernel: EIP:    0010:[ret_from_sys_call+1/17]    Not tainted
Sep 27 16:44:49 erde kernel: EFLAGS: 00013046
Sep 27 16:44:49 erde kernel: eax: 00000000   ebx: 008e4064   ecx: c45a0270   edx: c45a0270
Sep 27 16:44:49 erde kernel: esi: 00000002   edi: 00000003   ebp: bfffed1c   esp: c3fe3fc4
Sep 27 16:44:49 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 27 16:44:49 erde kernel: Process kpyro.kss (pid: 4886, stackpage=c3fe3000)
Sep 27 16:44:49 erde kernel: Stack: 00000003 bfffedd4 00000002 00000002 00000003 bfffed1c 00000880 c010
002b
Sep 27 16:44:50 erde kernel:        0000002b 00000092 40caa76a 00000023 00200202 bfffecf0 0000002b
Sep 27 16:44:50 erde kernel: Code: 83 7b 14 00 0f 85 a5 00 00 00 83 7b 08 00 75 0f 5b 59 5a 5e
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 7b 14 00               cmpl   $0x0,0x14(%ebx)
Code;  00000004 Before first symbol
   4:   0f 85 a5 00 00 00         jne    af <_EIP+0xaf> 000000ae Before first symbol
Code;  0000000a Before first symbol
   a:   83 7b 08 00               cmpl   $0x0,0x8(%ebx)
Code;  0000000e Before first symbol
   e:   75 0f                     jne    1f <_EIP+0x1f> 0000001e Before first symbol
Code;  00000010 Before first symbol
  10:   5b                        pop    %ebx
Code;  00000010 Before first symbol
  11:   59                        pop    %ecx
Code;  00000012 Before first symbol
  12:   5a                        pop    %edx
Code;  00000012 Before first symbol
  13:   5e                        pop    %esi

Sep 27 22:10:40 erde kernel:  <1>Unable to handle kernel paging request at virtual address e0a1e3e0
Sep 27 22:10:40 erde kernel: c01d1a68
Sep 27 22:10:40 erde kernel: *pde = 00000000
Sep 27 22:10:40 erde kernel: Oops: 0002
Sep 27 22:10:40 erde kernel: CPU:    0
Sep 27 22:10:40 erde kernel: EIP:    0010:[tcp_fastretrans_alert+396/1208]    Not tainted
Sep 27 22:10:40 erde kernel: EFLAGS: 00210002
Sep 27 22:10:40 erde kernel: eax: e0a1e3e0   ebx: c11df800   ecx: c0f5d7e0   edx: 00200246
Sep 27 22:10:40 erde kernel: esi: c11e9ce0   edi: 00000006   ebp: c0f5d834   esp: c1f6ff04
Sep 27 22:10:40 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 27 22:10:40 erde kernel: Process ksysguardd (pid: 6148, stackpage=c1f6f000)
Sep 27 22:10:40 erde kernel: Stack: c1f6ff4c c1f6ff80 c1f6ff4c c5ac9b00 c0f5d7e0 00000000 c0f5d7e0 c0f5
db80
Sep 27 22:10:40 erde kernel:        00000000 c0199b55 c5ac9b00 c1f6ff80 00000006 c1f6ff4c 00000006 c5ac
9b00
Sep 27 22:10:40 erde kernel:        ffffffea 00000006 00001804 000001f4 00000064 00000000 00000000 c019
9d57
Sep 27 22:10:40 erde kernel: Call Trace:    [ll_rw_block+117/432] [end_that_request_first+199/200] [sys
Sep 27 22:10:40 erde kernel: Code: 89 18 52 9d 57 51 8b 81 78 03 00 00 ff d0 01 7c 24 1c 83 c4

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 18                     mov    %ebx,(%eax)
Code;  00000002 Before first symbol
   2:   52                        push   %edx
Code;  00000002 Before first symbol
   3:   9d                        popf   
Code;  00000004 Before first symbol
   4:   57                        push   %edi
Code;  00000004 Before first symbol
   5:   51                        push   %ecx
Code;  00000006 Before first symbol
   6:   8b 81 78 03 00 00         mov    0x378(%ecx),%eax
Code;  0000000c Before first symbol
   c:   ff d0                     call   *%eax
Code;  0000000e Before first symbol
   e:   01 7c 24 1c               add    %edi,0x1c(%esp,1)
Code;  00000012 Before first symbol
  12:   83 c4 00                  add    $0x0,%esp


1 warning issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
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

Sep 28 22:49:56 erde kernel: Unable to handle kernel NULL pointer dereference at virtual address 000000
Sep 28 22:49:56 erde kernel: c01243a9
Sep 28 22:49:56 erde kernel: *pde = 00000000
Sep 28 22:49:56 erde kernel: Oops: 0000
Sep 28 22:49:56 erde kernel: CPU:    0
Sep 28 22:49:56 erde kernel: EIP:    0010:[exit_mmap+129/284]    Not tainted
Sep 28 22:49:56 erde kernel: EFLAGS: 00010282
Sep 28 22:49:56 erde kernel: eax: 00000000   ebx: c1697200   ecx: c1697020   edx: fffffff3
Sep 28 22:49:56 erde kernel: esi: c33e3540   edi: 404e6000   ebp: 00001000   esp: c4ad9ec8
Sep 28 22:49:56 erde kernel: ds: 0018   es: 0018   ss: 0018
Sep 28 22:49:56 erde kernel: Process kdesktop_lock (pid: 5180, stackpage=c4ad9000)
Sep 28 22:49:56 erde kernel: Stack: c33e3540 c4ad8000 c4ad8000 0000000b 00000000 c011484d c33e3540 c33e
3540
Sep 28 22:49:56 erde kernel:        c0118655 c33e3540 c4ad8000 c4ad8000 c4ad9f40 0000000b c011d5da 0000
000b
Sep 28 22:49:56 erde kernel:        0000000b 0000000b c072cb6c c4ad9fc4 c01086af 0000000b 0000000b c4ad
9f40
Sep 28 22:49:56 erde kernel: Call Trace:    [mmput+57/80] [do_exit+141/576] [sig_exit+146/148] [do_sign
Sep 28 22:49:56 erde kernel: Code: 8b 40 08 f6 43 15 08 74 06 ff 80 14 01 00 00 8b 53 28 85 d2
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 08                  mov    0x8(%eax),%eax
Code;  00000002 Before first symbol
   3:   f6 43 15 08               testb  $0x8,0x15(%ebx)
Code;  00000006 Before first symbol
   7:   74 06                     je     f <_EIP+0xf> 0000000e Before first symbol
Code;  00000008 Before first symbol
   9:   ff 80 14 01 00 00         incl   0x114(%eax)
Code;  0000000e Before first symbol
   f:   8b 53 28                  mov    0x28(%ebx),%edx
Code;  00000012 Before first symbol
  12:   85 d2                     test   %edx,%edx


1 warning issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
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

Oct  2 19:30:06 erde kernel: Unable to handle kernel paging request at virtual address 005a7034
Oct  2 19:30:06 erde kernel: c012a0b0
Oct  2 19:30:06 erde kernel: *pde = 00000000
Oct  2 19:30:06 erde kernel: Oops: 0000
Oct  2 19:30:06 erde kernel: CPU:    0
Oct  2 19:30:06 erde kernel: EIP:    0010:[kmalloc+144/244]    Not tainted
Oct  2 19:30:06 erde kernel: EFLAGS: 00210017
Oct  2 19:30:06 erde kernel: eax: c0204ba4   ebx: c110f0a0   ecx: 005a7020   edx: 00000000
Oct  2 19:30:06 erde kernel: esi: c110f0a8   edi: 00200246   ebp: 000001f0   esp: c4cadf60
Oct  2 19:30:06 erde kernel: ds: 0018   es: 0018   ss: 0018
Oct  2 19:30:06 erde kernel: Process artsd (pid: 1311, stackpage=c4cad000)
Oct  2 19:30:06 erde kernel: Stack: 00000029 00000001 c4cac000 fffffff4 c013d214 00000018 000001f0 c013
d31c
Oct  2 19:30:07 erde kernel:        00000004 c4cac000 bffff1c0 bffff194 bffff34c 00200282 00000000 0000
0004
Oct  2 19:30:07 erde kernel:        c0119175 00000009 c4cac000 bffff1a4 bffff240 bffff34c 3d9b2d1e 000d
6ec4

1 warning issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.3 on i586 2.4.19.  Options used
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

Oct  7 12:21:29 erde kernel: Unable to handle kernel paging request at virtual address b68508a0
Oct  7 12:21:29 erde kernel: c013fd11
Oct  7 12:21:29 erde kernel: *pde = 00000000
Oct  7 12:21:29 erde kernel: Oops: 0000
Oct  7 12:21:29 erde kernel: CPU:    0
Oct  7 12:21:30 erde kernel: EIP:    0010:[locks_remove_posix+49/328]    Not tainted
Oct  7 12:21:30 erde kernel: EFLAGS: 00010286
Oct  7 12:21:30 erde kernel: eax: b6850874   ebx: c50c1120   ecx: b6850874   edx: c0345688
Oct  7 12:21:30 erde kernel: esi: c5602000   edi: c0345688   ebp: c5c15440   esp: c5603f80
Oct  7 12:21:30 erde kernel: ds: 0018   es: 0018   ss: 0018
Oct  7 12:21:30 erde kernel: Process ksysguardd (pid: 1288, stackpage=c5603000)
Oct  7 12:21:30 erde kernel: Stack: c50c1120 00000000 c5c15440 bffff1dc c013024e c50c1120 c5c15440 c50c
1120
Oct  7 12:21:30 erde kernel:        c5c15440 c50c1120 08075ee0 00000000 c01302a3 c50c1120 c5c15440 c560
2000
Oct  7 12:21:30 erde kernel:        c0108813 00000004 401740b8 40176b98 08075ee0 00000000 bffff1dc 0000
0006
Oct  7 12:21:30 erde kernel: Call Trace:    [filp_close+82/100] [sys_close+67/84] [system_call+51/64]
Oct  7 12:21:30 erde kernel: Code: f6 40 2c 01 0f 84 fa 00 00 00 39 68 14 0f 85 f1 00 00 00 8b
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 2c 01               testb  $0x1,0x2c(%eax)
Code;  00000004 Before first symbol
   4:   0f 84 fa 00 00 00         je     104 <_EIP+0x104> 00000104 Before first symbol
Code;  0000000a Before first symbol
   a:   39 68 14                  cmp    %ebp,0x14(%eax)
Code;  0000000c Before first symbol
   d:   0f 85 f1 00 00 00         jne    104 <_EIP+0x104> 00000104 Before first symbol
Code;  00000012 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct  7 12:22:53 erde kernel:  <1>Unable to handle kernel paging request at virtual address b68508a0
Oct  7 12:22:53 erde kernel: c0139d03
Oct  7 12:22:53 erde kernel: *pde = 00000000
Oct  7 12:22:53 erde kernel: Oops: 0000
Oct  7 12:22:53 erde kernel: CPU:    0
Oct  7 12:22:53 erde kernel: EIP:    0010:[open_namei+883/1272]    Not tainted
Oct  7 12:22:53 erde kernel: EFLAGS: 00010286
Oct  7 12:22:53 erde kernel: eax: b6850874   ebx: ffffffff   ecx: 00000004   edx: 00000000
Oct  7 12:22:53 erde kernel: esi: c03455e0   edi: c42c5f8c   ebp: 00008001   esp: c42c5f54
Oct  7 12:22:53 erde kernel: ds: 0018   es: 0018   ss: 0018
Oct  7 12:22:53 erde kernel: Process pidof (pid: 1659, stackpage=c42c5000)
Oct  7 12:22:53 erde kernel: Stack: 00008000 c1975000 00000001 bffff9cc 40017000 00000000 00000004 c143
dde0
Oct  7 12:22:53 erde kernel:        c012fe4b c1975000 00008001 00000000 c42c5f8c 00000004 c143dde0 c110
d320
Oct  7 12:22:53 erde kernel:        00000001 bffff9cc 00000000 00000001 00000001 c0130196 c1975000 0000
8000
Oct  7 12:22:53 erde kernel: Call Trace:    [filp_open+51/84] [sys_open+54/132] [system_call+51/64]
Oct  7 12:22:53 erde kernel: Code: f6 40 2c 20 74 0e 55 56 e8 60 52 00 00 89 c3 83 c4 08 eb 02

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 2c 20               testb  $0x20,0x2c(%eax)
Code;  00000004 Before first symbol
   4:   74 0e                     je     14 <_EIP+0x14> 00000014 Before first symbol
Code;  00000006 Before first symbol
   6:   55                        push   %ebp
Code;  00000006 Before first symbol
   7:   56                        push   %esi
Code;  00000008 Before first symbol
   8:   e8 60 52 00 00            call   526d <_EIP+0x526d> 0000526c Before first symbol
Code;  0000000c Before first symbol
   d:   89 c3                     mov    %eax,%ebx
Code;  0000000e Before first symbol
   f:   83 c4 08                  add    $0x8,%esp
Code;  00000012 Before first symbol
  12:   eb 02                     jmp    16 <_EIP+0x16> 00000016 Before first symbol

Oct  7 13:04:38 erde kernel:  <1>Unable to handle kernel paging request at virtual address b68508a0
Oct  7 13:04:38 erde kernel: c0139d03
Oct  7 13:04:38 erde kernel: *pde = 00000000
Oct  7 13:04:38 erde kernel: Oops: 0000
Oct  7 13:04:38 erde kernel: CPU:    0
Oct  7 13:04:38 erde kernel: EIP:    0010:[open_namei+883/1272]    Not tainted
Oct  7 13:04:38 erde kernel: EFLAGS: 00010286
Oct  7 13:04:38 erde kernel: eax: b6850874   ebx: ffffffff   ecx: 00000000   edx: c46b816c
Oct  7 13:04:38 erde kernel: esi: c03455e0   edi: c46b9f8c   ebp: 00008001   esp: c46b9f54
Oct  7 13:04:38 erde kernel: ds: 0018   es: 0018   ss: 0018
Oct  7 13:04:38 erde kernel: Process pidof (pid: 1756, stackpage=c46b9000)
Oct  7 13:04:38 erde kernel: Stack: 00008000 c3a0d000 00000001 bffff98c 40017000 00000000 00000004 c143
dde0
Oct  7 13:04:38 erde kernel:        c012fe4b c3a0d000 00008001 00000000 c46b9f8c 00000004 c143dde0 c110
d320
Oct  7 13:04:38 erde kernel:        00000001 bffff98c 00000000 00000001 00000001 c0130196 c3a0d000 0000
8000
Oct  7 13:04:38 erde kernel: Call Trace:    [filp_open+51/84] [sys_open+54/132] [system_call+51/64]
Oct  7 13:04:38 erde kernel: Code: f6 40 2c 20 74 0e 55 56 e8 60 52 00 00 89 c3 83 c4 08 eb 02

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 2c 20               testb  $0x20,0x2c(%eax)
Code;  00000004 Before first symbol
   4:   74 0e                     je     14 <_EIP+0x14> 00000014 Before first symbol
Code;  00000006 Before first symbol
   6:   55                        push   %ebp
Code;  00000006 Before first symbol
   7:   56                        push   %esi
Code;  00000008 Before first symbol
   8:   e8 60 52 00 00            call   526d <_EIP+0x526d> 0000526c Before first symbol
Code;  0000000c Before first symbol
   d:   89 c3                     mov    %eax,%ebx
Code;  0000000e Before first symbol
   f:   83 c4 08                  add    $0x8,%esp
Code;  00000012 Before first symbol
  12:   eb 02                     jmp    16 <_EIP+0x16> 00000016 Before first symbol


1 warning issued.  Results may not be reliable.

--Kj7319i9nmIyA2yE--
