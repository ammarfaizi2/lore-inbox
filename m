Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSHOP6u>; Thu, 15 Aug 2002 11:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSHOP6u>; Thu, 15 Aug 2002 11:58:50 -0400
Received: from wwns.wwns.com ([216.153.28.2]:6674 "EHLO wwns.wwns.com")
	by vger.kernel.org with ESMTP id <S317189AbSHOP6r>;
	Thu, 15 Aug 2002 11:58:47 -0400
From: David Wilson <david@wwns.com>
Message-Id: <200208151602.LAA22279@wwns.wwns.com>
Subject: RE: Oops 2.4.20-pre2
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Aug 2002 11:02:36 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I really ought to grab the right file first....

ksymoops 2.4.1 on i486 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre2/ (specified)
     -m ./System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): mismatch on symbol xtime  , ksyms_base says c029e950, System.map says c02701d0.  Ignoring ksyms_base entry

Lots of other warnings deleted.  


Unable to handle kernel paging request at virtual address 0bc435e4
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0bc435e4   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: 0bc435e0   edi: c025f360   ebp: c102c888   esp: c03f5e98
ds: 0018   es: 0018   ss: 0018
Process ifup-aliases (pid: 503, stackpage=c03f5000)
Stack: 00000000 00000001 c0125504 c102c888 c0d97900 080e728c 00000001 c025f360 
       c0d97900 c0125dc6 c025f360 c0d97900 080e728c c0f3f39c 01031065 8b084d8b 
       428b5851 14423b10 01b6820f ec830000 902d6a08 e9e6e851 c483fffb 080e728c 
Call Trace:    [<c0125504>] [<c0125dc6>] [<c0113dea>] [<c0121149>] [<c0113c60>]
  [<c0108bc4>]
Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 

>>EIP; c01281d0 <unlock_page+60/90>   <=====
Trace; c0125504 <do_wp_page+64/2a0>
Trace; c0125dc6 <handle_mm_fault+96/e0>
Trace; c0113dea <do_page_fault+18a/4fb>
Trace; c0121149 <sys_rt_sigaction+99/f0>
Trace; c0113c60 <do_page_fault+0/4fb>
Trace; c0108bc4 <error_code+34/40>
Code;  c01281d0 <unlock_page+60/90>
00000000 <_EIP>:
Code;  c01281d0 <unlock_page+60/90>   <=====
   0:   39 46 04                  cmp    %eax,0x4(%esi)   <=====
Code;  c01281d3 <unlock_page+63/90>
   3:   74 1b                     je     20 <_EIP+0x20> c01281f0 <unlock_page+80/90>
Code;  c01281d5 <unlock_page+65/90>
   5:   89 f0                     mov    %esi,%eax
Code;  c01281d7 <unlock_page+67/90>
   7:   5b                        pop    %ebx
Code;  c01281d8 <unlock_page+68/90>
   8:   31 c9                     xor    %ecx,%ecx
Code;  c01281da <unlock_page+6a/90>
   a:   ba 03 00 00 00            mov    $0x3,%edx
Code;  c01281df <unlock_page+6f/90>
   f:   5e                        pop    %esi
Code;  c01281e0 <unlock_page+70/90>
  10:   e9 7b c8 fe 00            jmp    fec890 <_EIP+0xfec890> c1114a60 <END_OF_CODE+e836ac/????>

 <1>Unable to handle kernel paging request at virtual address 0bc435e4
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: 0bc435e4   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: 0bc435e0   edi: c025f2d0   ebp: c102c888   esp: c0475e98
ds: 0018   es: 0018   ss: 0018
Process ifup-aliases (pid: 502, stackpage=c0475000)
Stack: 00000001 00000001 c0125504 c102c888 c0d97810 080e7600 00000001 c025f2d0 
       c0d97810 c0125dc6 c025f2d0 c0d97810 080e7600 c0a9e39c 01031065 00000000 
       000002d5 00000286 00000000 c023f1a0 c023f3c4 c020e109 c0d97788 080e7600 
Call Trace:    [<c0125504>] [<c0125dc6>] [<c020e109>] [<c0113dea>] [<c013ddf1>]
  [<c013de3e>] [<c01363bf>] [<c01169da>] [<c013520c>] [<c0113c60>] [<c0108bc4>]
Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 

