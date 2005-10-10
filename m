Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVJJW2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVJJW2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJJW2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:28:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62460 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751291AbVJJW2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:28:24 -0400
Subject: Re: Latency data - 2.6.14-rc3-rt13
From: Daniel Walker <dwalker@mvista.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 15:28:21 -0700
Message-Id: <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 15:09 -0700, Mark Knecht wrote:
> On 10/10/05, Daniel Walker <dwalker@mvista.com> wrote:
> > On Mon, 2005-10-10 at 14:28 -0700, Mark Knecht wrote:
> > > On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
> > > <SNIP>
> > > > > then goto Kernel Hacking and select
> > > > > "Interrupts-off critical section latency timing"
> > > > > Then select "Latency tracing"
> > >
> > > Only had to turn on Latency Tracing. The others I had on...
> > >
> > > <SNIP>
> > > > >
> > > > > Daniel
> > > >
> > > > Will do. Building now. I'll be back later.
> > > >
> > >
> > > Unfortunately I didn't think I'd be back this fast. I built the new
> > > kernel and rebooted. The boot starts, gets down to the point where it
> > > tells me that the preempt debug stuff is on, and then jumps to an
> > > endlessly repeating error message:
> > >
> > > init[1]: segfault at ffffffff8010fce0 rip ffffffff8010fce0 rsp
> > > 00007fffffcb09b8 error 15
> > >
> > > This error repeasts endlessly until I reboot.
> > >
> > > Good thing I had another kernel I could boot back into! ;-)
> > >
> > > So, something isn't happy. Is this a -rt thing or a kernel issue?
> >
> > Hmm, it looks like latency tracing doesn't work on x86_64 .. I guess
> > you'll have to wait till someone fixes it .
> >
> > Another option is to turn off "Latency Tracing" then reboot, like it was
> > before but w/o the histogram. Then run,
> >
> > "echo 0 > /proc/sys/kernel/preempt_max_latency"
> >
> > Whenever a new maximum latency is observed it will log it with a stack
> > trace in the system logs. You can report that back here on LKML .
> >
> > You can view the system log with the command "dmesg" , I think .
> >
> > Daniel
> >
> >
> Yes, already that looks interesting. Do I have something going on with
> acpi? This is before running Jack. I'm in Gnome.There are a lot of
> these messages, but they've stopped. I suppose the 3997 is the delay?
> That would coorespond with the info I sent earlier.

I think this is a false reading . Sometimes when a system goes idle it
will cause interrupt disable latency that isn't real (due to process
halting) . You could try turning ACPI off if you can , and turn off
power management ..

Daniel

