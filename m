Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUG1LU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUG1LU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUG1LU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:20:27 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:1486 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S266820AbUG1LUX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:20:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.8-rc2 crashes
Date: Wed, 28 Jul 2004 07:20:21 -0400
User-Agent: KMail/1.6.82
References: <200407271233.04205.gene.heskett@verizon.net> <200407271315.22075.gene.heskett@verizon.net> <20040727192615.GG12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040727192615.GG12308@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200407280720.21518.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.76.84] at Wed, 28 Jul 2004 06:20:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just had another crash/lockup, running 2.6.8-rc2-bk3
At the instant, I was looking thru the menu's of the new
kde3.3-beta2, in the window decoration, themes etc menu,
where it got 14% loaded in a 60 megabyte file and it went
away.

>From the log (the whole Oops section this time):
Jul 28 06:48:50 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jul 28 06:48:50 coyote kernel:  printing eip:
Jul 28 06:48:50 coyote kernel: c0164136
Jul 28 06:48:50 coyote kernel: *pde = 3ce74067
Jul 28 06:48:50 coyote kernel: Oops: 0002 [#1]
Jul 28 06:48:50 coyote kernel: PREEMPT
Jul 28 06:48:50 coyote kernel: Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8
x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
Jul 28 06:48:50 coyote kernel: CPU:    0
Jul 28 06:48:50 coyote kernel: EIP:    0060:[<c0164136>]    Not tainted
Jul 28 06:48:50 coyote kernel: EFLAGS: 00010216   (2.6.8-rc2-bk3-nf2)
Jul 28 06:48:50 coyote kernel: EIP is at prune_dcache+0x36/0x1c0
Jul 28 06:48:50 coyote kernel: eax: c0364638   ebx: 00000080   ecx: e85fe134   edx: 00000000
Jul 28 06:48:50 coyote kernel: esi: 00000000   edi: c198b000   ebp: 00000080   esp: c198bef8
Jul 28 06:48:50 coyote kernel: ds: 007b   es: 007b   ss: 0068
Jul 28 06:48:50 coyote kernel: Process kswapd0 (pid: 66, threadinfo=c198b000 task=c1978050)
Jul 28 06:48:50 coyote kernel: Stack: c198bef8 c198bef8 00000080 00000000 c198b000 f7ffea60 c01646df 00000080
Jul 28 06:48:50 coyote kernel:        c013a9ab 00000080 000000d0 0001f03f 021edf00 00000000 00000118 00000000
Jul 28 06:48:51 coyote kernel:        c0363624 00000001 00000007 c0363500 c013bd51 00000020 000000d0 00000000
Jul 28 06:48:51 coyote kernel: Call Trace:
Jul 28 06:48:51 coyote kernel:  [<c01646df>] shrink_dcache_memory+0x1f/0x50
Jul 28 06:48:51 coyote kernel:  [<c013a9ab>] shrink_slab+0x14b/0x190
Jul 28 06:48:51 coyote kernel:  [<c013bd51>] balance_pgdat+0x1b1/0x200
Jul 28 06:48:51 coyote kernel:  [<c013be67>] kswapd+0xc7/0xe0
Jul 28 06:48:51 coyote kernel:  [<c0114570>] autoremove_wake_function+0x0/0x60
Jul 28 06:48:52 coyote kernel:  [<c0103f9e>] ret_from_fork+0x6/0x14
Jul 28 06:48:52 coyote kernel:  [<c0114570>] autoremove_wake_function+0x0/0x60
Jul 28 06:48:52 coyote kernel:  [<c013bda0>] kswapd+0x0/0xe0
Jul 28 06:48:52 coyote kernel:  [<c0102251>] kernel_thread_helper+0x5/0x14
Jul 28 06:48:52 coyote kernel: Code: 89 02 89 49 04 89 09 a1 3c 46 36 c0 0f 18 00 90 ff 0d 44 46
Jul 28 06:48:52 coyote kernel:  <6>note: kswapd0[66] exited with preempt_count 1
Jul 28 06:48:52 coyote kernel:
Jul 28 06:48:52 coyote kernel:  [<c030d2fc>] schedule+0x47c/0x490
Jul 28 06:48:52 coyote kernel:  [<c018797e>] ext3_ordered_writepage+0x10e/0x1c0
Jul 28 06:48:52 coyote kernel:  [<c0139d78>] __pagevec_release+0x28/0x40
Jul 28 06:48:52 coyote kernel:  [<c016ece1>] mpage_writepages+0x1b1/0x350
Jul 28 06:48:52 coyote kernel:  [<c0187870>] ext3_ordered_writepage+0x0/0x1c0
Jul 28 06:48:52 coyote kernel:  [<c0135714>] do_writepages+0x44/0x50
Jul 28 06:48:52 coyote kernel:  [<c016d3b1>] __sync_single_inode+0x71/0x210
Jul 28 06:48:52 coyote kernel:  [<c01860f3>] ext3_put_inode+0x13/0x30
Jul 28 06:48:52 coyote kernel:  [<c016d77e>] sync_sb_inodes+0x16e/0x290
Jul 28 06:48:52 coyote kernel:  [<c016da0e>] sync_inodes_sb+0x7e/0xa0
Jul 28 06:48:52 coyote kernel:  [<c016db3b>] sync_inodes+0x2b/0xa0
Jul 28 06:48:52 coyote kernel:  [<c014e034>] do_sync+0x44/0x80
Jul 28 06:48:52 coyote kernel:  [<c014e07f>] sys_sync+0xf/0x20
Jul 28 06:48:52 coyote kernel:  [<c011653f>] panic+0xff/0x110
Jul 28 06:48:52 coyote kernel:  [<c0118d5f>] do_exit+0x3ff/0x420
Jul 28 06:48:52 coyote kernel:  [<c01114f0>] do_page_fault+0x0/0x519
Jul 28 06:48:52 coyote kernel:  [<c0104968>] die+0xf8/0x100
Jul 28 06:48:52 coyote kernel:  [<c01116cb>] do_page_fault+0x1db/0x519
Jul 28 06:48:52 coyote kernel:  [<c0105dd2>] do_IRQ+0x102/0x1a0
Jul 28 06:48:52 coyote kernel:  [<c030d10e>] schedule+0x28e/0x490
Jul 28 06:48:52 coyote kernel:  [<c01114f0>] do_page_fault+0x0/0x519
Jul 28 06:48:52 coyote kernel:  [<c0104271>] error_code+0x2d/0x38
Jul 28 06:48:52 coyote kernel:  [<c0164596>] select_parent+0x56/0xb0
Jul 28 06:48:52 coyote kernel:  [<c0164600>] shrink_dcache_parent+0x10/0x30
Jul 28 06:48:52 coyote kernel:  [<c017b177>] proc_pid_flush+0x17/0x30
Jul 28 06:48:52 coyote kernel:  [<c011765d>] release_task+0x13d/0x1e0
Jul 28 06:48:52 coyote kernel:  [<c01190fb>] wait_task_zombie+0x15b/0x1c0
Jul 28 06:48:52 coyote kernel:  [<c0119513>] sys_wait4+0x213/0x260
Jul 28 06:48:52 coyote kernel:  [<c01132e0>] default_wake_function+0x0/0x20
Jul 28 06:48:52 coyote kernel:  [<c01132e0>] default_wake_function+0x0/0x20
Jul 28 11:00:39 coyote syslogd 1.4.1: restart.
--------------
Note restart time, but my script worked, the system 
time is now properly set later in the bootup.  Nice.

Ok, so which direction do I go, bk2, or bk4, for the next test?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.23% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
