Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVEGP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVEGP6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 11:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVEGP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 11:58:07 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:3308 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261333AbVEGP6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 11:58:01 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: Alexander Nyberg <alexn@telia.com>
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1115483506.12131.33.camel@cobra>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra>  <1115392141.12197.3.camel@cobra>
	 <1115483506.12131.33.camel@cobra>
Content-Type: text/plain
Date: Sat, 07 May 2005 17:57:48 +0200
Message-Id: <1115481468.925.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can crash a host repeatedly just by running a UML instance
> (and causing some load on that instance - like running gcc)
> I captured these messages from the serial console after it crashed:
> 
> Host: Linux x86_64 2.6.11.8 (built with selinux but not enforcing)
> Guest: 2.6.12-rc3-uml
> The UML patch applied on top of rc3 is available here:
> http://213.228.237.37/uml/2.6.12-rc3/uml-x86_64-2.6.12-rc3.patch.bz2
> It was built using the instructions from Jeff Dike at:
> http://user-mode-linux.sourceforge.net/patches.html
> The thread 'kernel-4' is the UML instance, running as a nobody user.
> This was reported to the UML ML and Jeff Dike who advised me to
> post it here too.
> Let me know if you need anything else / testing / etc.
> I am not subscribed to LKML, so please CC me on all emails.


I never get uml to compile around here, 2.6.12-rc3 + that patchkit from
the link you sent blows up with defconfig any my minimal config. Please
attach your guest .config and if you can you might aswell put your guest
vmlinux somewhere where i can download it too.

> general protection fault: 0000 [1]
> CPU 0
> Pid: 26926, comm: kernel-4 Not tainted 2.6.11.8
> RIP: 0010:[<ffffffff8010ca47>] <ffffffff8010ca47>{__switch_to+311}
> RSP: 0018:ffff8100a7635d48  EFLAGS: 00010016
> RAX: 0000c8e816000002 RBX: ffff8100b895f320 RCX: 00000000c0000102
> RDX: 000000000000c8e8 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff810090db3a00 R09: 0000000000006933
> R10: 0000000000000000 R11: 0000000000000202 R12: ffff8100a827b890
> R13: ffff8100b895f010 R14: ffff8100a827b580 R15: ffff8100a827b7f8
> FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
> knlGS:0000000000000d7e
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 000000006880d010 CR3: 00000000a2321000 CR4: 00000000000006e0
> Process kernel-4 (pid: 26926, threadinfo ffff810060884000, task
> ffff8100a827b580)
> Stack: ffff8100dc37e180 ffff8100b895f010 ffffffff806b6d50
> ffff8100b895f010
>        000003595b049ed6 ffffffff804f4de4 ffff8100a7635de8
> 0000000000000086
>        0000007500000020 ffff8100b895f010
> Call Trace:<ffffffff804f4de4>{thread_return+0}
> <ffffffff8013cb08>{ptrace_stop+280}
>        <ffffffff8013cde6>{get_signal_to_deliver+358}
> <ffffffff8010d4e3>{do_signal+163}
>        <ffffffff8010e905>{error_exit+0}
> <ffffffff8010de67>{sys_rt_sigreturn+535}
>        <ffffffff8010dee9>{sys_rt_sigreturn+665}
> <ffffffff8010e2b6>{int_signal+18}
> 


