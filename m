Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUDOX7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDOX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:59:48 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32655 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261396AbUDOX7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:59:44 -0400
Date: Fri, 16 Apr 2004 08:59:25 +0900
From: Masao Fukuchi <fukuchi.masao@jp.fujitsu.com>
Subject: bugcheck! message at shutdown
To: linux-kernel@vger.kernel.org
Cc: alex.williamson@hp.com
Message-id: <200404152359.AA03183@fukuchi.jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got bugcheck! message when I shutdown my Tiger4.
I noticed this error after I updated the kernel to 2.6.5.
Alex posted same kind of mail before.
http://marc.theaimsgroup.com/?l=linux-kernel&m=108127270905214&w=2

So, I sent him mail.
But he doesn't know the proper fix(he just removed __init
from the declaration of get_boot_pages to get rid of bugcheck!).

If you have any information, please let me know.

Thanks,
Masao Fukuchi

//
ksymoops 2.4.8 on ia64 2.6.5.  Options used
     -v vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5/ (default)
     -m System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Pid: 2748, CPU 0, comm:                 halt
psr : 0000101008026018 ifs : 8000000000000002 ip  : [<a000000100641c80>]    Tain
ted: GF
Using defaults from ksymoops -t elf64-ia64-little -a ia64-elf64
b0  : a0000001002375a0 b6  : a000000100236000 b7  : a000000100237520
f6  : 1003e000000000000000f f7  : 0ffdee000000000000000
f8  : 10002f000000000000000 f9  : 1003e0000000000000001
f10 : 0fffedffffffff2000000 f11 : 1003e0000000000000000
r1  : a0000001008c0000 r2  : 0000000000000309 r3  : a000000100784f20
r8  : a000000100773c08 r9  : a000000100784f20 r10 : 0000000000000001
r11 : 0000000000000300 r12 : e000000002377c80 r13 : e000000002370000
r14 : a000000100788460 r15 : e000000002370ea4 r16 : a0000001006dd398
r17 : 0000000000000000 r18 : ffffffffffff00e8 r19 : a0000001006a8100
r20 : 0000000000000003 r21 : a0000001006dd378 r22 : a0000001006dd370
r23 : e0000000010072d8 r24 : a0000001007d7a00 r25 : e0000000010072e0
r26 : 0000000000000001 r27 : 0000000000000001 r28 : a000000100099a30
r29 : a000000100785a70 r30 : a000000100788420 r31 : 0000000000000004
Call Trace:
 [<a000000100019760>] show_stack+0x80/0xa0
 [<a00000010003fca0>] die+0x1e0/0x2a0
 [<a00000010003fff0>] ia64_bad_break+0x230/0x340
 [<a000000100011ea0>] ia64_leave_kernel+0x0/0x260
 [<a000000100641c80>] get_boot_pages+0x0/0x300
 [<a0000001002375a0>] swiotlb_alloc_coherent+0x80/0x180
 [<a0000002000c0330>] mptscsih_synchronize_cache+0x690/0x760 [mptscsih]
 [<a0000001002375a0>] swiotlb_alloc_coherent+0x80/0x180
Warning (Oops_read): Code line not seen, dumping what data is available

>>IP;  a000000100641c80 <get_boot_pages+0/300>   <=====

>>b0;  a0000001002375a0 <swiotlb_alloc_coherent+80/180>
>>b6;  a000000100236000 <__copy_user+5e0/920>
>>b7;  a000000100237520 <swiotlb_alloc_coherent+0/180>
>>r1; a0000001008c0000 <__gp+0/3ffffffeff740000>
>>r3; a000000100784f20 <system_running+0/8>
>>r8; a000000100773c08 <kallsyms_names+222e8/31ab0>
>>r9; a000000100784f20 <system_running+0/8>
>>r12; e000000002377c80 <v+2377c80/1fffffffffff0000>
>>r13; e000000002370000 <v+2370000/1fffffffffff0000>
>>r14; a000000100788460 <ia64_mv+40/160>
>>r15; e000000002370ea4 <v+2370ea4/1fffffffffff0000>
>>r16; a0000001006dd398 <console_sem+0/20>
>>r18; ffffffffffff00e8 <per_cpu__cpu_info+c0/c8>
>>r19; a0000001006a8100 <cpu_to_node_map+0/80>
>>r21; a0000001006dd378 <log_wait+8/18>
>>r22; a0000001006dd370 <log_wait+0/18>
>>r23; e0000000010072d8 <v+10072d8/1fffffffffff0000>
>>r24; a0000001007d7a00 <console_timer+8/40>
>>r25; e0000000010072e0 <v+10072e0/1fffffffffff0000>
>>r28; a000000100099a30 <release_console_sem+50/220>
>>r29; a000000100785a70 <blank_state+0/4>
>>r30; a000000100788420 <ia64_mv+0/160>

Trace; a000000100019760 <show_stack+80/a0>
Trace; a00000010003fca0 <die+1e0/2a0>
Trace; a00000010003fff0 <ia64_bad_break+230/340>
Trace; a000000100011ea0 <ia64_leave_kernel+0/260>
Trace; a000000100641c80 <get_boot_pages+0/300>
Trace; a0000001002375a0 <swiotlb_alloc_coherent+80/180>
Trace; a0000002000c0330 <__gp+ff800330/3ffffffeff740000>
Trace; a0000001002375a0 <swiotlb_alloc_coherent+80/180>

Alex Williamson wrote:
Hi Masao,

   You can remove the __init from the declaration of get_boot_pages, but
I'm not sure that's the proper fix.  It gets rid of the bugcheck for me
though.  Please post to linux-kernel as well, perhaps it will get
someone's attention who knows how to fix it properly.  I'd assume we
really only want to call get_boot_pages on bootup, and the
system_running flag is being used improperly.  Thanks,

	Alex
