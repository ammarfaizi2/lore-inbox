Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWBWNG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWBWNG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWBWNG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:06:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:8086 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751210AbWBWNG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:06:57 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Date: Thu, 23 Feb 2006 14:06:43 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu>
In-Reply-To: <20060223124152.GA4008@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231406.43899.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 13:41, Ingo Molnar wrote:

> 
> What Arjan did is quite nifty, as it moves the page clearing out from 
> under the mmap_sem-held critical section.

So that was the point not the rescheduling under lock? Or both?

BTW since it touches your area of work you could comment what
you think about not using voluntary preempt points for fast sleep locks
like I later proposed.

> How that is achieved is really  
> secondary, it's pretty clear that it could be done in some nicer way.

Great we agree then.
> 
> And no, i dont accept the lame "dont come into the kitchen if you cant 
> stand the flames" excuse: your reply was totally uncalled for, was 
> totally undeserved 

Well he didn't supply any data so I asked for more.

> and was totally unnecessary. It was incredibly mean  
> spirited, 

Sorry, but I don't think that's true. Mean spirited would be
"we don't care, go away".  When I think that I generally don't 
answer the email.

I could have perhaps worded it a bit nicer, agreed, but I think
the core of my reply - we need more analysis for that - was
quite constructive. At least for one of the subproblems I even
proposed a better solution. If there is more analysis of the
problem maybe I can help even for more of it.

Also it's probably quite clear that added lots of special purpose caches
to task_struct for narrow purpose isn't a good way to do optimization.

The mail was perhaps a bit harsher than it should have been
because I think Arjan should have really known better...

> You might not realize it, but replies like this can scare away novice 
> contributors forever! You could scare away the next DaveM. Or the next 
> Alan Cox. Or the next Andi Kleen. Heck, much milder replies can scare 
> away even longtime contributors: see Rusty Russell's comments from a 
> couple of days ago ...

I must say I'm feeling a bit unfairly attacked here because I think I generally
try to help new patch submitters (at least if their basic ideas are sound even
if some details are wrong)

e.g. you might notice that a lot of patches from new contributors
go smoother into x86-64 than into i386.

-Andi
