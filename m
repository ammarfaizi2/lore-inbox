Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbTL3Vlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbTL3Vlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:41:55 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:20933 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265365AbTL3Vlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:41:45 -0500
Subject: Re: Oops with 2.4.23 in kswapd
From: Stian Jordet <liste@jordet.nu>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031230171812.GR1882@matchmail.com>
References: <1072781694.530.9.camel@buick>
	 <20031230171812.GR1882@matchmail.com>
Content-Type: multipart/mixed; boundary="=-F9MrvEPRkGc22ZEmKMl6"
Message-Id: <1072820484.2085.0.camel@buick>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 22:41:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F9MrvEPRkGc22ZEmKMl6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tir, 30.12.2003 kl. 18.18 skrev Mike Fedyk:
> On Tue, Dec 30, 2003 at 11:54:55AM +0100, Stian Jordet wrote:
> > Oops run through ksymoops attached. Had a similar oops with 2.4.22,
> > never any problems with .18, .19 or .20. Never tried .21.
> 
> These are useless until you run them through ksymoops...

Wow. Thanks. I'm just too silly. I attached the wrong file. Very sorry
about that.

Here it is.

Best regards,
Stian

--=-F9MrvEPRkGc22ZEmKMl6
Content-Disposition: attachment; filename=calltrace.txt
Content-Type: text/plain; name=calltrace.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.5 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2.4.23 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000018
c0132f30
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132f30>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 00000000   ebx: c1047e20   ecx: 000001d0   edx: 00000000
esi: 00000000   edi: c17e3440   ebp: c1047e20   esp: cb73bf30
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=cb73b000)
Stack: c1047e20 000001d0 00000001 0000003e c01313ec c17e3440 c1047e20 c0129ae2 
       c1047e20 000001d0 00000004 000001d0 c029d85c c029d85c cb73a000 0000153e 
       000001d0 c029d85c c0129de3 cb73bfa8 0000003b 000001d0 00000004 c0129e50 
Call Trace:    [<c01313ec>] [<c0129ae2>] [<c0129de3>] [<c0129e50>] [<c0129fde>]
  [<c012a046>] [<c012a15d>] [<c0105568>]
Code: 8b 56 18 8b 46 10 83 e2 06 09 d0 75 78 8b 76 28 39 fe 75 ec 


>>EIP; c0132f30 <try_to_free_buffers+14/ec>   <=====

>>ebx; c1047e20 <_end+d19da4/bd23f84>
>>edi; c17e3440 <_end+14b53c4/bd23f84>
>>ebp; c1047e20 <_end+d19da4/bd23f84>
>>esp; cb73bf30 <_end+b40deb4/bd23f84>

Trace; c01313ec <try_to_release_page+44/48>
Trace; c0129ae2 <shrink_cache+1f6/370>
Trace; c0129de3 <shrink_caches+2f/3c>
Trace; c0129e50 <try_to_free_pages_zone+60/ec>
Trace; c0129fde <kswapd_balance_pgdat+4a/98>
Trace; c012a046 <kswapd_balance+1a/30>
Trace; c012a15d <kswapd+99/bc>
Trace; c0105568 <arch_kernel_thread+28/38>

Code;  c0132f30 <try_to_free_buffers+14/ec>
00000000 <_EIP>:
Code;  c0132f30 <try_to_free_buffers+14/ec>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  c0132f33 <try_to_free_buffers+17/ec>
   3:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c0132f36 <try_to_free_buffers+1a/ec>
   6:   83 e2 06                  and    $0x6,%edx
Code;  c0132f39 <try_to_free_buffers+1d/ec>
   9:   09 d0                     or     %edx,%eax
Code;  c0132f3b <try_to_free_buffers+1f/ec>
   b:   75 78                     jne    85 <_EIP+0x85> c0132fb5 <try_to_free_buffers+99/ec>
Code;  c0132f3d <try_to_free_buffers+21/ec>
   d:   8b 76 28                  mov    0x28(%esi),%esi
