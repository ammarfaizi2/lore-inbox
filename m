Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbUJZLRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbUJZLRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUJZLRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:17:46 -0400
Received: from pop.gmx.net ([213.165.64.20]:26318 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262237AbUJZLOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:14:38 -0400
X-Authenticated: #4399952
Date: Tue, 26 Oct 2004 13:31:26 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Michael Geithe <warpy@gmx.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.10-rc1-bk4 and kernel/futex.c:542
Message-ID: <20041026133126.1b44fb38@mango.fruits.de>
In-Reply-To: <200410261135.51035.warpy@gmx.de>
References: <200410261135.51035.warpy@gmx.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 11:35:50 +0200
Michael Geithe <warpy@gmx.de> wrote:

> hi,
> here are some error messages after reboot in my logs.
> 
> Badness in futex_wait at kernel/futex.c:542

Hey Ingo,

this futex.c:542 looks familiar to me (see the BUG logs for RP-V0.2). Dunno
if it's coincidence though. Just guessing they might be correlated.

> 
> Oct 26 03:01:26 h2so4 kernel: ReiserFS: sda1: found reiserfs format "3.6" with 
> standard journal
> Oct 26 03:01:27 h2so4 kernel: ReiserFS: sda1: using ordered data mode
> Oct 26 03:01:27 h2so4 kernel: ReiserFS: sda1: journal params: device sda1, 
> size 8192, journal first block 18, max trans len 1024, max batch 900, max 
> commit age 30, max trans age 30
> Oct 26 03:01:27 h2so4 kernel: ReiserFS: sda1: checking transaction log (sda1)
> Oct 26 03:01:27 h2so4 kernel: ReiserFS: sda1: Using r5 hash to sort names
> Oct 26 03:14:18 h2so4 kernel: Badness in futex_wait at kernel/futex.c:542
> Oct 26 03:14:18 h2so4 kernel:  [<c012b5e1>] futex_wait+0x180/0x18a
> Oct 26 03:14:18 h2so4 kernel:  [<c0115295>] default_wake_function+0x0/0xc
> Oct 26 03:14:18 h2so4 kernel:  [<c0115295>] default_wake_function+0x0/0xc
> Oct 26 03:14:18 h2so4 kernel:  [<c010a323>] convert_fxsr_from_user+0x15/0xd8
> Oct 26 03:14:18 h2so4 kernel:  [<c012b80f>] do_futex+0x35/0x7f
> Oct 26 03:14:18 h2so4 kernel:  [<c01dba43>] copy_from_user+0x34/0x61
> Oct 26 03:14:18 h2so4 kernel:  [<c012b939>] sys_futex+0xe0/0xec
> Oct 26 03:14:18 h2so4 kernel:  [<c0103da5>] sysenter_past_esp+0x52/0x71
> Oct 26 03:14:18 h2so4 kernel: Badness in futex_wait at kernel/futex.c:542
> Oct 26 03:14:18 h2so4 kernel:  [<c012b5e1>] futex_wait+0x180/0x18a
> Oct 26 03:14:18 h2so4 kernel:  [<c0115295>] default_wake_function+0x0/0xc
> Oct 26 03:14:18 h2so4 kernel:  [<c0115295>] default_wake_function+0x0/0xc
> Oct 26 03:14:18 h2so4 kernel:  [<c010a323>] convert_fxsr_from_user+0x15/0xd8
> Oct 26 03:14:18 h2so4 kernel:  [<c012b80f>] do_futex+0x35/0x7f
> Oct 26 03:14:18 h2so4 kernel:  [<c01dba43>] copy_from_user+0x34/0x61
> Oct 26 03:14:18 h2so4 kernel:  [<c012b939>] sys_futex+0xe0/0xec
> Oct 26 03:14:18 h2so4 kernel:  [<c0103da5>] sysenter_past_esp+0x52/0x71
> Oct 26 03:14:21 h2so4 init: Switching to runlevel: 0
> Oct 26 03:14:25 h2so4 rpc.statd[10128]: Caught signal 15, un-registering and 
> exiting.
> Oct 26 03:14:26 h2so4 kernel: Kernel logging (proc) stopped.
> Oct 26 03:14:26 h2so4 kernel: Kernel log daemon terminating.
> Oct 26 03:14:28 h2so4 exiting on signal 15
> Oct 26 10:10:17 h2so4 syslogd 1.4.1: restart. 
