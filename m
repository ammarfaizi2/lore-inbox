Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVKBPiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVKBPiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVKBPiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:38:23 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3029 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965084AbVKBPiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:38:22 -0500
Subject: Re: 2.6.14-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <cb2ad8b50511020645i23c164d4h7140c4c352159974@mail.gmail.com>
References: <20051030133316.GA11225@elte.hu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
	 <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
	 <20051102102116.3b0c75d1@mango.fruits.de>
	 <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
	 <20051102144015.GA19845@elte.hu>
	 <cb2ad8b50511020645i23c164d4h7140c4c352159974@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 02 Nov 2005 10:37:56 -0500
Message-Id: <1130945876.29788.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 09:45 -0500, Carlos Antunes wrote:
> On 11/2/05, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Carlos Antunes <cmantunes@gmail.com> wrote:
> >
> > > > running the code i simply get:
> > > >
> > > > ~$ ./timing
> > > > Failed to create thread # 382
> >
> > i suspect this is due to the stack ulimit being too high. Try something
> > like 'ulimit -s 128', which will make it 128K, instead of the default
> > 8MB.
> >
> 
> Ingo,
> 
> First of all, thank you for all the great work you've contributed to
> the Linux community.
> 
> Now the question: do you have any ideas about what might make
> SCHED_OTHER perform better than SCHED_FIFO when in the presence of a

Hi Carlos,

Sorry I didn't get back to you sooner.  I was already getting ready for
bed last night when you sent me your program.  So I'm just getting
around to looking into this now.

To answer your question of why SCHED_OTHER may be preforming better than
SCHED_FIFO (although it shouldn't), probably shows something in either
the timing code, or the priority inheritance.  Since a SCHED_OTHER
thread will skip the PI and other things to get it to perform
reliable.  

Now could you post/send your CONFIG_FILE. I'm currently getting a test
machine ready to run your program.

Thanks,

-- Steve