Code;  c0132f40 <try_to_free_buffers+24/ec>
  10:   39 fe                     cmp    %edi,%esi
Code;  c0132f42 <try_to_free_buffers+26/ec>
  12:   75 ec                     jne    0 <_EIP>

 <1>Unable to handle kernel paging request at virtual address 6465708c
c01313cb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01313cb>]    Not tainted
EFLAGS: 00010286
eax: 64657070   ebx: c1047110   ecx: 000001d2   edx: 00000001
esi: 000001d2   edi: 00000015   ebp: 00000c80   esp: c6e95cf0
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 5586, stackpage=c6e95000)
Stack: c06612a0 c1047110 c0129ae2 c1047110 000001d2 00000020 000001d2 c029d85c 
       c029d85c c6e94000 00001b44 000001d2 c029d85c c0129de3 c6e95d54 0000003c 
       000001d2 00000020 c0129e50 c6e95d54 c6e94000 00000000 00000010 00000000 
Call Trace:    [<c0129ae2>] [<c0129de3>] [<c0129e50>] [<c012a8a5>] [<c012aba6>]
  [<c0129302>] [<c012a866>] [<c012114c>] [<c012121f>] [<c01213ca>] [<c0111754>]
  [<c01115f4>] [<c01de800>] [<c01e237e>] [<c01ddfae>] [<c01bc8ef>] [<c01c2f11>]
  [<c0106ce4>] [<c01241ce>] [<c0123ca3>] [<c012428b>] [<c0124174>] [<c012f586>]
  [<c0106bf3>]
Code: 83 78 1c 00 74 12 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 04 


>>EIP; c01313cb <try_to_release_page+23/48>   <=====

>>eax; 64657070 Before first symbol
>>ebx; c1047110 <_end+d19094/bd23f84>
>>ebp; 00000c80 Before first symbol
>>esp; c6e95cf0 <_end+6b67c74/bd23f84>

Trace; c0129ae2 <shrink_cache+1f6/370>
Trace; c0129de3 <shrink_caches+2f/3c>
Trace; c0129e50 <try_to_free_pages_zone+60/ec>
Trace; c012a8a5 <balance_classzone+3d/1c0>
Trace; c012aba6 <__alloc_pages+17e/27c>
Trace; c0129302 <lru_cache_add+5a/60>
Trace; c012a866 <_alloc_pages+16/18>
Trace; c012114c <do_anonymous_page+34/d4>
Trace; c012121f <do_no_page+33/18c>
Trace; c01213ca <handle_mm_fault+52/b4>
Trace; c0111754 <do_page_fault+160/480>
Trace; c01115f4 <do_page_fault+0/480>
Trace; c01de800 <__mega_runpendq+24/3c>
Trace; c01e237e <mega_runpendq+12/18>
Trace; c01ddfae <megaraid_queue+62/74>
Trace; c01bc8ef <scsi_dispatch_cmd+117/214>
Trace; c01c2f11 <scsi_request_fn+2fd/334>
Trace; c0106ce4 <error_code+34/3c>
Trace; c01241ce <file_read_actor+5a/84>
Trace; c0123ca3 <do_generic_file_read+1e7/438>
Trace; c012428b <generic_file_read+93/190>
Trace; c0124174 <file_read_actor+0/84>
Trace; c012f586 <sys_read+96/f0>
Trace; c0106bf3 <system_call+33/38>

Code;  c01313cb <try_to_release_page+23/48>
00000000 <_EIP>:
Code;  c01313cb <try_to_release_page+23/48>   <=====
   0:   83 78 1c 00               cmpl   $0x0,0x1c(%eax)   <=====
Code;  c01313cf <try_to_release_page+27/48>
   4:   74 12                     je     18 <_EIP+0x18> c01313e3 <try_to_release_page+3b/48>
Code;  c01313d1 <try_to_release_page+29/48>
   6:   56                        push   %esi
Code;  c01313d2 <try_to_release_page+2a/48>
   7:   53                        push   %ebx
Code;  c01313d3 <try_to_release_page+2b/48>
   8:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  c01313d6 <try_to_release_page+2e/48>
   b:   ff d0                     call   *%eax
