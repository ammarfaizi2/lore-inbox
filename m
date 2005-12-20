Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVLTN6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVLTN6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVLTN6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:58:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32491 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751028AbVLTN6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:58:07 -0500
Date: Tue, 20 Dec 2005 14:57:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.15-rc5-rt2 slowness
Message-ID: <20051220135725.GA29392@elte.hu>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain> <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Now, is the solution to bring the SLOB up to par with the SLAB, or to
> > > make the SLAB as close to possible to the mainline (why remove NUMA?)
> > > and keep it for PREEMPT_RT?
> > >
> > > Below is the port of the slab changes if anyone else would like to see
> > > if this speeds things up for them.
> >
> > ok, i've added this back in - but we really need a cleaner port of SLAB
> > ...
> >
> 
> Actually, how much do you want that SLOB code?  For the last couple of 
> days I've been working on different approaches that can speed it up. 
> Right now I have one that takes advantage of the different caches.  
> But unfortunately, I'm dealing with a bad pointer some where that 
> keeps making it bug. Argh!

well, the SLOB is mainly about being simple and small. So as long as 
those speedups are SMP-only, they ought to be fine. The problems are 
mainly SMP related, correct?

	Ingo
