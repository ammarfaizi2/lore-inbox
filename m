Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313909AbSDJWHz>; Wed, 10 Apr 2002 18:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313910AbSDJWHz>; Wed, 10 Apr 2002 18:07:55 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:24572 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S313909AbSDJWHy>; Wed, 10 Apr 2002 18:07:54 -0400
Date: Wed, 10 Apr 2002 15:07:15 -0700
From: Chris Wright <chris@wirex.com>
To: Robert Love <rml@tech9.net>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
Message-ID: <20020410150715.A1550@figure1.int.wirex.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Duncan Sands <duncan.sands@math.u-psud.fr>,
	Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16vHbV-0000M5-00@baldrick> <1018463295.6681.18.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Love (rml@tech9.net) wrote:
> On Wed, 2002-04-10 at 08:53, Duncan Sands wrote:
> 
> > error: halt[411] exited with preempt_count 1
> > 
> > This was after about 24 hours of up time.  What can I do to help
> > track down this locking problem?
> 
> It is not a big deal.  The issue is that in the system shutdown code,
> something does not release a lock but just figures "the system is going
> down, what is the point?"  It is probably the BKL ...
> 
> For the sake of code readability and having nothing quit with a nonzero
> preempt_count, we should explicitly drop the lock, but it is not hurting
> anything (now, if you get this message elsewhere, there may be a
> problem).

ditto with nfs.  doesn't require a system shutdown, just stopping the
nfs server.

error: nfsd[983] exited with preempt_count 1
error: rpciod[994] exited with preempt_count 1
error: lockd[993] exited with preempt_count 1

cheers,
-chris
