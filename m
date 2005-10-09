Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVJIEdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJIEdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 00:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVJIEdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 00:33:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4552 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932213AbVJIEdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 00:33:07 -0400
Date: Sun, 9 Oct 2005 06:33:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt12)
Message-ID: <20051009043341.GA30878@elte.hu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu> <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu> <20051007211654.GA14996@elte.hu> <1128725801.23974.20.camel@cmn3.stanford.edu> <20051007231126.GA17919@elte.hu> <1128824015.5104.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128824015.5104.6.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> This appears to be triggered from Freqtweak (a Jack application):
> Oct  8 18:48:00 cmn3 kernel: freqtweak:4705 userspace BUG: scheduling in
> user-atomic context!
> Oct  8 18:48:00 cmn3 kernel:  [<c037c05b>] schedule+0xeb/0x100 (8)
> Oct  8 18:48:00 cmn3 kernel:  [<c037d745>] rwsem_down_read_failed
> +0xa5/0x1c0 (28)
> Oct  8 18:48:00 cmn3 kernel:  [<c01467ee>] .text.lock.futex+0xa9/0x2db
> (52)
> Oct  8 18:48:00 cmn3 kernel:  [<c0130c46>] try_to_del_timer_sync
> +0x46/0x50 (32)
> Oct  8 18:48:00 cmn3 kernel:  [<c0130c71>] del_timer_sync+0x21/0x30 (16)
> Oct  8 18:48:00 cmn3 kernel:  [<c0121330>] default_wake_function
> +0x0/0x20 (32)
> Oct  8 18:48:00 cmn3 kernel:  [<c0151b5c>] audit_syscall_exit+0x4c/0x400
> (12)
> Oct  8 18:48:00 cmn3 kernel:  [<c0146589>] do_futex+0x69/0xf0 (24)
> Oct  8 18:48:00 cmn3 kernel:  [<c0146674>] sys_futex+0x64/0x120 (24)
> Oct  8 18:48:00 cmn3 kernel:  [<c0103471>] syscall_call+0x7/0xb (60)

could you enable CONFIG_DEBUG_PREEMPT and send me the same assert (which 
will hopefully include a critical section list too).

	Ingo
