Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWFFIDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWFFIDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWFFIDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:03:35 -0400
Received: from smtp.ono.com ([62.42.230.12]:7468 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1751148AbWFFIDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:03:34 -0400
Date: Tue, 6 Jun 2006 10:03:03 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060606100303.4c9e89da@werewolf.auna.net>
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.2.1cvs2 (GTK+ 2.9.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006 23:20:04 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
> 
> - Lots of PCI and USB updates
> 
> - The various lock validator, stack backtracing and IRQ management problems
>   are converging, but we're not quite there yet.
> 

One more, could not find it already reported (if yes, sorry for the noise).
It is not in lockdep-combo as 20060606.

ide-floppy driver 0.99.newide
stopped custom tracer.
BUG: warning at kernel/lockdep.c:1856/trace_hardirqs_on()
 [<c01034ba>] show_trace+0x12/0x14
 [<c0103b8d>] dump_stack+0x19/0x1b
 [<c0133c56>] trace_hardirqs_on+0x14d/0x152
 [<f88bcaa9>] idefloppy_pc_intr+0x192/0x6ca [ide_floppy]
 [<f89402e2>] ide_intr+0x74/0x1c7 [ide_core]
 [<c013d212>] handle_IRQ_event+0x2e/0x63
 [<c013e451>] handle_edge_irq+0xad/0x132
 [<c0104dc7>] do_IRQ+0x6c/0xa5
 =======================
 [<c0102ec1>] common_interrupt+0x25/0x2c
 [<c0103029>] error_code+0x39/0x40
hdb: No disk in drive
hdb: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdb: No disk in drive

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.16-jam19 (gcc 4.1.1 20060518 (prerelease)) #1 SMP PREEMPT Tue
