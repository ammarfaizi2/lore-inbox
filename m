Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264380AbRFSQKx>; Tue, 19 Jun 2001 12:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264381AbRFSQKo>; Tue, 19 Jun 2001 12:10:44 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:22557
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264380AbRFSQKg>; Tue, 19 Jun 2001 12:10:36 -0400
Date: Tue, 19 Jun 2001 09:09:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dan Kegel <dank@kegel.com>
Cc: ognen@gene.pbi.nrc.ca,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619090956.R3089@work.bitmover.com>
Mail-Followup-To: Dan Kegel <dank@kegel.com>, ognen@gene.pbi.nrc.ca,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	laughing@shared-source.org
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca> <3B2F769C.DCDB790E@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B2F769C.DCDB790E@kegel.com>; from dank@kegel.com on Tue, Jun 19, 2001 at 08:58:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 08:58:20AM -0700, Dan Kegel wrote:
> ognen@gene.pbi.nrc.ca wrote:
> > 
> > On an unrelated note:
> > 
> > I noticed the quote below in your message. Is this a true quote or just a
> > joke going around? I have tried believing it is just a joke but I am
> > scared it is not.
> > 
> > >--
> > > "A Computer is a state machine.
> > >  Threads are for people who can't program state machines."
> > >       - Alan Cox
> 
> Alan, did you really say that, or are people taking your name in vain?

Yup Alan said and I liked it so much I put it on my quotes page,
http://www.bitmover.com/lm/quotes.html

Another one that I can't believe I forgot is from Rob Pike:

    "If you think you need threads then your processes are too fat"

And one from me:

    ``Think of it this way: threads are like salt, not like pasta. You
    like salt, I like salt, we all like salt. But we eat more pasta.''

Threads are a really bad idea.  All you need are processes and either the
ability to not fork the VM (Linux' clone, Plan 9's rfork) or just good
old mmap(2).  If you allow threads then all you are saying is that your
process model is so pathetic you had to invent another, supposedly lighter
weight, object to do the same thing.  

Don't you think it is funny that Sun doesn't publish numbers comparing
their thread performance to process performance?  Sure, you can find 
context switch benchmarks where they have user level switching going on
but those are a red herring.  The real numbers you want are the kernel
level context switches and those are just as expensive as the process
context switch numbers.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