Code;  c01313d8 <try_to_release_page+30/48>
   d:   83 c4 08                  add    $0x8,%esp
Code;  c01313db <try_to_release_page+33/48>
  10:   85 c0                     test   %eax,%eax
Code;  c01313dd <try_to_release_page+35/48>
  12:   75 04                     jne    18 <_EIP+0x18> c01313e3 <try_to_release_page+3b/48>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000021
c0132e86
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132e86>]    Not tainted
EFLAGS: 00010203
eax: 00000000   ebx: 00000009   ecx: 000001d2   edx: 00000012
esi: 00000000   edi: c17e38c0   ebp: c1047a00   esp: c86cbdb4
ds: 0018   es: 0018   ss: 0018
Process pisg (pid: 6201, stackpage=c86cb000)
Stack: c1047a00 c17e38c0 c17e38c0 c0132fdc c17e38c0 c1047a00 000001d2 0000001c 
       00000c7d c01313ec c17e38c0 c1047a00 c0129ae2 c1047a00 000001d2 00000020 
       000001d2 c029d85c c029d85c c86ca000 00001b4a 000001d2 c029d85c c0129de3 
Call Trace:    [<c0132fdc>] [<c01313ec>] [<c0129ae2>] [<c0129de3>] [<c0129e50>]
  [<c012a8a5>] [<c012aba6>] [<c0129302>] [<c012a866>] [<c012114c>] [<c012121f>]
  [<c01213ca>] [<c0111754>] [<c01115f4>] [<c0123ee6>] [<c011b517>] [<c0122656>]
  [<c01216fb>] [<c0106ce4>]
Code: f6 43 18 06 74 7c b8 07 00 00 00 0f ab 43 18 19 c0 85 c0 74 


>>EIP; c0132e86 <sync_page_buffers+e/a4>   <=====

>>edi; c17e38c0 <_end+14b5844/bd23f84>
>>ebp; c1047a00 <_end+d19984/bd23f84>
>>esp; c86cbdb4 <_end+839dd38/bd23f84>

Trace; c0132fdc <try_to_free_buffers+c0/ec>
Trace; c01313ec <try_to_release_page+44/48>
Trace; c0129ae2 <shrink_cache+1f6/370>
Trace; c0129de3 <shrink_caches+2f/3c>
Trace; c0129e50 <try_to_free_pages_zone+60/ec>
Trace; c012a8a5 <balance_classzone+3d/1c0>
Trace; c012aba6 <__alloc_pages+17e/27c>
Trace; c0129302 <lru_cache_add+5a/60>
Trace; c012a866 <_alloc_pages+16/18>
Trace; c012114c <do_anonymous_page+34/d4>
Trace; c012121f <do_no_page+33/18c>
Trace; c01213ca <handle_mm_fault+52/b4>
Trace; c0111754 <do_page_fault+160/480>
Trace; c01115f4 <do_page_fault+0/480>
Trace; c0123ee6 <do_generic_file_read+42a/438>
Trace; c011b517 <update_wall_time+b/34>
Trace; c0122656 <do_brk+13a/21c>
Trace; c01216fb <sys_brk+bb/e4>
Trace; c0106ce4 <error_code+34/3c>

Code;  c0132e86 <sync_page_buffers+e/a4>
00000000 <_EIP>:
Code;  c0132e86 <sync_page_buffers+e/a4>   <=====
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
Code;  c0132e8a <sync_page_buffers+12/a4>
   4:   74 7c                     je     82 <_EIP+0x82> c0132f08 <sync_page_buffers+90/a4>
Code;  c0132e8c <sync_page_buffers+14/a4>
   6:   b8 07 00 00 00            mov    $0x7,%eax
Code;  c0132e91 <sync_page_buffers+19/a4>
   b:   0f ab 43 18               bts    %eax,0x18(%ebx)
Code;  c0132e95 <sync_page_buffers+1d/a4>
   f:   19 c0                     sbb    %eax,%eax
