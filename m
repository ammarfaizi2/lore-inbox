Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTL1Acx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 19:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264892AbTL1Acw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 19:32:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:62957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264884AbTL1Acv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 19:32:51 -0500
Date: Sat, 27 Dec 2003 16:32:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1 oops on boot (cpufreq related)
Message-Id: <20031227163253.6f612adc.akpm@osdl.org>
In-Reply-To: <3FEDEA78.1090301@oracle.com>
References: <3FEDEA78.1090301@oracle.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
>
> pufreq: CPU0 - ACPI performance management activated
>  cpufreq: *P0: 1Mhz, 0 mW, 0 uS
>  cpufreq:  P1: 0Mhz, 0 mW, 0 uS
>  divide error: 0000 [#1]
>  PREEMPT
>  CPU:   0
>  EIP:   0060:[<c02cb03f>]   Not tainted VLI
>  EFLAGS: 00010246
>  EIP is at cpufreq_notify_transition+0xb2/0x17a
>  eax: 001b1000   ebx: 001b1000   ecx: 00000000   edx: 00000000
>  esi: c1a37f70   edi: 00000000   ebp: 0000008b   esp: c1a37fa8
>  ds: 007b   es: 007b   ss:0068
>  Process swapper (pid: 1, threadinfo=c1a36000 task=f7f9f980)
>  Stack: ffffff00 c01164d9 00000060 00000086 f7dab860 f7dab800 0000008b c01156d3
>          c1a37f70 00000001 c1a37f60 c037b940 00000000 00000086 f7dab860 00000064
>          01000000 c037b8e0 c037d37e 00000000 00000000 00000001 00000000 c1a37fa8
>  Call Trace:
>    [<c01164d9>] delay_tsc+0xb/0x15
>    [<c01156d3>] acpi_processor_set_performance+0x1e0/0x3e6
>    [<c04652c1>] acpi_cpufreq_init+0x243/0x2a3
>    [<c045e6e6>] do_initcalls+0x27/0x93
>    [<c012c9e7>] init_workqueues+0xf/0x28
>    [<c01070bd>] init+0x30/0x133
>    [<c010708d>] init+0x0/0x133
>    [<c0108f59>] kernel_thread_helper+0x5/0xb

hmm, I don't think there's much in the way of cpufreq changes in -mm.

Would you be able to try just 2.6.0 plus

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/acpi-20031203.patch

Thanks.
