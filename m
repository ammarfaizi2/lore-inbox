Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUAHQAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUAHQAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:00:51 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:42477
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S265155AbUAHP7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:59:48 -0500
Message-ID: <3FFD82B7.9040600@reactivated.net>
Date: Thu, 08 Jan 2004 16:17:59 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <nbensa@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.1-rc2-mm1
References: <200401081200.06009.nbensa@gmx.net>
In-Reply-To: <200401081200.06009.nbensa@gmx.net>
Content-Type: multipart/mixed;
 boundary="------------040900020400070706030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900020400070706030507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Similar problems here. Incase it helps any further, dmesg and ksymoops output 
attached.

I checked with metalog, and the oops's occured right as I came back to my PC 
after a couple of hours of inactivity - when it was unblanking the screen (I 
was on a vt at the time).

Daniel

Norberto Bensa wrote:
> All right, this is one of my two or three "BSOD" since I use Linux :-)
> Not sure if I did ksymoops right. I hope this is useful
> 
> 

--------------040900020400070706030507
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

------------[ cut here ]------------
kernel BUG at mm/rmap.c:305!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c014d4a4>]    Tainted: PF  VLI
EFLAGS: 00010246
EIP is at try_to_unmap_one+0x1c4/0x1e0
eax: 00000000   ebx: 00000000   ecx: de030000   edx: c1000000
esi: c149a570   edi: c149a570   ebp: de030000   esp: dfdb5d48
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=dfdb4000 task=dfdb9340)
Stack: c0139afa c0327404 00000001 c149a570 00000000 00000000 c149a570 ffffffff 
       dfdb4000 c014d5f6 c0327400 00000001 00000000 00000001 00000000 c149a570 
       00000001 dfdb4000 c0144b48 c149a570 000000d0 dff7df70 c011ebfc 00000005 
Call Trace:
 [<c0139afa>] add_to_page_cache+0x6a/0xf0
 [<c014d5f6>] try_to_unmap+0x136/0x160
 [<c0144b48>] shrink_list+0x238/0x580
 [<c011ebfc>] schedule+0x34c/0x5b0
 [<c014503a>] shrink_cache+0x1aa/0x360
 [<c01457c1>] shrink_zone+0x81/0xb0
 [<c0145b94>] balance_pgdat+0x174/0x200
 [<c0145d37>] kswapd+0x117/0x130
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c02db666>] ret_from_fork+0x6/0x14
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c0145c20>] kswapd+0x0/0x130
 [<c010b289>] kernel_thread_helper+0x5/0xc

Code: e8 1b c1 e3 08 01 c0 09 d8 89 45 00 31 c0 85 c0 0f 84 3c ff ff ff 0f 0b 57 01 40 e6 2e c0 e9 2f ff ff ff 0f 01 3b e9 c5 fe ff ff <0f> 0b 31 01 40 e6 2e c0 e9 6c fe ff ff eb 0d 90 90 90 90 90 90 
Badness in unblank_screen at drivers/char/vt.c:2793
Call Trace:
 [<c010dac0>] do_invalid_op+0x0/0xd0
 [<c0229e56>] unblank_screen+0x126/0x130
 [<c011ca2c>] bust_spinlocks+0x2c/0x60
 [<c010d775>] die+0x95/0x100
 [<c010db89>] do_invalid_op+0xc9/0xd0
 [<c014d4a4>] try_to_unmap_one+0x1c4/0x1e0
 [<c011dd5e>] recalc_task_prio+0x8e/0x1b0
 [<c011df27>] try_to_wake_up+0xa7/0x160
 [<c011ef01>] __wake_up_common+0x31/0x60
 [<c02dc18f>] error_code+0x2f/0x38
 [<c014d4a4>] try_to_unmap_one+0x1c4/0x1e0
 [<c0139afa>] add_to_page_cache+0x6a/0xf0
 [<c014d5f6>] try_to_unmap+0x136/0x160
 [<c0144b48>] shrink_list+0x238/0x580
 [<c011ebfc>] schedule+0x34c/0x5b0
 [<c014503a>] shrink_cache+0x1aa/0x360
 [<c01457c1>] shrink_zone+0x81/0xb0
 [<c0145b94>] balance_pgdat+0x174/0x200
 [<c0145d37>] kswapd+0x117/0x130
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c02db666>] ret_from_fork+0x6/0x14
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c0145c20>] kswapd+0x0/0x130
 [<c010b289>] kernel_thread_helper+0x5/0xc

 <6>note: kswapd0[7] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 1877d029
 printing eip:
