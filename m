Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVGFT6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVGFT6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVGFT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:32 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:15786 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262271AbVGFP6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:58:55 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 16:58:53 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061351.18410.s0348365@sms.ed.ac.uk> <20050706133915.GB19467@elte.hu>
In-Reply-To: <20050706133915.GB19467@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061658.53845.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 14:39, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Then it continues to boot. I'm getting periodic lockups under high
> > network load, however, though I suspect that might be the ipw2200
> > driver I compiled against the realtime-preempt kernel. Are there any
> > known issues with external modules versus PREEMPT-RT?
>
> you should keep an eye on compile-time warnings, but otherwise, most of
> the API deviations should be runtime detected and should be reported in
> one way or another (if you have all debugging options enabled).

I now no longer suspect the ipw2200 module. It locks up within 5 minutes, 
reliably, with or without network load. I seem to always have to promote a 
large redraw in X11 before it occurs, but this is just hand waving, I don't 
really have any evidence.

>
> > Any way to debug these problems?
>
> Is it a hard lockup? One good way to debug it is via serial logging and
> the NMI watchdog. I've attached a QuickStart below. Another method to
> debug hard lockups is to enable 'direct keyboard interrupts', via:
>
>   echo 1 > /proc/sys/kernel/debug_direct_keyboard

It's a hard lockup, and I'll attempt to carry this out.

>
> note that with that switch activated you can use SysRq even when the
> system is otherwise locked up, but the keyboard IRQ might crash. So the
> best tactic is to not use the keyboard from that point on, only for the
> short period of time when you try to get info out of a crashed system,
> via SysRq. There's more about this flag in this post:
>
>   http://www.uwsg.iu.edu/hypermail/linux/kernel/0411.2/0936.html
>
> 	Ingo

As usual Ingo, this is a thorough answer to my query and it explains exactly 
what I need to do. Fortunately this is an x86 laptop with a serial port, and 
I can easily find or make a cable to debug it over the serial console. I hope 
to have some useful information to you by the end of the day.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
