Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUCKR6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUCKR6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:58:18 -0500
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:23449 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261518AbUCKR6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:58:15 -0500
Date: Thu, 11 Mar 2004 12:56:00 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 boot 
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403111244510.1855@onpx40.onqynaqf.bet>
References: <20040310233140.3ce99610.akpm@osdl.org>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IBM Thinkpad T30, current bios

On a clean boot (not resume - I've not gotten that working):
resuming from /dev/hda8
Resuming from device hda8
bad: scheduling while atomic!
Call Trace:   (abbreviated - doing this by hand on nearby PC)
	schedule+0x5d5
	mempool_alloc+0x64
	generic_unplug_device+0x55
	blk_run_queues+0x79
	io_schedule+0x3
	__wait_on_buffer+0xca
	autoremove_wake_function+0x0
	autoremove_wake_function+0x0  (no, not a typo)
	__bread_slow+0x43
	__bread+0x1b
	bdev_read_page+0x24
	read_suspend_image+0x131
	printk+0x127
	release_console_sem+0xd7
	software_resume+0x7a
	do_initcalls+0x2b
	idedisk_init+0x0
	init+0x0
	init+0x38
	kernel_thread_helper+0x5

Resume Machine: This is normal swap space
-------------- [ cut here ] ------------------
kernel BUG at kernel/printk.c:568!
invalid operand: 0000 [#1]
PREEMPT
CPU:	0
EIP:	0060:[<c0122d14>]       Not tainted VLI
EFLAGS: 00010206    (2.6.4-mm1)
EIP is at acquire_console_sem+0x14/0x60
eax: dff4f00   ebx: c03f3b88   ecx: c13fb760   edx: c0350578
esi: 0000001   edi: 00000000   ebp: dff4ffa4   esp: dff4ffa0
ds:  007b   es: 007b  ss: 0068
Process swapper (pid: 1, threadinfo=dff4f000 task=c141d680)
...
Call Trace:
	pm_restore_console+0x12
	software_resume+0x83
	do_initcalls+0x2b
	idedisk_init+0x0
	init+0x0
	init+0x38
	kernel_thread_helper+0x5

Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing



-- 
Rick Nelson
After watching my newly-retired dad spend two weeks learning how to make a new
folder, it became obvious that "intuitive" mostly means "what the writer or
speaker of intuitive likes".
	-- Bruce Ediger, bediger@teal.csn.org, on X the intuitiveness of a Mac interface
