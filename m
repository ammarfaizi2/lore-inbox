Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVAUVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVAUVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVAUVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:47:20 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:37349 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262537AbVAUVpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:45:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oY2DfBv4VYeAFM7QPkCP6jbiBIIrLKaibBPjMRHNbviu4BWC5r5HNS2qQEoWvbXX97hg1mRcllkjHASv2AS8oPyxgrch2NQAEiYkV5S2ZOBrF0SxPvY8gVqln7xS2iKfyyxnW/7zPBlxwQ2ibUSRLGzDZ4pP4iEOccN0+Woz7Ts=
Message-ID: <3f250c7105012113455e986ca8@mail.gmail.com>
Date: Fri, 21 Jan 2005 17:45:13 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <3f250c71050121132713a145e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111083837.GE26799@dualathlon.random>
	 <3f250c71050121132713a145e3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I have another question. You included an oom_adj entry in /proc for
each process. This was the approach you used in order to allow someone
or something to interfere the ranking algorithm from userland, right?
So if i have an another ranking algorithm in user space, I can use it
to complement the kernel decision as necessary. Was it your idea?

BR,

Mauricio Lin.


On Fri, 21 Jan 2005 17:27:11 -0400, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Hi Andrea,
> 
> I applied your patch and I am checking your code. It is really a very
> interesting work. I have a question about the function
> __set_current_state(TASK_INTERRUPTIBLE) you put in out_of_memory
> function. Do not you think it would be better put set_current_state
> instead of __set_current_state function? AFAIK the set_current_state
> function is more feasible for SMP systems, right?
> 
> BR,
> 
> Mauricio Lin.
> 
> 
> On Tue, 11 Jan 2005 09:38:37 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> > On Tue, Jan 11, 2005 at 01:35:47AM +0100, Thomas Gleixner wrote:
> > > confirmed fix for this available. It was posted more than once.
> >
> > I posted 6 patches (1/4,2/4,3/4,4/4,5/4,6/4), they should be all
> > applied to mainline, they're self contained. They add the userspace
> > ratings too.
> >
> > Those patches fixes a longstanding PF_MEMDIE race too and they optimize
> > used_math as well.
> >
> > I'm running with all 6 patches applied with an uptime of 6 days on SMP
> > and no problems at all. They're all 6 patches applied to the kotd too
> > (plus the other bits posted on l-k as well for the write throttling,
> > just one bit is still missing but I'll add it soon):
> >
> >         ftp://ftp.suse.com/pub/projects/kernel/kotd/i386/HEAD
> >
> >
>