c0168c30
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
CPU:    0
EIP:    0060:[<c0168c30>]    Tainted: PF  VLI
EFLAGS: 00010202
EIP is at poll_freewait+0x10/0x50
eax: 00000000   ebx: d86ef008   ecx: c13d1558   edx: c13e0ab0
esi: d86ef008   edi: 1877d025   ebp: 00000005   esp: dcbfbee0
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 9507, threadinfo=dcbfa000 task=df535980)
Stack: 00000000 00000000 00000005 c0168fd7 dcbfbf40 00000000 00000000 00000000 
       00000000 00000304 00000010 00000000 00000000 00000010 dcbfa000 db19ca8c 
       db19ca88 db19ca84 db19ca98 db19ca94 db19ca90 00000000 00000000 00000000 
Call Trace:
 [<c0168fd7>] do_select+0x1b7/0x2d0
 [<c0168c70>] __pollwait+0x0/0xd0
 [<c01693ef>] sys_select+0x2cf/0x4f0
 [<c0157839>] __fput+0x79/0xc0
 [<c0155f11>] sys_close+0x61/0xa0
 [<c02db783>] syscall_call+0x7/0xb

Code: 00 70 8c 16 c0 c7 40 08 00 00 00 00 c7 40 04 00 00 00 00 c3 8d b4 26 00 00 00 00 57 56 53 8b 44 24 10 8b 78 04 85 ff 74 30 89 f6 <8b> 5f 04 8d 77 08 83 eb 1c 8b 43 18 8d 53 04 e8 4c 78 fb ff 8b 
Badness in unblank_screen at drivers/char/vt.c:2793
Call Trace:
 [<c0229e56>] unblank_screen+0x126/0x130
 [<c011ca2c>] bust_spinlocks+0x2c/0x60
 [<c010d775>] die+0x95/0x100
 [<c011ce9e>] do_page_fault+0x1de/0x50c
 [<c011dd5e>] recalc_task_prio+0x8e/0x1b0
 [<c011ebfc>] schedule+0x34c/0x5b0
 [<c011ccc0>] do_page_fault+0x0/0x50c
 [<c02dc18f>] error_code+0x2f/0x38
 [<c0168c30>] poll_freewait+0x10/0x50
 [<c0168fd7>] do_select+0x1b7/0x2d0
 [<c0168c70>] __pollwait+0x0/0xd0
 [<c01693ef>] sys_select+0x2cf/0x4f0
 [<c0157839>] __fput+0x79/0xc0
 [<c0155f11>] sys_close+0x61/0xa0
 [<c02db783>] syscall_call+0x7/0xb

 

--------------040900020400070706030507
Content-Type: text/plain;
 name="ksymoops.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.out"

ksymoops 2.4.9 on i686 2.6.1-rc2-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.1-rc2-mm1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
WARNING: USB Mass Storage data integrity not assured
WARNING: USB Mass Storage data integrity not assured
WARNING: USB Mass Storage data integrity not assured
WARNING: USB Mass Storage data integrity not assured
kernel BUG at mm/rmap.c:305!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014d4a4>]    Tainted: PF  VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: de030000   edx: c1000000
esi: c149a570   edi: c149a570   ebp: de030000   esp: dfdb5d48
ds: 007b   es: 007b   ss: 0068
Stack: c0139afa c0327404 00000001 c149a570 00000000 00000000 c149a570 ffffffff 
       dfdb4000 c014d5f6 c0327400 00000001 00000000 00000001 00000000 c149a570 
       00000001 dfdb4000 c0144b48 c149a570 000000d0 dff7df70 c011ebfc 00000005 
