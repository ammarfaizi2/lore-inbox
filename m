Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRKZLBJ>; Mon, 26 Nov 2001 06:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280612AbRKZLAy>; Mon, 26 Nov 2001 06:00:54 -0500
Received: from ns.tasking.nl ([195.193.207.2]:31247 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S278660AbRKZLAd>;
	Mon, 26 Nov 2001 06:00:33 -0500
Date: Mon, 26 Nov 2001 11:58:57 +0100
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15 Oops
Message-ID: <20011126115856.A6767@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.5 on i686 2.4.14-x58.  Options used
     -V (default)
     -k /tmp/2.4.15-x60.ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14-x58/ (default)
     -m /boot/System.map-2.4.15-x60 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Nov 26 09:43:12 espoo kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Nov 26 09:43:12 espoo kernel: c013f5fe 
Nov 26 09:43:12 espoo kernel: *pde = 00000000 
Nov 26 09:43:12 espoo kernel: Oops: 0002 
Nov 26 09:43:12 espoo kernel: CPU:    0 
Nov 26 09:43:12 espoo kernel: EIP:    0010:[<c013f5fe>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 26 09:43:12 espoo kernel: EFLAGS: 00010202 
Nov 26 09:43:12 espoo kernel: eax: c03b0e24   ebx: c56f2564   ecx: 00000002   edx: 00000000 
Nov 26 09:43:12 espoo kernel: esi: c668d898   edi: c2a6aa20   ebp: 000002af   esp: c7e89f58 
Nov 26 09:43:12 espoo kernel: ds: 0018   es: 0018   ss: 0018 
Nov 26 09:43:12 espoo kernel: Process kswapd (pid: 4, stackpage=c7e89000) 
Nov 26 09:43:12 espoo kernel: Stack: 00000019 000001d0 00000020 00000006 c013f97b 000003cc c0129885 00000006  
Nov 26 09:43:12 espoo kernel:        000001d0 00000006 000001d0 c03b01e8 c7e88000 000044c8 c03b01e8 c01298bc  
Nov 26 09:43:12 espoo kernel:        00000020 c03b01fc c03b01e8 00000001 c012996f c03b0140 00000000 c7e89fe0  
Nov 26 09:43:12 espoo kernel: Call Trace: [<c013f97b>] [<c0129885>] [<c01298bc>] [<c012996f>] [<c01299de>]  
Nov 26 09:43:12 espoo kernel:    [<c0129af7>] [<c0105000>] [<c01056ab>]  
Nov 26 09:43:12 espoo kernel: Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54 a8 08 74 21 24 f7 89  

>>EIP; c013f5fe <prune_dcache+22/14c>   <=====
Trace; c013f97b <shrink_dcache_memory+1b/34>
Trace; c0129885 <shrink_caches+71/88>
Trace; c01298bc <try_to_free_pages+20/40>
Trace; c012996f <kswapd_balance_pgdat+57/b0>
Trace; c01299de <kswapd_balance+16/2c>
Trace; c0129af7 <kswapd+a3/cc>
Trace; c0105000 <_stext+0/0>
Trace; c01056ab <kernel_thread+23/30>
Code;  c013f5fe <prune_dcache+22/14c>
00000000 <_EIP>:
Code;  c013f5fe <prune_dcache+22/14c>   <=====
   0:   89 02                     movl   %eax,(%edx)   <=====
Code;  c013f600 <prune_dcache+24/14c>
   2:   89 1b                     movl   %ebx,(%ebx)
Code;  c013f602 <prune_dcache+26/14c>
   4:   89 5b 04                  movl   %ebx,0x4(%ebx)
Code;  c013f605 <prune_dcache+29/14c>
   7:   8d 73 e8                  leal   0xffffffe8(%ebx),%esi
Code;  c013f608 <prune_dcache+2c/14c>
   a:   8b 46 54                  movl   0x54(%esi),%eax
Code;  c013f60b <prune_dcache+2f/14c>
   d:   a8 08                     testb  $0x8,%al
Code;  c013f60d <prune_dcache+31/14c>
   f:   74 21                     je     32 <_EIP+0x32> c013f630 <prune_dcache+54/14c>
Code;  c013f60f <prune_dcache+33/14c>
  11:   24 f7                     andb   $0xf7,%al
Code;  c013f611 <prune_dcache+35/14c>
  13:   89 00                     movl   %eax,(%eax)

Nov 26 09:43:15 espoo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Nov 26 09:43:15 espoo kernel: c013f5f6 
Nov 26 09:43:15 espoo kernel: *pde = 00000000 
Nov 26 09:43:15 espoo kernel: Oops: 0000 
Nov 26 09:43:15 espoo kernel: CPU:    0 
Nov 26 09:43:15 espoo kernel: EIP:    0010:[<c013f5f6>]    Not tainted 
Nov 26 09:43:15 espoo kernel: EFLAGS: 00010213 
Nov 26 09:43:15 espoo kernel: eax: 000003a8   ebx: 00000000   ecx: 00000006   edx: 00000002 
Nov 26 09:43:15 espoo kernel: esi: 000001d2   edi: 00000020   ebp: 000003a8   esp: c78f5df4 
Nov 26 09:43:15 espoo kernel: ds: 0018   es: 0018   ss: 0018 
Nov 26 09:43:15 espoo kernel: Process tm (pid: 19237, stackpage=c78f5000) 
Nov 26 09:43:15 espoo kernel: Stack: 00000002 000001d2 00000020 00000006 c013f97b 000003a8 c0129885 00000006  
Nov 26 09:43:15 espoo kernel:        000001d2 00000006 000001d2 c03b01e8 000001d2 00004afc c03b01e8 c01298bc  
Nov 26 09:43:15 espoo kernel:        00000020 00000000 00000000 c78f4000 c012a297 c03b0364 000000ff 00000000  
Nov 26 09:43:15 espoo kernel: Call Trace: [<c013f97b>] [<c0129885>] [<c01298bc>] [<c012a297>] [<c012a563>]  
Nov 26 09:43:15 espoo kernel:    [<c012a228>] [<c0120b48>] [<c0120bdf>] [<c0120d15>] [<c01111e0>] [<c011107c>]  
Nov 26 09:43:15 espoo kernel:    [<c0121efb>] [<c0120ff2>] [<c0106ec4>]  
Nov 26 09:43:15 espoo kernel: Code: 8b 03 8b 53 04 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46  

>>EIP; c013f5f6 <prune_dcache+1a/14c>   <=====
Trace; c013f97b <shrink_dcache_memory+1b/34>
Trace; c0129885 <shrink_caches+71/88>
Trace; c01298bc <try_to_free_pages+20/40>
Trace; c012a297 <balance_classzone+6b/238>
Trace; c012a563 <__alloc_pages+ff/15c>
Trace; c012a228 <_alloc_pages+18/1c>
Trace; c0120b48 <do_anonymous_page+30/94>
Trace; c0120bdf <do_no_page+33/10c>
Trace; c0120d15 <handle_mm_fault+5d/c4>
Trace; c01111e0 <do_page_fault+164/4c4>
Trace; c011107c <do_page_fault+0/4c4>
Trace; c0121efb <do_brk+11b/200>
Trace; c0120ff2 <sys_brk+c2/f0>
Trace; c0106ec4 <error_code+34/40>
Code;  c013f5f6 <prune_dcache+1a/14c>
00000000 <_EIP>:
Code;  c013f5f6 <prune_dcache+1a/14c>   <=====
   0:   8b 03                     movl   (%ebx),%eax   <=====
Code;  c013f5f8 <prune_dcache+1c/14c>
   2:   8b 53 04                  movl   0x4(%ebx),%edx
Code;  c013f5fb <prune_dcache+1f/14c>
   5:   89 50 04                  movl   %edx,0x4(%eax)
Code;  c013f5fe <prune_dcache+22/14c>
   8:   89 02                     movl   %eax,(%edx)
Code;  c013f600 <prune_dcache+24/14c>
   a:   89 1b                     movl   %ebx,(%ebx)
Code;  c013f602 <prune_dcache+26/14c>
   c:   89 5b 04                  movl   %ebx,0x4(%ebx)
Code;  c013f605 <prune_dcache+29/14c>
   f:   8d 73 e8                  leal   0xffffffe8(%ebx),%esi
Code;  c013f608 <prune_dcache+2c/14c>
  12:   8b 46 00                  movl   0x0(%esi),%eax

Nov 26 09:45:08 espoo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Nov 26 09:45:08 espoo kernel: c013f5f6 
Nov 26 09:45:08 espoo kernel: *pde = 00000000 
Nov 26 09:45:08 espoo kernel: Oops: 0000 
Nov 26 09:45:08 espoo kernel: CPU:    0 
Nov 26 09:45:08 espoo kernel: EIP:    0010:[<c013f5f6>]    Not tainted 
Nov 26 09:45:08 espoo kernel: EFLAGS: 00010213 
Nov 26 09:45:08 espoo kernel: eax: 000003ac   ebx: 00000000   ecx: 00000006   edx: 00000002 
Nov 26 09:45:08 espoo kernel: esi: 000001d2   edi: 00000020   ebp: 000003ac   esp: c17addf4 
Nov 26 09:45:08 espoo kernel: ds: 0018   es: 0018   ss: 0018 
Nov 26 09:45:08 espoo kernel: Process tm (pid: 19262, stackpage=c17ad000) 
Nov 26 09:45:08 espoo kernel: Stack: 00000005 000001d2 00000020 00000006 c013f97b 000003ac c0129885 00000006  
Nov 26 09:45:08 espoo kernel:        000001d2 00000006 000001d2 c03b01e8 000001d2 0000401e c03b01e8 c01298bc  
Nov 26 09:45:08 espoo kernel:        00000020 00000000 00000000 c17ac000 c012a297 c03b0364 000000ff 00000000  
Nov 26 09:45:08 espoo kernel: Call Trace: [<c013f97b>] [<c0129885>] [<c01298bc>] [<c012a297>] [<c012a563>]  
Nov 26 09:45:08 espoo kernel:    [<c012a228>] [<c0120b48>] [<c0120bdf>] [<c0120d15>] [<c01111e0>] [<c011107c>]  
Nov 26 09:45:08 espoo kernel:    [<c01239e6>] [<c0123900>] [<c0121efb>] [<c0120ff2>] [<c0106ec4>]  
Nov 26 09:45:08 espoo kernel: Code: 8b 03 8b 53 04 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46  

>>EIP; c013f5f6 <prune_dcache+1a/14c>   <=====
Trace; c013f97b <shrink_dcache_memory+1b/34>
Trace; c0129885 <shrink_caches+71/88>
Trace; c01298bc <try_to_free_pages+20/40>
Trace; c012a297 <balance_classzone+6b/238>
Trace; c012a563 <__alloc_pages+ff/15c>
Trace; c012a228 <_alloc_pages+18/1c>
Trace; c0120b48 <do_anonymous_page+30/94>
Trace; c0120bdf <do_no_page+33/10c>
Trace; c0120d15 <handle_mm_fault+5d/c4>
Trace; c01111e0 <do_page_fault+164/4c4>
Trace; c011107c <do_page_fault+0/4c4>
Trace; c01239e6 <generic_file_read+7e/194>
Trace; c0123900 <file_read_actor+0/68>
Trace; c0121efb <do_brk+11b/200>
Trace; c0120ff2 <sys_brk+c2/f0>
Trace; c0106ec4 <error_code+34/40>
Code;  c013f5f6 <prune_dcache+1a/14c>
00000000 <_EIP>:
Code;  c013f5f6 <prune_dcache+1a/14c>   <=====
   0:   8b 03                     movl   (%ebx),%eax   <=====
Code;  c013f5f8 <prune_dcache+1c/14c>
   2:   8b 53 04                  movl   0x4(%ebx),%edx
Code;  c013f5fb <prune_dcache+1f/14c>
   5:   89 50 04                  movl   %edx,0x4(%eax)
Code;  c013f5fe <prune_dcache+22/14c>
   8:   89 02                     movl   %eax,(%edx)
Code;  c013f600 <prune_dcache+24/14c>
   a:   89 1b                     movl   %ebx,(%ebx)
Code;  c013f602 <prune_dcache+26/14c>
   c:   89 5b 04                  movl   %ebx,0x4(%ebx)
Code;  c013f605 <prune_dcache+29/14c>
   f:   8d 73 e8                  leal   0xffffffe8(%ebx),%esi
Code;  c013f608 <prune_dcache+2c/14c>
  12:   8b 46 00                  movl   0x0(%esi),%eax

Nov 26 09:47:20 espoo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Nov 26 09:47:20 espoo kernel: c013f902 
Nov 26 09:47:20 espoo kernel: *pde = 00000000 
Nov 26 09:47:20 espoo kernel: Oops: 0000 
Nov 26 09:47:20 espoo kernel: CPU:    0 
Nov 26 09:47:20 espoo kernel: EIP:    0010:[<c013f902>]    Not tainted 
Nov 26 09:47:20 espoo kernel: EFLAGS: 00010246 
Nov 26 09:47:20 espoo kernel: eax: c47e9150   ebx: c0a823f0   ecx: c0a82408   edx: 00000000 
Nov 26 09:47:20 espoo kernel: esi: c0a823a4   edi: c0a8237c   ebp: 00000000   esp: c3671f20 
Nov 26 09:47:20 espoo kernel: ds: 0018   es: 0018   ss: 0018 
Nov 26 09:47:20 espoo kernel: Process umount (pid: 19296, stackpage=c3671000) 
Nov 26 09:47:20 espoo kernel: Stack: c0a8237c c0a8237c c03b4ca0 bffffcec c0a823a4 c0a8237c c013f956 c0a8237c  
Nov 26 09:47:20 espoo kernel:        c24c4800 c013412c c0a8237c c7efd764 c24c4800 c3671f98 bffffcec c03b4d2c  
Nov 26 09:47:20 espoo kernel:        c014290a c24c4800 c7efd764 c0a8237c c3671f98 c0755000 c0137aef c7efd764  
Nov 26 09:47:20 espoo kernel: Call Trace: [<c013f956>] [<c013412c>] [<c014290a>] [<c0137aef>] [<c0143175>]  
Nov 26 09:47:20 espoo kernel:    [<c0143190>] [<c0106db3>]  
Nov 26 09:47:20 espoo kernel: Code: 8b 02 89 48 04 89 43 18 89 51 04 45 89 0a 8d 43 28 39 43 28  

>>EIP; c013f902 <select_parent+3e/7c>   <=====
Trace; c013f956 <shrink_dcache_parent+16/20>
Trace; c013412c <kill_super+5c/13c>
Trace; c014290a <__mntput+1e/24>
Trace; c0137aef <path_release+27/2c>
Trace; c0143175 <sys_umount+a9/b8>
Trace; c0143190 <sys_oldumount+c/10>
Trace; c0106db3 <system_call+33/40>
Code;  c013f902 <select_parent+3e/7c>
00000000 <_EIP>:
Code;  c013f902 <select_parent+3e/7c>   <=====
   0:   8b 02                     movl   (%edx),%eax   <=====
Code;  c013f904 <select_parent+40/7c>
   2:   89 48 04                  movl   %ecx,0x4(%eax)
Code;  c013f907 <select_parent+43/7c>
   5:   89 43 18                  movl   %eax,0x18(%ebx)
Code;  c013f90a <select_parent+46/7c>
   8:   89 51 04                  movl   %edx,0x4(%ecx)
Code;  c013f90d <select_parent+49/7c>
   b:   45                        incl   %ebp
Code;  c013f90e <select_parent+4a/7c>
   c:   89 0a                     movl   %ecx,(%edx)
Code;  c013f910 <select_parent+4c/7c>
   e:   8d 43 28                  leal   0x28(%ebx),%eax
Code;  c013f913 <select_parent+4f/7c>
  11:   39 43 28                  cmpl   %eax,0x28(%ebx)

Nov 26 09:48:20 espoo kernel:  <1>Unable to handle kernel paging request at virtual address 0000ffff 
Nov 26 09:48:20 espoo kernel: c0140f70 
Nov 26 09:48:20 espoo kernel: *pde = 00000000 
Nov 26 09:48:20 espoo kernel: Oops: 0000 
Nov 26 09:48:20 espoo kernel: CPU:    0 
Nov 26 09:48:20 espoo kernel: EIP:    0010:[<c0140f70>]    Not tainted 
Nov 26 09:48:20 espoo kernel: EFLAGS: 00010207 
Nov 26 09:48:20 espoo kernel: eax: c0fadf3c   ebx: 0000ffff   ecx: c24c4000   edx: c0fadf3c 
Nov 26 09:48:20 espoo kernel: esi: c56f443c   edi: 00000000   ebp: 0000ffff   esp: c0fadf0c 
Nov 26 09:48:20 espoo kernel: ds: 0018   es: 0018   ss: 0018 
Nov 26 09:48:20 espoo kernel: Process umount (pid: 19313, stackpage=c0fad000) 
Nov 26 09:48:20 espoo kernel: Stack: c24c4000 c0fadf3c c03b4ca0 c24c4044 00000000 c0140fae c03b0e44 c24c4000  
Nov 26 09:48:20 espoo kernel:        c0fadf3c c24c4000 c4247688 c03b4ca0 c0fadf3c c0fadf3c c013414f c24c4000  
Nov 26 09:48:20 espoo kernel:        c7efd764 c24c4000 c0fadf98 bffffcec c03b4d2c c014290a c24c4000 c7efd764  
Nov 26 09:48:20 espoo kernel: Call Trace: [<c0140fae>] [<c013414f>] [<c014290a>] [<c0137aef>] [<c0143175>]  
Nov 26 09:48:20 espoo kernel:    [<c0143190>] [<c0106db3>]  
Nov 26 09:48:20 espoo kernel: Code: 8b 2b 3b 5c 24 18 75 98 8b 44 24 10 5b 29 3d d0 06 42 c0 5e  

>>EIP; c0140f70 <invalidate_list+84/9c>   <=====
Trace; c0140fae <invalidate_inodes+26/68>
Trace; c013414f <kill_super+7f/13c>
Trace; c014290a <__mntput+1e/24>
Trace; c0137aef <path_release+27/2c>
Trace; c0143175 <sys_umount+a9/b8>
Trace; c0143190 <sys_oldumount+c/10>
Trace; c0106db3 <system_call+33/40>
Code;  c0140f70 <invalidate_list+84/9c>
00000000 <_EIP>:
Code;  c0140f70 <invalidate_list+84/9c>   <=====
   0:   8b 2b                     movl   (%ebx),%ebp   <=====
Code;  c0140f72 <invalidate_list+86/9c>
   2:   3b 5c 24 18               cmpl   0x18(%esp,1),%ebx
Code;  c0140f76 <invalidate_list+8a/9c>
   6:   75 98                     jne    ffffffa0 <_EIP+0xffffffa0> c0140f10 <invalidate_list+24/9c>
Code;  c0140f78 <invalidate_list+8c/9c>
   8:   8b 44 24 10               movl   0x10(%esp,1),%eax
Code;  c0140f7c <invalidate_list+90/9c>
   c:   5b                        popl   %ebx
Code;  c0140f7d <invalidate_list+91/9c>
   d:   29 3d d0 06 42 c0         subl   %edi,0xc04206d0
Code;  c0140f83 <invalidate_list+97/9c>
  13:   5e                        popl   %esi

etc.

-- 
Frank