>>EIP; c01281d0 <unlock_page+60/90>   <=====
Trace; c0125504 <do_wp_page+64/2a0>
Trace; c0125dc6 <handle_mm_fault+96/e0>
Trace; c020e109 <rb_insert_color+d9/100>
Trace; c0113dea <do_page_fault+18a/4fb>
Trace; c013ddf1 <pipe_release+71/90>
Trace; c013de3e <pipe_write_release+e/20>
Trace; c01363bf <fput+af/d0>
Trace; c01169da <do_fork+69a/7a0>
Trace; c013520c <filp_close+5c/70>
Trace; c0113c60 <do_page_fault+0/4fb>
Trace; c0108bc4 <error_code+34/40>
Code;  c01281d0 <unlock_page+60/90>
00000000 <_EIP>:
Code;  c01281d0 <unlock_page+60/90>   <=====
   0:   39 46 04                  cmp    %eax,0x4(%esi)   <=====
Code;  c01281d3 <unlock_page+63/90>
   3:   74 1b                     je     20 <_EIP+0x20> c01281f0 <unlock_page+80/90>
Code;  c01281d5 <unlock_page+65/90>
   5:   89 f0                     mov    %esi,%eax
Code;  c01281d7 <unlock_page+67/90>
   7:   5b                        pop    %ebx
Code;  c01281d8 <unlock_page+68/90>
   8:   31 c9                     xor    %ecx,%ecx
Code;  c01281da <unlock_page+6a/90>
   a:   ba 03 00 00 00            mov    $0x3,%edx
Code;  c01281df <unlock_page+6f/90>
   f:   5e                        pop    %esi
Code;  c01281e0 <unlock_page+70/90>
  10:   e9 7b c8 fe 00            jmp    fec890 <_EIP+0xfec890> c1114a60 <END_OF_CODE+e836ac/????>

 <1>Unable to handle kernel paging request at virtual address aea43a04
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: aea43a04   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: aea43a00   edi: c025f1b0   ebp: c102c8e0   esp: c03afe98
ds: 0018   es: 0018   ss: 0018
Process S17keytable (pid: 605, stackpage=c03af000)
Stack: 00000000 00000001 c0125504 c102c8e0 c025dc70 080d1b60 00000001 c025f1b0 
       c025dc70 c0125dc6 c025f1b0 c025dc70 080d1b60 c039b344 01033065 00000000 
       00000e7f 00000286 00000000 c023f1a0 c023f3c4 c020e109 c05eeaf8 080d1b60 
Call Trace:    [<c0125504>] [<c0125dc6>] [<c020e109>] [<c0113dea>] [<c0115f8c>]
  [<c01169da>] [<c013c344>] [<c0113c60>] [<c0108bc4>]
Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 

>>EIP; c01281d0 <unlock_page+60/90>   <=====
Trace; c0125504 <do_wp_page+64/2a0>
Trace; c0125dc6 <handle_mm_fault+96/e0>
Trace; c020e109 <rb_insert_color+d9/100>
Trace; c0113dea <do_page_fault+18a/4fb>
Trace; c0115f8c <copy_mm+29c/2d0>
Trace; c01169da <do_fork+69a/7a0>
Trace; c013c344 <sys_stat64+64/70>
Trace; c0113c60 <do_page_fault+0/4fb>
Trace; c0108bc4 <error_code+34/40>
Code;  c01281d0 <unlock_page+60/90>
00000000 <_EIP>:
Code;  c01281d0 <unlock_page+60/90>   <=====
   0:   39 46 04                  cmp    %eax,0x4(%esi)   <=====
Code;  c01281d3 <unlock_page+63/90>
   3:   74 1b                     je     20 <_EIP+0x20> c01281f0 <unlock_page+80/90>
Code;  c01281d5 <unlock_page+65/90>
   5:   89 f0                     mov    %esi,%eax
Code;  c01281d7 <unlock_page+67/90>
   7:   5b                        pop    %ebx
Code;  c01281d8 <unlock_page+68/90>
   8:   31 c9                     xor    %ecx,%ecx
