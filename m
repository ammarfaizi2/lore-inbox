Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTHGQhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHGQhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:37:39 -0400
Received: from the-penguin.otak.com ([65.37.126.18]:8581 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S270367AbTHGQfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:35:33 -0400
Date: Thu, 7 Aug 2003 09:35:26 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops 2.6.0-test2-mm5 baddness?
Message-ID: <20030807163526.GA1758@the-penguin.otak.com>
Mail-Followup-To: Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test2-mm5 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Got a oops right after boot not sure why, will work on repeating it.
Only thing that makes this box unusual bock wise is it's SCSI.
I was running mm2 before with out a like of problems.
Questions, comments, patches tested, flames even, welcome. 




ksymoops 2.4.8 on i686 2.6.0-test2-mm5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2-mm5/ (default)
     -m /System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace:
 [<c020aaa2>] as_dispatch_request+0x182/0x290
 [<c0219e08>] scsi_request_fn+0x38/0x250
 [<c020abe3>] as_next_request+0x33/0x40
 [<c020b28a>] as_work_handler+0x1a/0x40
 [<c012c233>] worker_thread+0x193/0x250
 [<c020b270>] as_work_handler+0x0/0x40
 [<c011b900>] default_wake_function+0x0/0x30
 [<c028c106>] ret_from_fork+0x6/0x14
 [<c011b900>] default_wake_function+0x0/0x30
 [<c012c0a0>] worker_thread+0x0/0x250
 [<c010aa39>] kernel_thread_helper+0x5/0xc
Call Trace:
 [<c020aaa2>] as_dispatch_request+0x182/0x290
 [<c020abe3>] as_next_request+0x33/0x40
 [<c0203326>] elv_next_request+0x16/0x100
 [<c0204c62>] generic_unplug_device+0x42/0x60
 [<c0204da6>] blk_run_queues+0x66/0x80
 [<c014f5e9>] __wait_on_buffer_wq+0xc9/0xf0
 [<c011cd00>] autoremove_wake_function+0x0/0x50
 [<c015306b>] bio_alloc+0xcb/0x1a0
 [<c011cd00>] autoremove_wake_function+0x0/0x50
 [<c0197168>] journal_commit_transaction+0xb38/0xfd0
 [<c011b92a>] default_wake_function+0x2a/0x30
 [<c011b6fc>] schedule+0x2ec/0x4f0
 [<c0199794>] kjournald+0xb4/0x1e0
 [<c011cd00>] autoremove_wake_function+0x0/0x50
 [<c011cd00>] autoremove_wake_function+0x0/0x50
 [<c028c106>] ret_from_fork+0x6/0x14
 [<c01996c0>] commit_timeout+0x0/0x10
 [<c01996e0>] kjournald+0x0/0x1e0
 [<c010aa39>] kernel_thread_helper+0x5/0xc
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c020aaa2 <as_dispatch_request+182/290>
Trace; c0219e08 <scsi_request_fn+38/250>
Trace; c020abe3 <as_next_request+33/40>
Trace; c020b28a <as_work_handler+1a/40>
Trace; c012c233 <worker_thread+193/250>
Trace; c020b270 <as_work_handler+0/40>
Trace; c011b900 <default_wake_function+0/30>
Trace; c028c106 <ret_from_fork+6/14>
Trace; c011b900 <default_wake_function+0/30>
Trace; c012c0a0 <worker_thread+0/250>
Trace; c010aa39 <kernel_thread_helper+5/c>
Trace; c020aaa2 <as_dispatch_request+182/290>
Trace; c020abe3 <as_next_request+33/40>
Trace; c0203326 <elv_next_request+16/100>
Trace; c0204c62 <generic_unplug_device+42/60>
Trace; c0204da6 <blk_run_queues+66/80>
Trace; c014f5e9 <__wait_on_buffer_wq+c9/f0>
Trace; c011cd00 <autoremove_wake_function+0/50>
Trace; c015306b <bio_alloc+cb/1a0>
Trace; c011cd00 <autoremove_wake_function+0/50>
Trace; c0197168 <journal_commit_transaction+b38/fd0>
Trace; c011b92a <default_wake_function+2a/30>
Trace; c011b6fc <schedule+2ec/4f0>
Trace; c0199794 <kjournald+b4/1e0>
Trace; c011cd00 <autoremove_wake_function+0/50>
Trace; c011cd00 <autoremove_wake_function+0/50>
Trace; c028c106 <ret_from_fork+6/14>
Trace; c01996c0 <commit_timeout+0/10>
Trace; c01996e0 <kjournald+0/1e0>
Trace; c010aa39 <kernel_thread_helper+5/c>


1 warning and 1 error issued.  Results may not be reliable.
-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


