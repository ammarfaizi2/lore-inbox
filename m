Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbULINgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbULINgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 08:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbULINgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 08:36:25 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:11934 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261231AbULINgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 08:36:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20041209093211.GC14516@elte.hu>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Thu, 09 Dec 2004 08:36:02 -0500
Message-Id: <1102599362.25841.390.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 10:32 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> > Ingo really scares me with all the removing of local_irq_disables in
> > the rt mode. I'm not sure exactly what is going on there, and why they
> > can, or should be removed. Ingo?
> 
> it is done so that the SLAB code can be fully preempted too. The SLAB
> code is of central importance to the -RT project, if it's not fully
> preemptible then that has a ripple effect on other subsystems (timer,
> signal code, file handling, etc.).
> 
> So while making it fully preemptible was quite challenging (==dangerous,
> scary), i couldnt just keep the SLAB using raw spinlocks, due to the
> locking dependencies. (nor did i have any true inner desire to keep it
> non-preemptible - the point of PREEMPT_RT is to have everything
> preemptible. I want to see how much preemption the Linux kernel can take
> =B-) It has held up surprisingly well i have to say.)

<snip>


> 
> 	Ingo


Ingo,

Thanks for the write up. It really clears things up for me. Now I
understand your approach, not only for slabs, but other areas of the
kernel. Once again, thanks for the explanation.

-- Steve