Code;  c01281da <unlock_page+6a/90>
   a:   ba 03 00 00 00            mov    $0x3,%edx
Code;  c01281df <unlock_page+6f/90>
   f:   5e                        pop    %esi
Code;  c01281e0 <unlock_page+70/90>
  10:   e9 7b c8 fe 00            jmp    fec890 <_EIP+0xfec890> c1114a60 <END_OF_CODE+e836ac/????>

 <1>Unable to handle kernel paging request at virtual address aea43a04
c01281d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01281d0>]    Not tainted
EFLAGS: 00010286
eax: aea43a04   ebx: c023f254   ecx: 00000020   edx: ffffffff
esi: aea43a00   edi: 00000305   ebp: 00068052   esp: c078bdb0
ds: 0018   es: 0018   ss: 0018
Process find (pid: 811, stackpage=c078b000)
Stack: c102c8e0 00001000 c01394ab c102c8e0 00000305 00068053 00001000 00000000 
       00000305 00001000 00068052 c0137258 00000305 00068052 00001000 c0c03400 
       00068052 000001a0 0004e880 c013749c 00000305 00068052 00001000 c028d8c4 
Call Trace:    [<c01394ab>] [<c0137258>] [<c013749c>] [<c01a71d1>] [<c01365db>]
  [<c015b770>] [<c015b7f5>] [<c015cb88>] [<c0148be2>] [<c0148c73>] [<c0148eb2>]
  [<c0157cdc>] [<c015cd08>] [<c013e76f>] [<c013ef8b>] [<c013e498>] [<c013f623>]
  [<c013c364>] [<c0108ab3>]
Code: 39 46 04 74 1b 89 f0 5b 31 c9 ba 03 00 00 00 5e e9 7b c8 fe 

>>EIP; c01281d0 <unlock_page+60/90>   <=====
Trace; c01394ab <grow_buffers+eb/110>
Trace; c0137258 <getblk+48/60>
Trace; c013749c <bread+1c/80>
Trace; c01a71d1 <ide_do_request+2d1/320>
Trace; c01365db <end_buffer_io_sync+2b/30>
Trace; c015b770 <ext3_get_inode_loc+130/1a0>
Trace; c015b7f5 <ext3_read_inode+15/2e0>
Trace; c015cb88 <ext3_find_entry+248/370>
Trace; c0148be2 <get_new_inode+42/170>
Trace; c0148c73 <get_new_inode+d3/170>
Trace; c0148eb2 <iget4+c2/d0>
Trace; c0157cdc <ext3_readdir+42c/440>
Trace; c015cd08 <ext3_lookup+58/90>
Trace; c013e76f <real_lookup+4f/c0>
Trace; c013ef8b <link_path_walk+6ab/990>
Trace; c013e498 <getname+68/b0>
Trace; c013f623 <__user_walk+33/50>
Trace; c013c364 <sys_lstat64+14/70>
Trace; c0108ab3 <system_call+33/40>
Code;  c01281d0 <unlock_page+60/90>
00000000 <_EIP>:
Code;  c01281d0 <unlock_page+60/90>   <=====
   0:   39 46 04                  cmp    %eax,0x4(%esi)   <=====
Code;  c01281d3 <unlock_page+63/90>
   3:   74 1b                     je     20 <_EIP+0x20> c01281f0 <unlock_page+80/90>
Code;  c01281d5 <unlock_page+65/90>
   5:   89 f0                     mov    %esi,%eax
Code;  c01281d7 <unlock_page+67/90>
   7:   5b                        pop    %ebx
Code;  c01281d8 <unlock_page+68/90>
   8:   31 c9                     xor    %ecx,%ecx
Code;  c01281da <unlock_page+6a/90>
   a:   ba 03 00 00 00            mov    $0x3,%edx
Code;  c01281df <unlock_page+6f/90>
   f:   5e                        pop    %esi
Code;  c01281e0 <unlock_page+70/90>
  10:   e9 7b c8 fe 00            jmp    fec890 <_EIP+0xfec890> c1114a60 <END_OF_CODE+e836ac/????>


1011 warnings issued.  Results may not be reliable.



-- 
David R. Wilson  WB4LHO
World Wide Network Services
Nashville, Tennessee USA
david@wwns.com


