Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbTLVLlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTLVLlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:41:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264796AbTLVLk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:40:57 -0500
Date: Mon, 22 Dec 2003 11:40:55 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: Oops in prune_dcache
Message-ID: <20031222114055.GA891@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0 (i686)
X-Uptime: 11:35:14 up 7 min,  1 user,  load average: 0.04, 0.28, 0.17
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine had been running 2.6.0 fine for a couple of days, and it
did this overnight - I think a few seconds after cron.daily started.
The machine is a Dual Athlon/MP on a Tyan S2460 motherboard; running
with IDE discs. Details and configs to anyone interested.
The machine still ping'd, but I couldn't ssh in, and the screensaver had
hung.


Dec 22 06:25:08 gallifrey kernel:  printing eip:
Dec 22 06:25:08 gallifrey kernel: c01762f9
Dec 22 06:25:08 gallifrey kernel: Oops: 0002 [#1]
Dec 22 06:25:08 gallifrey kernel: CPU:    1
Dec 22 06:25:08 gallifrey kernel: EIP:    0060:[<c01762f9>]    Not tainted
Dec 22 06:25:08 gallifrey kernel: EFLAGS: 00010206
Dec 22 06:25:08 gallifrey kernel: EIP is at prune_dcache+0x49/0x270
Dec 22 06:25:08 gallifrey kernel: eax: c0431030   ebx: c480e990   ecx: 00000000   edx: ff46ff45
Dec 22 06:25:08 gallifrey kernel: esi: dfde8000   edi: cc7be180   ebp: dfde9e80   esp: dfde9e64
Dec 22 06:25:08 gallifrey kernel: ds: 007b   es: 007b   ss: 0068
Dec 22 06:25:08 gallifrey kernel: Process kswapd0 (pid: 14, threadinfo=dfde8000 task=dfe220c0)
Dec 22 06:25:08 gallifrey kernel: Stack: df68d540 0000001a dfde8000 00000035 00000080 dfde8000 00000003 dfde9e90 
Dec 22 06:25:08 gallifrey kernel:        c0176abc 00000080 00000080 dfde9ec4 c0148b2f 00000080 000000d0 0001bd88 
Dec 22 06:25:08 gallifrey kernel:        00e4c948 00000000 00000083 00000000 dffee560 000001f6 c042f700 00000001 
Dec 22 06:25:08 gallifrey kernel: Call Trace:
Dec 22 06:25:08 gallifrey kernel:  [<c0176abc>] shrink_dcache_memory+0x3c/0x40
Dec 22 06:25:08 gallifrey kernel:  [<c0148b2f>] shrink_slab+0x10f/0x160
Dec 22 06:25:08 gallifrey kernel:  [<c014a1a4>] balance_pgdat+0x1f4/0x220
Dec 22 06:25:08 gallifrey kernel:  [<c014a2ab>] kswapd+0xdb/0xf0
Dec 22 06:25:08 gallifrey kernel:  [<c01209b0>] autoremove_wake_function+0x0/0x50
Dec 22 06:25:08 gallifrey kernel:  [<c0109526>] ret_from_fork+0x6/0x14
Dec 22 06:25:08 gallifrey kernel:  [<c01209b0>] autoremove_wake_function+0x0/0x50
Dec 22 06:25:08 gallifrey kernel:  [<c014a1d0>] kswapd+0x0/0xf0
Dec 22 06:25:08 gallifrey kernel:  [<c010738d>] kernel_thread_helper+0x5/0x18
Dec 22 06:25:08 gallifrey kernel: 
Dec 22 06:25:08 gallifrey kernel: Code: 89 02 89 5b 04 89 1b a1 34 10 43 c0 0f 18 00 90 ff 0d 3c 10 
Dec 22 06:25:08 gallifrey kernel:  <6>note: kswapd0[14] exited with preempt_count 1
Dec 22 06:51:26 gallifrey -- MARK --

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
