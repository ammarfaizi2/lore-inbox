Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317909AbSFSPbE>; Wed, 19 Jun 2002 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317910AbSFSPbD>; Wed, 19 Jun 2002 11:31:03 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:42636 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317909AbSFSPbC>; Wed, 19 Jun 2002 11:31:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield() 
In-reply-to: Your message of "Wed, 19 Jun 2002 07:29:04 -0400."
             <Pine.LNX.3.96.1020619072548.1119D-100000@gatekeeper.tmr.com> 
Date: Thu, 20 Jun 2002 00:03:34 +1000
Message-Id: <E17Kg4s-0001Lz-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1020619072548.1119D-100000@gatekeeper.tmr.com> you wr
ite:
> On Wed, 19 Jun 2002, Rusty Russell wrote:
> 
> > On Mon, 17 Jun 2002 17:46:29 -0700
> > David Schwartz <davids@webmaster.com> wrote:
> > > "The sched_yield() function shall force the running thread to relinquish 
the 
> > > processor until it again becomes the head of its thread list. It takes no
 
> > > arguments."
> > 
> > Notice how incredibly useless this definition is.  It's even defined in ter
ms
> > of UP.
> 
> I think you parse this differently than I, I see no reference to UP. The
> term "the processor" clearly (to me at least) means the processor running
> in that thread at the time of the yeild.
> 
> The number of processors running in a single thread at any one time is an
> integer number in the range zero to one.

It's the word "until": "relinquish the processor until".

It's pretty clearly implied that it's going to "unrelinquish" *the
processor* at the end of this process.

So, by your definition, it can be scheduled on another CPU before it
becomes head of the thread list?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
