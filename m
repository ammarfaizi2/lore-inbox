Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSHLCus>; Sun, 11 Aug 2002 22:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318623AbSHLCus>; Sun, 11 Aug 2002 22:50:48 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:37879 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318622AbSHLCur>;
	Sun, 11 Aug 2002 22:50:47 -0400
Date: Sun, 11 Aug 2002 22:54:31 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020812025431.GA4429@www.kroptech.com>
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D56A83E.ECF747C6@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, just got this while un-tarring a kernel tree with 2.5.31+everything.gz:
(no nvidia ;)

--Adam

ksymoops 2.4.1 on i686 2.5.31-akpm.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.31-akpm/ (default)
     -m /boot/System.map-2.5.31-akpm (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol GPLONLY___wake_up_sync not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_balance_dirty_pages not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_generic_file_direct_IO not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0132503>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c89d5840   ebx: c10c7000   ecx: 00000000   edx: 00000000
esi: c51f5e70   edi: 00000005   ebp: 00000010   esp: c51f5e14
ds: 0018   es: 0018   ss: 0018
Stack: 00009000 c1000018 c1123238 c1028018 c0313c60 00000206 ffffffff 00001a66 
       00000000 00000008 c51f5e70 00000005 00000010 c0132f7a c10caa48 00000009 
       c0130e1b c51f5e6c 00000000 c89d5e20 c2f88dd0 00000000 00000009 c10570e8 
Call Trace: [<c0132f7a>] [<c0130e1b>] [<c0129f01>] [<c0114791>] [<c0165c04>] 
   [<c0116569>] [<c011b3f9>] [<c0111370>] [<c0107183>] 
Code: 0f 0b 62 00 85 b6 2c c0 8b 03 ba 04 00 00 00 83 e0 10 74 1d 

>>EIP; c0132503 <__free_pages_ok+93/300>   <=====
Trace; c0132f7a <__pagevec_free+1a/20>
Trace; c0130e1b <__pagevec_release+fb/110>
Trace; c0129f01 <exit_mmap+1a1/280>
Trace; c0114791 <default_wake_function+21/40>
Trace; c0165c04 <ext3_release_file+14/20>
Trace; c0116569 <mmput+49/70>
Trace; c011b3f9 <do_exit+d9/2c0>
Trace; c0111370 <smp_apic_timer_interrupt+e0/120>
Trace; c0107183 <syscall_call+7/b>
Code;  c0132503 <__free_pages_ok+93/300>
00000000 <_EIP>:
Code;  c0132503 <__free_pages_ok+93/300>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132505 <__free_pages_ok+95/300>
   2:   62 00                     bound  %eax,(%eax)
Code;  c0132507 <__free_pages_ok+97/300>
   4:   85 b6 2c c0 8b 03         test   %esi,0x38bc02c(%esi)
Code;  c013250d <__free_pages_ok+9d/300>
   a:   ba 04 00 00 00            mov    $0x4,%edx
Code;  c0132512 <__free_pages_ok+a2/300>
   f:   83 e0 10                  and    $0x10,%eax
Code;  c0132515 <__free_pages_ok+a5/300>
  12:   74 1d                     je     31 <_EIP+0x31> c0132534 <__free_pages_ok+c4/300>


7 warnings issued.  Results may not be reliable.