Call Trace:
 [<c0139afa>] add_to_page_cache+0x6a/0xf0
 [<c014d5f6>] try_to_unmap+0x136/0x160
 [<c0144b48>] shrink_list+0x238/0x580
 [<c011ebfc>] schedule+0x34c/0x5b0
 [<c014503a>] shrink_cache+0x1aa/0x360
 [<c01457c1>] shrink_zone+0x81/0xb0
 [<c0145b94>] balance_pgdat+0x174/0x200
 [<c0145d37>] kswapd+0x117/0x130
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c02db666>] ret_from_fork+0x6/0x14
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c0145c20>] kswapd+0x0/0x130
 [<c010b289>] kernel_thread_helper+0x5/0xc
Code: e8 1b c1 e3 08 01 c0 09 d8 89 45 00 31 c0 85 c0 0f 84 3c ff ff ff 0f 0b 57 01 40 e6 2e c0 e9 2f ff ff ff 0f 01 3b e9 c5 fe ff ff <0f> 0b 31 01 40 e6 2e c0 e9 6c fe ff ff eb 0d 90 90 90 90 90 90 


>>EIP; c014d4a4 <try_to_unmap_one+1c4/1e0>   <=====

>>ecx; de030000 <_end+1dc50ee8/3fc1dee8>
>>edx; c1000000 <_end+c20ee8/3fc1dee8>
>>esi; c149a570 <_end+10bb458/3fc1dee8>
>>edi; c149a570 <_end+10bb458/3fc1dee8>
>>ebp; de030000 <_end+1dc50ee8/3fc1dee8>
>>esp; dfdb5d48 <_end+1f9d6c30/3fc1dee8>

Trace; c0139afa <add_to_page_cache+6a/f0>
Trace; c014d5f6 <try_to_unmap+136/160>
Trace; c0144b48 <shrink_list+238/580>
Trace; c011ebfc <schedule+34c/5b0>
Trace; c014503a <shrink_cache+1aa/360>
Trace; c01457c1 <shrink_zone+81/b0>
Trace; c0145b94 <balance_pgdat+174/200>
Trace; c0145d37 <kswapd+117/130>
Trace; c01206a0 <autoremove_wake_function+0/50>
Trace; c02db666 <ret_from_fork+6/14>
Trace; c01206a0 <autoremove_wake_function+0/50>
Trace; c0145c20 <kswapd+0/130>
Trace; c010b289 <kernel_thread_helper+5/c>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c014d479 <try_to_unmap_one+199/1e0>
00000000 <_EIP>:
Code;  c014d479 <try_to_unmap_one+199/1e0>
   0:   e8 1b c1 e3 08            call   8e3c120 <_EIP+0x8e3c120>
Code;  c014d47e <try_to_unmap_one+19e/1e0>
   5:   01 c0                     add    %eax,%eax
Code;  c014d480 <try_to_unmap_one+1a0/1e0>
   7:   09 d8                     or     %ebx,%eax
Code;  c014d482 <try_to_unmap_one+1a2/1e0>
   9:   89 45 00                  mov    %eax,0x0(%ebp)
Code;  c014d485 <try_to_unmap_one+1a5/1e0>
   c:   31 c0                     xor    %eax,%eax
Code;  c014d487 <try_to_unmap_one+1a7/1e0>
   e:   85 c0                     test   %eax,%eax
Code;  c014d489 <try_to_unmap_one+1a9/1e0>
  10:   0f 84 3c ff ff ff         je     ffffff52 <_EIP+0xffffff52>
Code;  c014d48f <try_to_unmap_one+1af/1e0>
  16:   0f 0b                     ud2a   
Code;  c014d491 <try_to_unmap_one+1b1/1e0>
  18:   57                        push   %edi
Code;  c014d492 <try_to_unmap_one+1b2/1e0>
  19:   01 40 e6                  add    %eax,0xffffffe6(%eax)
Code;  c014d495 <try_to_unmap_one+1b5/1e0>
  1c:   2e                        cs
Code;  c014d496 <try_to_unmap_one+1b6/1e0>
  1d:   c0 e9 2f                  shr    $0x2f,%cl
