Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWEKLZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWEKLZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWEKLZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:25:20 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:4589 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1030227AbWEKLZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:25:19 -0400
Message-ID: <44631F1B.8000100@compro.net>
Date: Thu, 11 May 2006 07:25:15 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: markh@compro.net, Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com> <44623ED4.1030103@compro.net>
In-Reply-To: <44623ED4.1030103@compro.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:
> Steven Rostedt wrote:
>>> Configured for "Preempable Kernel" I got the following but no "stops"
>>> came with it.
>>
>> Hmm, do you have "Compile kernel with frame pointers" turned on. It's in
>> kernel hacking. It usually gives a better stack trace.
>>
> 
> I'll turn frame pointers on on this machine and do it again and then
> also send you (off list) the logdev stuff you asked for from another
> machine that is configured complete-preempt.
> 

This is with frame pointers on but doesn't look any more revealing to
me. After this one my network connection into the emulation was broken
BTW. And yes hard and soft irqs are threaded, preemptable-kernel, and
classic RCU

BUG: scheduling while atomic: softirq-timer/1/0x00000100/15
caller is schedule+0x33/0xf0
 [<b01041c9>] show_trace+0xd/0xf (8)
 [<b01041e2>] dump_stack+0x17/0x19 (12)
 [<b03112ec>] __schedule+0x517/0x95b (96)
 [<b031188f>] schedule+0x33/0xf0 (28)
 [<b014381f>] synchronize_irq+0x94/0xb9 (40)
 [<b0143943>] disable_irq+0x31/0x35 (16)
 [<f0a12715>] vortex_timer+0xa1/0x55b [3c59x] (72)
 [<b01261d5>] run_timer_softirq+0x1ce/0x3de (56)
 [<b012212c>] ksoftirqd+0x110/0x1cb (60)
 [<b012f851>] kthread+0xc8/0xcc (32)
 [<b0100e15>] kernel_thread_helper+0x5/0xb (268935196)

I hope it was OK to add Ingo to the CC list?

Mark



