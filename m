Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWELBDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWELBDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 21:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWELBDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 21:03:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:20277 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750711AbWELBDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 21:03:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UD+pFUSsPeRW/jOlCgYglbEwsMKbqxhiUxApwMijX0Ie8R9swJlcLvw34pEywvY8S1uOADk/2CMu+/M4GgR62L9Y5/NQY3KZPfvz9M5X3Xvy+IcyCjsexAtzaxMOxM5KPHm3wswliOo39hqQWMphsQyH0VBXPsPW65wjSnGTreM=
Message-ID: <dd5c6820605111803j737b58d2m5c7d8f94494db571@mail.gmail.com>
Date: Thu, 11 May 2006 18:03:45 -0700
From: "Dhananjay Bhandari" <dhananjay.bhandari@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SUSE 9 kernel dump an error midway of application run, making application to hang
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to run one of my applications, kernel dumps following error
in /var/log/messages, and my process hangs.
The error is as follows :
Apr 12 19:19:00 suse kernel: ------------[ cut here ]------------
Apr 12 19:19:00 suse kernel: kernel BUG at mm/memory.c:334!
Apr 12 19:19:00 suse kernel: invalid operand: 0000 [#6]
Apr 12 19:19:00 suse kernel: CPU:    0
Apr 12 19:19:00 suse kernel: EIP:    0060:[<c0149eca>]    Not tainted
Apr 12 19:19:00 suse kernel: EFLAGS: 00213202   (2.6.5-7.97-default)
Apr 12 19:19:00 suse kernel: EIP is at copy_page_range+0x34a/0x354
Apr 12 19:19:00 suse kernel: eax: 00000001   ebx: 19da5065   ecx:
dcb57980   edx: 19da5045
Apr 12 19:19:00 suse kernel: esi: d21bb000   edi: c133b4a0   ebp:
cb642000   esp: d221dee8
Apr 12 19:19:00 suse kernel: ds: 007b   es: 007b   ss: 0068
Apr 12 19:19:00 suse kernel: Process nativeScan-linu (pid: 29414,
threadinfo=d221c000 task=cd4bb460)
Apr 12 19:19:00 suse kernel: Stack: cb484000 cf2fe000 00000001
00001000 00000000 d1c22a84 dcb57980 d1c22a84
Apr 12 19:19:00 suse kernel:        00000001 d1c22a9c d1c22154
c011eb48 d08dd9b0 de14b320 00000001 d1c22a9c
Apr 12 19:19:00 suse kernel:        d1c22aa4 d1c22a90 de14b300
dcb57980 d08dda50 d08dd9b0 d221dfc4 bfffeacc
Apr 12 19:19:00 suse kernel: Call Trace:
Apr 12 19:19:00 suse kernel:  [<c011eb48>] copy_process+0xb98/0xff0
Apr 12 19:19:00 suse kernel:  [<c011f00a>] do_fork+0x6a/0x220
Apr 12 19:19:00 suse kernel:  [<c01066b9>] sys_clone+0x29/0x30
Apr 12 19:19:00 suse kernel:  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Apr 12 19:19:00 suse kernel:
Apr 12 19:19:00 suse kernel: Code: 0f 0b 4e 01 d5 3c 30 c0 eb d7 e8 f7
ce fb ff e9 03 e8 ff ff
Apr 12 19:19:00 suse kernel:  <6>note: nativeScan-linu[29414] exited
with preempt_count 2
Apr 12 19:19:00 suse kernel: bad: scheduling while atomic!
Apr 12 19:19:00 suse kernel: Call Trace:
Apr 12 19:19:00 suse kernel:  [<c011cf17>] schedule+0x697/0x6d0
Apr 12 19:19:00 suse kernel:  [<c011b311>] __wake_up_common+0x31/0x60
Apr 12 19:19:00 suse kernel:  [<c01d7bcd>] rwsem_down_read_failed+0x6d/0x160
Apr 12 19:19:00 suse kernel:  [<c011fe7d>] printk+0x11d/0x130
Apr 12 19:19:00 suse kernel:  [<c01220ed>] .text.lock.exit+0x6b/0xce
Apr 12 19:19:00 suse kernel:  [<c0108d48>] common_interrupt+0x18/0x20
Apr 12 19:19:00 suse kernel:  [<c01099e8>] die+0x158/0x160
Apr 12 19:19:00 suse kernel:  [<c0109d20>] do_invalid_op+0x0/0xb0
Apr 12 19:19:00 suse kernel:  [<c0109dbf>] do_invalid_op+0x9f/0xb0
Apr 12 19:19:00 suse kernel:  [<c0149eca>] copy_page_range+0x34a/0x354
Apr 12 19:19:00 suse kernel:  [<c0118dfe>] pgd_alloc+0xe/0x40
Apr 12 19:19:00 suse kernel:  [<c013fbc1>] __alloc_pages+0x321/0x360
Apr 12 19:19:00 suse kernel:  [<c0108e0d>] error_code+0x2d/0x40
Apr 12 19:19:00 suse kernel:  [<c0149eca>] copy_page_range+0x34a/0x354
Apr 12 19:19:00 suse kernel:  [<c011eb48>] copy_process+0xb98/0xff0
Apr 12 19:19:00 suse kernel:  [<c011f00a>] do_fork+0x6a/0x220
Apr 12 19:19:00 suse kernel:  [<c01066b9>] sys_clone+0x29/0x30
Apr 12 19:19:00 suse kernel:  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Apr 12 19:19:00 suse kernel:

I am not sure what fomr the application is triggering it, and how can
I get around it.
The kernel version is : 2.6.5-7.97, and platform is X86.

I am in real desperate situation, hence any help would be greatly appreciated.
