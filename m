Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270316AbUJTOSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270316AbUJTOSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270341AbUJTORi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:17:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:46539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270316AbUJTOJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:09:07 -0400
X-Authenticated: #4399952
Date: Wed, 20 Oct 2004 16:24:28 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020162428.7c4c5f53@mango.fruits.de>
In-Reply-To: <20041020152507.3c167ca8@mango.fruits.de>
References: <20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041020145019.176826cb@mango.fruits.de>
	<20041020125500.GA8693@elte.hu>
	<20041020152507.3c167ca8@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 15:25:07 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Wed, 20 Oct 2004 14:55:00 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i dont think it's caused by trace_enabled - the trace you sent last time
> > clearly showed erratic behavior. There's one piece of code i suspect in
> > particular - could you try the patch below ontop of -U8? (i have
> > compile- and boot- tested it)
> 
> mango:/usr/src/linux-2.6.9-rc4-mm1-U8# patch -p1 </home/tapas/foo.patch 
> patching file kernel/sched.c
> Hunk #5 succeeded at 3843 with fuzz 1.
> 
> building anyways, reporting later..

Hi,

it seems that the pauses went away with that patch. The system is showing a
different weird behaviour now. On last bootup the machine slowly died away
(first my email program froze upon checking for mail, then starting top
would just hang the respective xterm. ps still ran and procuced output [i
didn't capture it though, doh], other stuff would hang, too. upon
ctrl-alt-bkspc to kill the x server, it all locked up.. i have no serial
console or other machine to test if it was still up in any way.

And on this bootup the pauses are still gone, but as soon as i echo'ed 1
into trace_enabled the mouse started to become very skippy (update freq at
about 3hz). Keyboard is fine though.. putting trace_enabled back to 0
doesn't fix it. I suppose it's just a matter of time until the next lockup.
We'll see though..

Syslog only sees critical section timing reports, no BUG's afaics.

flo