Code;  c014d499 <try_to_unmap_one+1b9/1e0>
  20:   ff                        (bad)  
Code;  c014d49a <try_to_unmap_one+1ba/1e0>
  21:   ff                        (bad)  
Code;  c014d49b <try_to_unmap_one+1bb/1e0>
  22:   ff 0f                     decl   (%edi)
Code;  c014d49d <try_to_unmap_one+1bd/1e0>
  24:   01 3b                     add    %edi,(%ebx)
Code;  c014d49f <try_to_unmap_one+1bf/1e0>
  26:   e9 c5 fe ff ff            jmp    fffffef0 <_EIP+0xfffffef0>

This decode from eip onwards should be reliable

Code;  c014d4a4 <try_to_unmap_one+1c4/1e0>
00000000 <_EIP>:
Code;  c014d4a4 <try_to_unmap_one+1c4/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014d4a6 <try_to_unmap_one+1c6/1e0>
   2:   31 01                     xor    %eax,(%ecx)
Code;  c014d4a8 <try_to_unmap_one+1c8/1e0>
   4:   40                        inc    %eax
Code;  c014d4a9 <try_to_unmap_one+1c9/1e0>
   5:   e6 2e                     out    %al,$0x2e
Code;  c014d4ab <try_to_unmap_one+1cb/1e0>
   7:   c0 e9 6c                  shr    $0x6c,%cl
Code;  c014d4ae <try_to_unmap_one+1ce/1e0>
   a:   fe                        (bad)  
Code;  c014d4af <try_to_unmap_one+1cf/1e0>
   b:   ff                        (bad)  
Code;  c014d4b0 <try_to_unmap_one+1d0/1e0>
   c:   ff eb                     ljmp   *%ebx
Code;  c014d4b2 <try_to_unmap_one+1d2/1e0>
   e:   0d 90 90 90 90            or     $0x90909090,%eax
Code;  c014d4b7 <try_to_unmap_one+1d7/1e0>
  13:   90                        nop    
Code;  c014d4b8 <try_to_unmap_one+1d8/1e0>
  14:   90                        nop    

Call Trace:
 [<c010dac0>] do_invalid_op+0x0/0xd0
 [<c0229e56>] unblank_screen+0x126/0x130
 [<c011ca2c>] bust_spinlocks+0x2c/0x60
 [<c010d775>] die+0x95/0x100
 [<c010db89>] do_invalid_op+0xc9/0xd0
 [<c014d4a4>] try_to_unmap_one+0x1c4/0x1e0
 [<c011dd5e>] recalc_task_prio+0x8e/0x1b0
 [<c011df27>] try_to_wake_up+0xa7/0x160
 [<c011ef01>] __wake_up_common+0x31/0x60
 [<c02dc18f>] error_code+0x2f/0x38
 [<c014d4a4>] try_to_unmap_one+0x1c4/0x1e0
 [<c0139afa>] add_to_page_cache+0x6a/0xf0
 [<c014d5f6>] try_to_unmap+0x136/0x160
 [<c0144b48>] shrink_list+0x238/0x580
 [<c011ebfc>] schedule+0x34c/0x5b0
 [<c014503a>] shrink_cache+0x1aa/0x360
 [<c01457c1>] shrink_zone+0x81/0xb0
 [<c0145b94>] balance_pgdat+0x174/0x200
 [<c0145d37>] kswapd+0x117/0x130
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c02db666>] ret_from_fork+0x6/0x14
 [<c01206a0>] autoremove_wake_function+0x0/0x50
 [<c0145c20>] kswapd+0x0/0x130
 [<c010b289>] kernel_thread_helper+0x5/0xc
Unable to handle kernel paging request at virtual address 1877d029
c0168c30
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0168c30>]    Tainted: PF  VLI
EFLAGS: 00010202
eax: 00000000   ebx: d86ef008   ecx: c13d1558   edx: c13e0ab0
esi: d86ef008   edi: 1877d025   ebp: 00000005   esp: dcbfbee0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000000 00000005 c0168fd7 dcbfbf40 00000000 00000000 00000000 
       00000000 00000304 00000010 00000000 00000000 00000010 dcbfa000 db19ca8c 
       db19ca88 db19ca84 db19ca98 db19ca94 db19ca90 00000000 00000000 00000000 
