Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVDDVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVDDVee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDDVc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:32:29 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:22247 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261406AbVDDVPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:15:24 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050404204725.GA17818@elte.hu>
References: <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
	 <1112472372.27149.23.camel@localhost.localdomain>
	 <20050402203550.GB16230@elte.hu>
	 <1112474659.27149.39.camel@localhost.localdomain>
	 <1112479772.27149.48.camel@localhost.localdomain>
	 <1112486812.27149.76.camel@localhost.localdomain>
	 <20050404200043.GA16736@elte.hu>
	 <1112647253.5147.17.camel@localhost.localdomain>
	 <20050404204725.GA17818@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 04 Apr 2005 17:14:56 -0400
Message-Id: <1112649296.5147.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 22:47 +0200, Ingo Molnar wrote:

> > Currently my fix is in yield to lower the priority of the task calling 
> > yield and raise it after the schedule.  This is NOT a proper fix. It's 
> > just a hack so I can get by it and test other parts.
> 
> yeah, yield() is a quite RT-incompatible concept, which could livelock 
> an upstream kernel just as much - if the task in question is SCHED_FIFO.  
> Almost all yield() uses should be eliminated from the upstream kernel, 
> step by step.

Now the question is, who will fix it? Preferably the maintainers, but I
don't know how much of a priority this is to them. I don't have the time
now to look at this and understand enough about the code to be able to
make a proper fix, and I'm sure you have other things to do too.

-- Steve


