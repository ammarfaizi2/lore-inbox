Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUBABsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 20:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUBABsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 20:48:33 -0500
Received: from pop.gmx.de ([213.165.64.20]:45775 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264887AbUBABsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 20:48:31 -0500
X-Authenticated: #4512188
Message-ID: <401C5AEC.8060602@gmx.de>
Date: Sun, 01 Feb 2004 02:48:28 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops with 2.6.1-rc1 and rc-3
References: <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net> <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de> <1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de> <1075542685.25454.124.camel@laptop-linux> <401B86EB.50604@gmx.de> <yw1xznc4tfle.fsf@kth.se> <20040131231134.GA6084@digitasaru.net> <20040201002641.GB31914@luna.mooo.com>
In-Reply-To: <20040201002641.GB31914@luna.mooo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened once with rc-1 vanilla and once with rc-3 (haven't used 
rc2 long enough.) Never happened with a earlier kernel. The message 
repeats eternally itself making the system next to unusuable.

Any idea how to fix it?

I am using siimage ide driver.

Prakash

Feb  1 02:34:48 tachyon handlers:
Feb  1 02:34:48 tachyon [<c02a6b50>] (ide_intr+0x0/0x190)
Feb  1 02:34:48 tachyon [<c03248c0>] (snd_intel8x0_interrupt+0x0/0x210)
Feb  1 02:34:48 tachyon Disabling IRQ #11
Feb  1 02:34:48 tachyon irq 11: nobody cared!
Feb  1 02:34:48 tachyon Call Trace:
Feb  1 02:34:48 tachyon [<c010b0aa>] __report_bad_irq+0x2a/0x90
Feb  1 02:34:48 tachyon [<c010b19c>] note_interrupt+0x6c/0xb0
Feb  1 02:34:48 tachyon [<c010b451>] do_IRQ+0x121/0x130
Feb  1 02:34:48 tachyon [<c0109854>] common_interrupt+0x18/0x20
Feb  1 02:34:48 tachyon [<c0124080>] do_softirq+0x40/0xa0
Feb  1 02:34:48 tachyon [<c010b42d>] do_IRQ+0xfd/0x130
Feb  1 02:34:48 tachyon [<c0109854>] common_interrupt+0x18/0x20
Feb  1 02:34:48 tachyon [<c0281056>] generic_unplug_device+0x26/0x80
Feb  1 02:34:48 tachyon [<c028121a>] blk_run_queues+0x7a/0xb0
Feb  1 02:34:48 tachyon [<c016605f>] __wait_on_buffer+0xbf/0xd0
Feb  1 02:34:48 tachyon [<c011e1c0>] autoremove_wake_function+0x0/0x50
Feb  1 02:34:48 tachyon [<c011e1c0>] autoremove_wake_function+0x0/0x50
Feb  1 02:34:48 tachyon [<c020dbb8>] submit_logged_buffer+0x38/0x60
Feb  1 02:34:48 tachyon [<c020e1a3>] kupdate_one_transaction+0x1b3/0x210
Feb  1 02:34:48 tachyon [<c020e275>] reiserfs_journal_kupdate+0x75/0xb0
Feb  1 02:34:48 tachyon [<c0210ed4>] flush_old_commits+0x144/0x1d0
Feb  1 02:34:48 tachyon [<c0122583>] do_exit+0x293/0x500
Feb  1 02:34:48 tachyon [<c01fe942>] reiserfs_write_super+0x82/0x90
Feb  1 02:34:48 tachyon [<c016b94c>] sync_supers+0xac/0xc0
Feb  1 02:34:48 tachyon [<c014b526>] wb_kupdate+0x36/0x120
Feb  1 02:34:48 tachyon [<c02602d3>] tty_write+0x1d3/0x3f0
Feb  1 02:34:48 tachyon [<c026008e>] tty_read+0x18e/0x200
Feb  1 02:34:48 tachyon [<c011c86d>] schedule+0x31d/0x590
Feb  1 02:34:48 tachyon [<c01214c0>] reparent_to_init+0xf0/0x180
Feb  1 02:34:48 tachyon [<c014bb4b>] __pdflush+0xcb/0x1b0
Feb  1 02:34:48 tachyon [<c014bc30>] pdflush+0x0/0x20
Feb  1 02:34:48 tachyon [<c014bc3f>] pdflush+0xf/0x20
Feb  1 02:34:48 tachyon [<c014b4f0>] wb_kupdate+0x0/0x120
Feb  1 02:34:48 tachyon [<c0107284>] kernel_thread_helper+0x0/0xc
Feb  1 02:34:48 tachyon [<c0107289>] kernel_thread_helper+0x5/0xc
Feb  1 02:34:48 tachyon