Call Trace:
 [<c0168fd7>] do_select+0x1b7/0x2d0
 [<c0168c70>] __pollwait+0x0/0xd0
 [<c01693ef>] sys_select+0x2cf/0x4f0
 [<c0157839>] __fput+0x79/0xc0
 [<c0155f11>] sys_close+0x61/0xa0
 [<c02db783>] syscall_call+0x7/0xb
Code: 00 70 8c 16 c0 c7 40 08 00 00 00 00 c7 40 04 00 00 00 00 c3 8d b4 26 00 00 00 00 57 56 53 8b 44 24 10 8b 78 04 85 ff 74 30 89 f6 <8b> 5f 04 8d 77 08 83 eb 1c 8b 43 18 8d 53 04 e8 4c 78 fb ff 8b 


Trace; c010dac0 <do_invalid_op+0/d0>
Trace; c0229e56 <unblank_screen+126/130>
Trace; c011ca2c <bust_spinlocks+2c/60>
Trace; c010d775 <die+95/100>
Trace; c010db89 <do_invalid_op+c9/d0>
Trace; c014d4a4 <try_to_unmap_one+1c4/1e0>
Trace; c011dd5e <recalc_task_prio+8e/1b0>
Trace; c011df27 <try_to_wake_up+a7/160>
Trace; c011ef01 <__wake_up_common+31/60>
Trace; c02dc18f <error_code+2f/38>
Trace; c014d4a4 <try_to_unmap_one+1c4/1e0>
Trace; c0139afa <add_to_page_cache+6a/f0>
Trace; c014d5f6 <try_to_unmap+136/160>
Trace; c0144b48 <shrink_list+238/580>
Trace; c011ebfc <schedule+34c/5b0>
Trace; c014503a <shrink_cache+1aa/360>
Trace; c01457c1 <shrink_zone+81/b0>
Trace; c0145b94 <balance_pgdat+174/200>
Trace; c0145d37 <kswapd+117/130>
Trace; c01206a0 <autoremove_wake_function+0/50>
Trace; c02db666 <ret_from_fork+6/14>
Trace; c01206a0 <autoremove_wake_function+0/50>
Trace; c0145c20 <kswapd+0/130>
Trace; c010b289 <kernel_thread_helper+5/c>

>>EIP; c0168c30 <poll_freewait+10/50>   <=====

>>ebx; d86ef008 <_end+1830fef0/3fc1dee8>
>>ecx; c13d1558 <_end+ff2440/3fc1dee8>
>>edx; c13e0ab0 <_end+1001998/3fc1dee8>
>>esi; d86ef008 <_end+1830fef0/3fc1dee8>
>>esp; dcbfbee0 <_end+1c81cdc8/3fc1dee8>

Trace; c0168fd7 <do_select+1b7/2d0>
Trace; c0168c70 <__pollwait+0/d0>
Trace; c01693ef <sys_select+2cf/4f0>
Trace; c0157839 <__fput+79/c0>
Trace; c0155f11 <sys_close+61/a0>
Trace; c02db783 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0168c05 <poll_initwait+5/20>
00000000 <_EIP>:
Code;  c0168c05 <poll_initwait+5/20>
   0:   00 70 8c                  add    %dh,0xffffff8c(%eax)
Code;  c0168c08 <poll_initwait+8/20>
   3:   16                        push   %ss
Code;  c0168c09 <poll_initwait+9/20>
   4:   c0 c7 40                  rol    $0x40,%bh
Code;  c0168c0c <poll_initwait+c/20>
   7:   08 00                     or     %al,(%eax)
Code;  c0168c0e <poll_initwait+e/20>
   9:   00 00                     add    %al,(%eax)
Code;  c0168c10 <poll_initwait+10/20>
   b:   00 c7                     add    %al,%bh
