Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSIZGiX>; Thu, 26 Sep 2002 02:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSIZGiW>; Thu, 26 Sep 2002 02:38:22 -0400
Received: from mail.uklinux.net ([80.84.72.21]:10769 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S262207AbSIZGiS>;
	Thu, 26 Sep 2002 02:38:18 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15762.44049.335196.949161@titan.home.hindley.uklinux.net>
Date: Thu, 26 Sep 2002 07:41:21 +0100 (BST)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More 2.4.19 oopses
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am still getting multiple oopses and recurrent lockups. See below.

Advice please:

Am I helping by reporting them?

Are they real?

Is it more likely that I have a hardware problem? I have checked the
memory with memtest with no errors.

Thanks

Mark

--- working directory: /var/log/
% ksymoops -m /boot/System.map /var/log/syslog.0
ksymoops 2.3.7 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map (specified)

Sep 25 18:56:32 titan kernel: Unable to handle kernel paging request at virtual address ffd04fec
Sep 25 18:56:32 titan kernel: c01448ef
Sep 25 18:56:32 titan kernel: *pde = 00001063
Sep 25 18:56:32 titan kernel: Oops: 0000
Sep 25 18:56:32 titan kernel: CPU:    0
Sep 25 18:56:32 titan kernel: EIP:    0010:[proc_info_read+135/276]    Not tainted
Sep 25 18:56:32 titan kernel: EFLAGS: 00010256
Sep 25 18:56:32 titan kernel: eax: 0000001f   ebx: ffd04fe8   ecx: fffffff8   edx: 00000000
Sep 25 18:56:32 titan kernel: esi: c19fc000   edi: 000001ff   ebp: c0f3bf98   esp: c0f1bf74
Sep 25 18:56:32 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 18:56:32 titan kernel: Process top (pid: 508, stackpage=c0f1b000)
Sep 25 18:56:32 titan kernel: Stack: 00020000 c305ab60 ffffffea 00000008 c211cce0 c10b6360 0000002a 00000286 
Sep 25 18:56:32 titan kernel:        c281d000 c0f1bfbc c012c197 c305ab60 400297c0 000001ff c305ab80 c0f1a000 
Sep 25 18:56:32 titan kernel:        400296e0 00000008 bffffb6c c01087c3 00000008 400297c0 000001ff 400296e0 
Sep 25 18:56:32 titan kernel: Call Trace:    [sys_read+151/244] [system_call+51/64]
Sep 25 18:56:32 titan kernel: Code: 8b 4b 04 39 4d f4 7f 19 75 07 8b 45 f0 3b 03 77 10 8b 45 fc 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  00000003 Before first symbol
   3:   39 4d f4                  cmp    %ecx,0xfffffff4(%ebp)
Code;  00000006 Before first symbol
   6:   7f 19                     jg     21 <_EIP+0x21> 00000021 Before first symbol
Code;  00000008 Before first symbol
   8:   75 07                     jne    11 <_EIP+0x11> 00000011 Before first symbol
Code;  0000000a Before first symbol
   a:   8b 45 f0                  mov    0xfffffff0(%ebp),%eax
Code;  0000000d Before first symbol
   d:   3b 03                     cmp    (%ebx),%eax
Code;  0000000f Before first symbol
   f:   77 10                     ja     21 <_EIP+0x21> 00000021 Before first symbol
Code;  00000011 Before first symbol
  11:   8b 45 fc                  mov    0xfffffffc(%ebp),%eax

Sep 25 19:37:01 titan kernel: Unable to handle kernel paging request at virtual address 5a000004
Sep 25 19:37:01 titan kernel: c013d906
Sep 25 19:37:01 titan kernel: *pde = 00000000
Sep 25 19:37:01 titan kernel: Oops: 0000
Sep 25 19:37:01 titan kernel: CPU:    0
Sep 25 19:37:01 titan kernel: EIP:    0010:[get_new_inode+190/360]    Not tainted
Sep 25 19:37:01 titan kernel: EFLAGS: 00010286
Sep 25 19:37:01 titan kernel: eax: 5a000000   ebx: 00000000   ecx: 00000000   edx: c11cae00
Sep 25 19:37:01 titan kernel: esi: c11af080   edi: c10bb268   ebp: c3af5ec4   esp: c3af5eb8
Sep 25 19:37:01 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 19:37:01 titan kernel: Process cron (pid: 484, stackpage=c3af5000)
Sep 25 19:37:01 titan kernel: Stack: 00000000 c10bb268 0000e041 c3af5eec c013db33 c11cae00 0000e041 c10bb268 
Sep 25 19:37:01 titan kernel:        00000000 00000000 c2670da0 c119b280 c2670da0 c3af5f0c c014ce02 c11cae00 
Sep 25 19:37:01 titan kernel:        0000e041 00000000 00000000 fffffff4 c119b280 c3af5f28 c013443c c119b280 
Sep 25 19:37:01 titan kernel: Call Trace:    [iget4+187/196] [ext2_lookup+66/104] [real_lookup+88/196] [link_path_walk+1447/2080] [path_walk+29/32]
Sep 25 19:37:01 titan kernel: Code: 83 78 04 00 74 14 8b 55 18 52 56 8b 40 04 ff d0 83 c4 08 eb 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 04 00               cmpl   $0x0,0x4(%eax)
Code;  00000004 Before first symbol
   4:   74 14                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000006 Before first symbol
   6:   8b 55 18                  mov    0x18(%ebp),%edx
Code;  00000009 Before first symbol
   9:   52                        push   %edx
Code;  0000000a Before first symbol
   a:   56                        push   %esi
Code;  0000000b Before first symbol
   b:   8b 40 04                  mov    0x4(%eax),%eax
Code;  0000000e Before first symbol
   e:   ff d0                     call   *%eax
Code;  00000010 Before first symbol
  10:   83 c4 08                  add    $0x8,%esp
Code;  00000013 Before first symbol
  13:   eb 00                     jmp    15 <_EIP+0x15> 00000015 Before first symbol

Sep 25 19:37:02 titan kernel:  <1>Unable to handle kernel paging request at virtual address 5a000004
Sep 25 19:37:02 titan kernel: c013d906
Sep 25 19:37:02 titan kernel: *pde = 00000000
Sep 25 19:37:02 titan kernel: Oops: 0000
Sep 25 19:37:02 titan kernel: CPU:    0
Sep 25 19:37:02 titan kernel: EIP:    0010:[get_new_inode+190/360]    Not tainted
Sep 25 19:37:02 titan kernel: EFLAGS: 00010282
Sep 25 19:37:02 titan kernel: eax: 5a000000   ebx: 00000000   ecx: 00000000   edx: c11cae00
Sep 25 19:37:02 titan kernel: esi: c3e71820   edi: c10bf258   ebp: c3af5d64   esp: c3af5d58
Sep 25 19:37:02 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 19:37:02 titan kernel: Process watch (pid: 15358, stackpage=c3af5000)
Sep 25 19:37:02 titan kernel: Stack: 00000000 c10bf258 0000284b c3af5d8c c013db33 c11cae00 0000284b c10bf258 
Sep 25 19:37:02 titan kernel:        00000000 00000000 c1471560 c11af260 c1471560 c3af5dac c014ce02 c11cae00 
Sep 25 19:37:02 titan kernel:        0000284b 00000000 00000000 fffffff4 c11af260 c3af5dc8 c013443c c11af260 
Sep 25 19:37:02 titan kernel: Call Trace:    [iget4+187/196] [ext2_lookup+66/104] [real_lookup+88/196] [link_path_walk+601/2080] [path_walk+29/32]
Sep 25 19:37:02 titan kernel: Code: 83 78 04 00 74 14 8b 55 18 52 56 8b 40 04 ff d0 83 c4 08 eb 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 04 00               cmpl   $0x0,0x4(%eax)
Code;  00000004 Before first symbol
   4:   74 14                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000006 Before first symbol
   6:   8b 55 18                  mov    0x18(%ebp),%edx
Code;  00000009 Before first symbol
   9:   52                        push   %edx
Code;  0000000a Before first symbol
   a:   56                        push   %esi
Code;  0000000b Before first symbol
   b:   8b 40 04                  mov    0x4(%eax),%eax
Code;  0000000e Before first symbol
   e:   ff d0                     call   *%eax
Code;  00000010 Before first symbol
  10:   83 c4 08                  add    $0x8,%esp
Code;  00000013 Before first symbol
  13:   eb 00                     jmp    15 <_EIP+0x15> 00000015 Before first symbol

Sep 25 19:44:22 titan kernel:  <1>Unable to handle kernel paging request at virtual address ffab020b
Sep 25 19:44:22 titan kernel: c012ce32
Sep 25 19:44:22 titan kernel: *pde = 00000000
Sep 25 19:44:22 titan kernel: Oops: 0002
Sep 25 19:44:22 titan kernel: CPU:    0
Sep 25 19:44:22 titan kernel: EIP:    0010:[file_move+26/44]    Not tainted
Sep 25 19:44:22 titan kernel: EFLAGS: 00010282
Sep 25 19:44:22 titan kernel: eax: ffab0207   ebx: c11cae70   ecx: c1624140   edx: c1a4c420
Sep 25 19:44:22 titan kernel: esi: c3eb29a0   edi: ffffffe9   ebp: c1831f50   esp: c1831f4c
Sep 25 19:44:22 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 19:44:22 titan kernel: Process xscreensaver (pid: 1541, stackpage=c1831000)
Sep 25 19:44:22 titan kernel: Stack: c1624140 c1831f6c c012ba72 c1624140 c11cae70 00000000 c3e5c000 00000001 
Sep 25 19:44:22 titan kernel:        c1831fa0 c012b9c8 c269e1e0 c10b6320 00000000 00000008 c269e1e0 c10b6320 
Sep 25 19:44:22 titan kernel:        00000001 00000000 c09dcdc0 00000001 00000001 c1831fbc c012bce7 c3e5c000 
Sep 25 19:44:22 titan kernel: Call Trace:    [dentry_open+162/388] [filp_open+64/72] [sys_open+51/132] [system_call+51/64]
Sep 25 19:44:22 titan kernel: Code: 89 48 04 89 01 89 59 04 89 0b 8d 74 26 00 5b c9 c3 90 55 89 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  00000008 Before first symbol
   8:   89 0b                     mov    %ecx,(%ebx)
Code;  0000000a Before first symbol
   a:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000e Before first symbol
   e:   5b                        pop    %ebx
Code;  0000000f Before first symbol
   f:   c9                        leave  
Code;  00000010 Before first symbol
  10:   c3                        ret    
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   55                        push   %ebp
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

Sep 25 19:44:22 titan kernel:  <1>Unable to handle kernel paging request at virtual address 00040064
Sep 25 19:44:22 titan kernel: c013b560
Sep 25 19:44:22 titan kernel: *pde = 00000000
Sep 25 19:44:22 titan kernel: Oops: 0000
Sep 25 19:44:22 titan kernel: CPU:    0
Sep 25 19:44:22 titan kernel: EIP:    0010:[locks_remove_flock+36/76]    Not tainted
Sep 25 19:44:22 titan kernel: EFLAGS: 00010202
Sep 25 19:44:22 titan kernel: eax: 00040038   ebx: c11cae00   ecx: 40400000   edx: c11cae00
Sep 25 19:44:22 titan kernel: esi: c07d49a0   edi: c10b6320   ebp: c2833e98   esp: c2833e90
Sep 25 19:44:22 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 19:44:22 titan kernel: Process forest (pid: 15277, stackpage=c2833000)
Sep 25 19:44:22 titan kernel: Stack: c07d49a0 c10ebdc8 c2833eb4 c012ccff c07d49a0 c12db600 c1be8820 40238000 
Sep 25 19:44:22 titan kernel:        c10ebdc0 c2833ed0 c0120548 c1be8820 c2832000 c2832000 00004000 c12db720 
Sep 25 19:44:22 titan kernel:        c2833ee0 c0111303 c1be8820 c1be8820 c2833ef8 c01150cd c1be8820 c2832000 
Sep 25 19:44:22 titan kernel: Call Trace:    [fput+43/220] [exit_mmap+204/284] [mmput+59/84] [do_exit+149/568] [sig_exit+143/144]
Sep 25 19:44:22 titan kernel: Code: f6 40 2c 22 74 12 39 70 28 75 0d 6a 00 53 e8 6d e6 ff ff 83 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 2c 22               testb  $0x22,0x2c(%eax)
Code;  00000004 Before first symbol
   4:   74 12                     je     18 <_EIP+0x18> 00000018 Before first symbol
Code;  00000006 Before first symbol
   6:   39 70 28                  cmp    %esi,0x28(%eax)
Code;  00000009 Before first symbol
   9:   75 0d                     jne    18 <_EIP+0x18> 00000018 Before first symbol
Code;  0000000b Before first symbol
   b:   6a 00                     push   $0x0
Code;  0000000d Before first symbol
   d:   53                        push   %ebx
Code;  0000000e Before first symbol
   e:   e8 6d e6 ff ff            call   ffffe680 <_EIP+0xffffe680> ffffe680 <END_OF_CODE+3b6a3721/????>
Code;  00000013 Before first symbol
  13:   83 00 00                  addl   $0x0,(%eax)

Sep 25 20:55:25 titan kernel:  <1>Unable to handle kernel paging request at virtual address 4154535c
Sep 25 20:55:25 titan kernel: c013d906
Sep 25 20:55:25 titan kernel: *pde = 00000000
Sep 25 20:55:25 titan kernel: Oops: 0000
Sep 25 20:55:25 titan kernel: CPU:    0
Sep 25 20:55:25 titan kernel: EIP:    0010:[get_new_inode+190/360]    Not tainted
Sep 25 20:55:25 titan kernel: EFLAGS: 00010286
Sep 25 20:55:25 titan kernel: eax: 41545358   ebx: 00000000   ecx: 00000000   edx: c11cae00
Sep 25 20:55:25 titan kernel: esi: c37de060   edi: c10bcde8   ebp: c2bd3e90   esp: c2bd3e84
Sep 25 20:55:25 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 20:55:25 titan kernel: Process gpm (pid: 375, stackpage=c2bd3000)
Sep 25 20:55:25 titan kernel: Stack: 00000000 c10bcde8 0000f3b0 c2bd3eb8 c013db33 c11cae00 0000f3b0 c10bcde8 
Sep 25 20:55:25 titan kernel:        00000000 00000000 c0fbbe40 c11af440 c0fbbe40 c2bd3ed8 c014ce02 c11cae00 
Sep 25 20:55:25 titan kernel:        0000f3b0 00000000 00000000 fffffff4 c11af440 c2bd3ef4 c013443c c11af440 
Sep 25 20:55:25 titan kernel: Call Trace:    [iget4+187/196] [ext2_lookup+66/104] [real_lookup+88/196] [link_path_walk+1447/2080] [free_pages+29/32]
Sep 25 20:55:25 titan kernel: Code: 83 78 04 00 74 14 8b 55 18 52 56 8b 40 04 ff d0 83 c4 08 eb 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 04 00               cmpl   $0x0,0x4(%eax)
Code;  00000004 Before first symbol
   4:   74 14                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000006 Before first symbol
   6:   8b 55 18                  mov    0x18(%ebp),%edx
Code;  00000009 Before first symbol
   9:   52                        push   %edx
Code;  0000000a Before first symbol
   a:   56                        push   %esi
Code;  0000000b Before first symbol
   b:   8b 40 04                  mov    0x4(%eax),%eax
Code;  0000000e Before first symbol
   e:   ff d0                     call   *%eax
Code;  00000010 Before first symbol
  10:   83 c4 08                  add    $0x8,%esp
Code;  00000013 Before first symbol
  13:   eb 00                     jmp    15 <_EIP+0x15> 00000015 Before first symbol

Sep 25 22:46:39 titan kernel: Unable to handle kernel paging request at virtual address 0060005d
Sep 25 22:46:39 titan kernel: c012ce32
Sep 25 22:46:39 titan kernel: *pde = 00000000
Sep 25 22:46:39 titan kernel: Oops: 0002
Sep 25 22:46:39 titan kernel: CPU:    0
Sep 25 22:46:39 titan kernel: EIP:    0010:[file_move+26/44]    Not tainted
Sep 25 22:46:39 titan kernel: EFLAGS: 00013282
Sep 25 22:46:39 titan kernel: eax: 00600059   ebx: c11cae70   ecx: c11a7620   edx: c11a73a0
Sep 25 22:46:39 titan kernel: esi: c2a73620   edi: 00000000   ebp: c19fdf50   esp: c19fdf4c
Sep 25 22:46:39 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 22:46:39 titan kernel: Process X (pid: 1531, stackpage=c19fd000)
Sep 25 22:46:39 titan kernel: Stack: c11a7620 c19fdf6c c012ba72 c11a7620 c11cae70 00000882 c3a95000 0842e1b0 
Sep 25 22:46:39 titan kernel:        c19fdfa0 c012b9c8 c2c941a0 c10b6320 00000882 0000000e c2c941a0 c10b6320 
Sep 25 22:46:39 titan kernel:        0842e1b0 00000000 c3af3be0 00000001 00000001 c19fdfbc c012bce7 c3a95000 
Sep 25 22:46:39 titan kernel: Call Trace:    [dentry_open+162/388] [filp_open+64/72] [sys_open+51/132] [system_call+51/64]
Sep 25 22:46:39 titan kernel: Code: 89 48 04 89 01 89 59 04 89 0b 8d 74 26 00 5b c9 c3 90 55 89 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  00000008 Before first symbol
   8:   89 0b                     mov    %ecx,(%ebx)
Code;  0000000a Before first symbol
   a:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000e Before first symbol
   e:   5b                        pop    %ebx
Code;  0000000f Before first symbol
   f:   c9                        leave  
Code;  00000010 Before first symbol
  10:   c3                        ret    
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   55                        push   %ebp
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


Done 07:37:42
