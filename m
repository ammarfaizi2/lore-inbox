Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTHJSoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270626AbTHJSoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:44:20 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5828 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270625AbTHJSoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:44:16 -0400
Date: Sun, 10 Aug 2003 12:44:13 -0600
From: "S.Coffin" <scoffin@comcast.net>
Message-Id: <200308101844.h7AIiDhN001691@yawn.gv.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Repeatable hard crash with 2.6.0.test[123]
Cc: akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please apply this patch, see if you can capture a decent trace.

Thanks, the patch makes things a lot more rational :-)

Attached is the ksymoops output from my "java-exit" panic.  Let me
know if there is anything more I can do to help solve this one

                            =S.Coffin
                            GV Computing
                            scoffin@comcast.net

ps= why the warning from ksymoops?  Is there some mismatch between the
kallsyms file format and the ksymoops expected format?  I no longer have
a "ksyms" file in /proc....

===========================================================================

ksymoops 2.4.9 on i686 2.6.0-test3.  Options used
     -V (default)
     -k kallsyms (specified)
     -l modules (specified)
     -o /lib/modules/2.6.0-test3/ (default)
     -m /usr/src/linux/System.map (default)

Warning (read_ksyms): no kernel symbols in ksyms, is kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Aug 10 12:32:09 yawn kernel: Unable to handle kernel paging request at virtual address 6b6b6b77
Aug 10 12:32:09 yawn kernel: Unable to handle kernel paging request at virtual address 6b6b6b77
Aug 10 12:32:09 yawn kernel: c011acda
Aug 10 12:32:09 yawn kernel: c011acda
Aug 10 12:32:09 yawn kernel: *pde = 00000000
Aug 10 12:32:09 yawn kernel: *pde = 00000000
Aug 10 12:32:09 yawn kernel: Oops: 0000 [#1]
Aug 10 12:32:09 yawn kernel: Oops: 0000 [#1]
Aug 10 12:32:09 yawn kernel: CPU:    0
Aug 10 12:32:09 yawn kernel: CPU:    0
Aug 10 12:32:09 yawn kernel: EIP:    0060:[<c011acda>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 10 12:32:09 yawn kernel: EIP:    0060:[<c011acda>]    Not tainted
Aug 10 12:32:09 yawn kernel: EFLAGS: 00010006
Aug 10 12:32:09 yawn kernel: EFLAGS: 00010006
Aug 10 12:32:09 yawn kernel: eax: 6b6b6b6b   ebx: cca21980   ecx: d49c4680   edx: dff7f8dc
Aug 10 12:32:09 yawn kernel: eax: 6b6b6b6b   ebx: cca21980   ecx: d49c4680   edx: dff7f8dc
Aug 10 12:32:09 yawn kernel: esi: 00000000   edi: cca21980   ebp: 00008100   esp: cd21fea8
Aug 10 12:32:09 yawn kernel: esi: 00000000   edi: cca21980   ebp: 00008100   esp: cd21fea8
Aug 10 12:32:09 yawn kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 12:32:09 yawn kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 12:32:09 yawn kernel: Stack: cca21980 cd21e000 dfd06de4 00000000 c011bf22 cca21980 dfd06de4 cca21f24 
Aug 10 12:32:09 yawn kernel: Stack: cca21980 cd21e000 dfd06de4 00000000 c011bf22 cca21980 dfd06de4 cca21f24 
Aug 10 12:32:09 yawn kernel:        cca21980 00008100 cd21e000 cd21ff24 cd21e000 c011c064 00008100 cd21e000 
Aug 10 12:32:09 yawn kernel:        cca21980 00008100 cd21e000 cd21ff24 cd21e000 c011c064 00008100 cd21e000 
Aug 10 12:32:09 yawn kernel:        00000009 c0124280 00000009 cca21f24 cd21ff24 cca21f24 cd21ffc4 cca21f24 
Aug 10 12:32:09 yawn kernel:        00000009 c0124280 00000009 cca21f24 cd21ff24 cca21f24 cd21ffc4 cca21f24 
Aug 10 12:32:09 yawn kernel: Call Trace:
Aug 10 12:32:09 yawn kernel: Call Trace:
Aug 10 12:32:09 yawn kernel:  [<c011bf22>] do_exit+0x262/0x2e0
Aug 10 12:32:09 yawn kernel:  [<c011bf22>] do_exit+0x262/0x2e0
Aug 10 12:32:09 yawn kernel:  [<c011c064>] do_group_exit+0x54/0x80
Aug 10 12:32:09 yawn kernel:  [<c011c064>] do_group_exit+0x54/0x80
Aug 10 12:32:09 yawn kernel:  [<c0124280>] get_signal_to_deliver+0x1b0/0x2b0
Aug 10 12:32:09 yawn kernel:  [<c0124280>] get_signal_to_deliver+0x1b0/0x2b0
Aug 10 12:32:09 yawn kernel:  [<c0108dca>] do_signal+0xda/0x110
Aug 10 12:32:09 yawn kernel:  [<c0108dca>] do_signal+0xda/0x110
Aug 10 12:32:09 yawn kernel:  [<c01171c0>] default_wake_function+0x0/0x30
Aug 10 12:32:09 yawn kernel:  [<c01171c0>] default_wake_function+0x0/0x30
Aug 10 12:32:09 yawn kernel:  [<c01171c0>] default_wake_function+0x0/0x30
Aug 10 12:32:09 yawn kernel:  [<c0118237>] free_task+0x27/0x30
Aug 10 12:32:09 yawn kernel:  [<c01171c0>] default_wake_function+0x0/0x30
Aug 10 12:32:09 yawn kernel:  [<c0118237>] free_task+0x27/0x30
Aug 10 12:32:09 yawn kernel:  [<c012be1c>] sys_futex+0xfc/0x130
Aug 10 12:32:09 yawn kernel:  [<c012be1c>] sys_futex+0xfc/0x130
Aug 10 12:32:09 yawn kernel:  [<c0108e56>] do_notify_resume+0x56/0x58
Aug 10 12:32:09 yawn kernel:  [<c0108e56>] do_notify_resume+0x56/0x58
Aug 10 12:32:09 yawn kernel:  [<c0108ff6>] work_notifysig+0x13/0x15
Aug 10 12:32:09 yawn kernel:  [<c0108ff6>] work_notifysig+0x13/0x15
Aug 10 12:32:09 yawn kernel: Code: 8b 50 0c 83 c0 0c 39 02 75 0b 8b 01 83 f8 08 0f 84 96 00 00 


>>EIP; c011acda <release_task+7a/170>   <=====
>>EIP; c011acda <release_task+7a/170>   <=====

>>ebx; cca21980 <_end+c71be30/3fcf84b0>
>>ecx; d49c4680 <_end+146beb30/3fcf84b0>
>>edx; dff7f8dc <_end+1fc79d8c/3fcf84b0>
>>ebx; cca21980 <_end+c71be30/3fcf84b0>
>>ecx; d49c4680 <_end+146beb30/3fcf84b0>
>>edx; dff7f8dc <_end+1fc79d8c/3fcf84b0>
>>edi; cca21980 <_end+c71be30/3fcf84b0>
>>esp; cd21fea8 <_end+cf1a358/3fcf84b0>
>>edi; cca21980 <_end+c71be30/3fcf84b0>
>>esp; cd21fea8 <_end+cf1a358/3fcf84b0>

Trace; c011bf22 <do_exit+262/2e0>
Trace; c011bf22 <do_exit+262/2e0>
Trace; c011c064 <do_group_exit+54/80>
Trace; c011c064 <do_group_exit+54/80>
Trace; c0124280 <get_signal_to_deliver+1b0/2b0>
Trace; c0124280 <get_signal_to_deliver+1b0/2b0>
Trace; c0108dca <do_signal+da/110>
Trace; c0108dca <do_signal+da/110>
Trace; c01171c0 <default_wake_function+0/30>
Trace; c01171c0 <default_wake_function+0/30>
Trace; c01171c0 <default_wake_function+0/30>
Trace; c0118237 <free_task+27/30>
Trace; c01171c0 <default_wake_function+0/30>
Trace; c0118237 <free_task+27/30>
Trace; c012be1c <sys_futex+fc/130>
Trace; c012be1c <sys_futex+fc/130>
Trace; c0108e56 <do_notify_resume+56/58>
Trace; c0108e56 <do_notify_resume+56/58>
Trace; c0108ff6 <work_notifysig+13/15>
Trace; c0108ff6 <work_notifysig+13/15>

Code;  c011acda <release_task+7a/170>
00000000 <_EIP>:
Code;  c011acda <release_task+7a/170>   <=====
   0:   8b 50 0c                  mov    0xc(%eax),%edx   <=====
Code;  c011acdd <release_task+7d/170>
   3:   83 c0 0c                  add    $0xc,%eax
Code;  c011ace0 <release_task+80/170>
   6:   39 02                     cmp    %eax,(%edx)
Code;  c011ace2 <release_task+82/170>
   8:   75 0b                     jne    15 <_EIP+0x15>
Code;  c011ace4 <release_task+84/170>
   a:   8b 01                     mov    (%ecx),%eax
Code;  c011ace6 <release_task+86/170>
   c:   83 f8 08                  cmp    $0x8,%eax
Code;  c011ace9 <release_task+89/170>
   f:   0f 84 96 00 00 00         je     ab <_EIP+0xab>

Aug 10 12:32:09 yawn kernel: Code: 8b 50 0c 83 c0 0c 39 02 75 0b 8b 01 83 f8 08 0f 84 96 00 00 


Code;  c011acda <release_task+7a/170>
00000000 <_EIP>:
Code;  c011acda <release_task+7a/170>
   0:   8b 50 0c                  mov    0xc(%eax),%edx
Code;  c011acdd <release_task+7d/170>
   3:   83 c0 0c                  add    $0xc,%eax
Code;  c011ace0 <release_task+80/170>
   6:   39 02                     cmp    %eax,(%edx)
Code;  c011ace2 <release_task+82/170>
   8:   75 0b                     jne    15 <_EIP+0x15>
Code;  c011ace4 <release_task+84/170>
   a:   8b 01                     mov    (%ecx),%eax
Code;  c011ace6 <release_task+86/170>
   c:   83 f8 08                  cmp    $0x8,%eax
Code;  c011ace9 <release_task+89/170>
   f:   0f 84 96 00 00 00         je     ab <_EIP+0xab>


1 warning issued.  Results may not be reliable.
===========================================================================