Code;  c0168c12 <poll_initwait+12/20>
   d:   40                        inc    %eax
Code;  c0168c13 <poll_initwait+13/20>
   e:   04 00                     add    $0x0,%al
Code;  c0168c15 <poll_initwait+15/20>
  10:   00 00                     add    %al,(%eax)
Code;  c0168c17 <poll_initwait+17/20>
  12:   00 c3                     add    %al,%bl
Code;  c0168c19 <poll_initwait+19/20>
  14:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0168c20 <poll_freewait+0/50>
  1b:   57                        push   %edi
Code;  c0168c21 <poll_freewait+1/50>
  1c:   56                        push   %esi
Code;  c0168c22 <poll_freewait+2/50>
  1d:   53                        push   %ebx
Code;  c0168c23 <poll_freewait+3/50>
  1e:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c0168c27 <poll_freewait+7/50>
  22:   8b 78 04                  mov    0x4(%eax),%edi
Code;  c0168c2a <poll_freewait+a/50>
  25:   85 ff                     test   %edi,%edi
Code;  c0168c2c <poll_freewait+c/50>
  27:   74 30                     je     59 <_EIP+0x59>
Code;  c0168c2e <poll_freewait+e/50>
  29:   89 f6                     mov    %esi,%esi

This decode from eip onwards should be reliable

Code;  c0168c30 <poll_freewait+10/50>
00000000 <_EIP>:
Code;  c0168c30 <poll_freewait+10/50>   <=====
   0:   8b 5f 04                  mov    0x4(%edi),%ebx   <=====
Code;  c0168c33 <poll_freewait+13/50>
   3:   8d 77 08                  lea    0x8(%edi),%esi
Code;  c0168c36 <poll_freewait+16/50>
   6:   83 eb 1c                  sub    $0x1c,%ebx
Code;  c0168c39 <poll_freewait+19/50>
   9:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c0168c3c <poll_freewait+1c/50>
   c:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c0168c3f <poll_freewait+1f/50>
   f:   e8 4c 78 fb ff            call   fffb7860 <_EIP+0xfffb7860>
Code;  c0168c44 <poll_freewait+24/50>
  14:   8b                        .byte 0x8b

Call Trace:
 [<c0229e56>] unblank_screen+0x126/0x130
 [<c011ca2c>] bust_spinlocks+0x2c/0x60
 [<c010d775>] die+0x95/0x100
 [<c011ce9e>] do_page_fault+0x1de/0x50c
 [<c011dd5e>] recalc_task_prio+0x8e/0x1b0
 [<c011ebfc>] schedule+0x34c/0x5b0
 [<c011ccc0>] do_page_fault+0x0/0x50c
 [<c02dc18f>] error_code+0x2f/0x38
 [<c0168c30>] poll_freewait+0x10/0x50
 [<c0168fd7>] do_select+0x1b7/0x2d0
 [<c0168c70>] __pollwait+0x0/0xd0
 [<c01693ef>] sys_select+0x2cf/0x4f0
 [<c0157839>] __fput+0x79/0xc0
 [<c0155f11>] sys_close+0x61/0xa0
 [<c02db783>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0229e56 <unblank_screen+126/130>
Trace; c011ca2c <bust_spinlocks+2c/60>
Trace; c010d775 <die+95/100>
Trace; c011ce9e <do_page_fault+1de/50c>
Trace; c011dd5e <recalc_task_prio+8e/1b0>
Trace; c011ebfc <schedule+34c/5b0>
Trace; c011ccc0 <do_page_fault+0/50c>
Trace; c02dc18f <error_code+2f/38>
Trace; c0168c30 <poll_freewait+10/50>
Trace; c0168fd7 <do_select+1b7/2d0>
Trace; c0168c70 <__pollwait+0/d0>
Trace; c01693ef <sys_select+2cf/4f0>
Trace; c0157839 <__fput+79/c0>
Trace; c0155f11 <sys_close+61/a0>
Trace; c02db783 <syscall_call+7/b>


2 warnings and 1 error issued.  Results may not be reliable.

--------------040900020400070706030507--