Code;  c0132e97 <sync_page_buffers+1f/a4>
  11:   85 c0                     test   %eax,%eax
Code;  c0132e99 <sync_page_buffers+21/a4>
  13:   74 00                     je     15 <_EIP+0x15> c0132e9b <sync_page_buffers+23/a4>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000028
c015e3a2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015e3a2>]    Not tainted
EFLAGS: 00010203
eax: 0100004d   ebx: 00000000   ecx: 000001d2   edx: 00000000
esi: c02d7480   edi: 00000001   ebp: 00000050   esp: c17b5df4
ds: 0018   es: 0018   ss: 0018
Process imapd (pid: 7852, stackpage=c17b5000)
Stack: c10474d8 000001d2 00000007 00000c80 00000000 c015684e cb4ab000 c10474d8 
       000001d2 c01313d8 c10474d8 000001d2 c02d7480 c10474d8 c0129ae2 c10474d8 
       000001d2 00000020 000001d2 c029d85c c029d85c c17b4000 000014fc 000001d2 
Call Trace:    [<c015684e>] [<c01313d8>] [<c0129ae2>] [<c0129de3>] [<c0129e50>]
  [<c012a8a5>] [<c012aba6>] [<c0155cfc>] [<c012a866>] [<c01233ea>] [<c0123a55>]
  [<c0123c72>] [<c012428b>] [<c0124174>] [<c012f586>] [<c0106bf3>]
Code: 8b 5b 28 f6 42 19 04 74 17 8d 44 24 10 50 52 e8 0a ff ff ff 


>>EIP; c015e3a2 <journal_try_to_free_buffers+5a/98>   <=====

>>eax; 0100004d Before first symbol
>>esi; c02d7480 <__devicestr_10390645+20/40>
>>esp; c17b5df4 <_end+1487d78/bd23f84>

Trace; c015684e <ext3_releasepage+22/28>
Trace; c01313d8 <try_to_release_page+30/48>
Trace; c0129ae2 <shrink_cache+1f6/370>
Trace; c0129de3 <shrink_caches+2f/3c>
Trace; c0129e50 <try_to_free_pages_zone+60/ec>
Trace; c012a8a5 <balance_classzone+3d/1c0>
Trace; c012aba6 <__alloc_pages+17e/27c>
Trace; c0155cfc <ext3_get_block+0/64>
Trace; c012a866 <_alloc_pages+16/18>
Trace; c01233ea <page_cache_read+72/c0>
Trace; c0123a55 <generic_file_readahead+105/13c>
Trace; c0123c72 <do_generic_file_read+1b6/438>
Trace; c012428b <generic_file_read+93/190>
Trace; c0124174 <file_read_actor+0/84>
Trace; c012f586 <sys_read+96/f0>
Trace; c0106bf3 <system_call+33/38>

Code;  c015e3a2 <journal_try_to_free_buffers+5a/98>
00000000 <_EIP>:
Code;  c015e3a2 <journal_try_to_free_buffers+5a/98>   <=====
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
Code;  c015e3a5 <journal_try_to_free_buffers+5d/98>
   3:   f6 42 19 04               testb  $0x4,0x19(%edx)
Code;  c015e3a9 <journal_try_to_free_buffers+61/98>
   7:   74 17                     je     20 <_EIP+0x20> c015e3c2 <journal_try_to_free_buffers+7a/98>
Code;  c015e3ab <journal_try_to_free_buffers+63/98>
   9:   8d 44 24 10               lea    0x10(%esp,1),%eax
Code;  c015e3af <journal_try_to_free_buffers+67/98>
   d:   50                        push   %eax
Code;  c015e3b0 <journal_try_to_free_buffers+68/98>
   e:   52                        push   %edx
Code;  c015e3b1 <journal_try_to_free_buffers+69/98>
   f:   e8 0a ff ff ff            call   ffffff1e <_EIP+0xffffff1e> c015e2c0 <__journal_try_to_free_buffer+0/88>


1 warning issued.  Results may not be reliable.

--=-F9MrvEPRkGc22ZEmKMl6--

