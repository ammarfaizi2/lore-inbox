Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWEJSax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWEJSax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWEJSax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:30:53 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:19917 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932435AbWEJSaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:30:52 -0400
Message-ID: <44623157.9090105@compro.net>
Date: Wed, 10 May 2006 14:30:47 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Wow! I asked for some info on your system, and boy, did I get info! :)
> 

Sorry. I talk to much.

>> I can only say for sure that I do not have these "stops" when running
>> any other kernel or when running the rt20 kernel in any of the
>> non-complete preemption modes.
>>

Configured for "Preempable Kernel" I got the following but no "stops"
came with it.

BUG: scheduling while atomic: softirq-timer/1/0x00000100/15
caller is schedule+0x33/0xf0
 [<b0309acc>] __schedule+0x517/0x95b (8)
 [<f09d7627>] mdio_ctrl+0xaa/0x135 [e100] (48)
 [<f09d7627>] mdio_ctrl+0xaa/0x135 [e100] (12)
 [<b030a06c>] schedule+0x33/0xf0 (36)
 [<b012eee5>] prepare_to_wait+0x12/0x4f (8)
 [<b0142318>] synchronize_irq+0x96/0xba (20)
 [<b012eda0>] autoremove_wake_function+0x0/0x37 (12)
 [<f0a13677>] vortex_timer+0xa0/0x563 [3c59x] (24)
 [<b0125b76>] __mod_timer+0x8c/0xc3 (12)
 [<f09d8998>] e100_watchdog+0x0/0x39c [e100] (24)
 [<b030a4cf>] cond_resched_softirq+0x64/0xaa (8)
 [<b02a2dcd>] dev_watchdog+0x77/0xac (4)
 [<f0a135d7>] vortex_timer+0x0/0x563 [3c59x] (12)
 [<b0125902>] run_timer_softirq+0x1bf/0x3a7 (8)
 [<b0121960>] ksoftirqd+0x112/0x1cc (52)
 [<b012184e>] ksoftirqd+0x0/0x1cc (52)
 [<b012eb9c>] kthread+0xc2/0xc6 (4)
 [<b012eada>] kthread+0x0/0xc6 (12)
 [<b0100e35>] kernel_thread_helper+0x5/0xb (16)

Mark

