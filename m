Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbSIXO7K>; Tue, 24 Sep 2002 10:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSIXO7K>; Tue, 24 Sep 2002 10:59:10 -0400
Received: from dp.samba.org ([66.70.73.150]:18591 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261383AbSIXO7K>;
	Tue, 24 Sep 2002 10:59:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.38-mm2 [PATCH] 
In-reply-to: Your message of "Tue, 24 Sep 2002 15:54:28 +0530."
             <20020924155428.B4085@in.ibm.com> 
Date: Wed, 25 Sep 2002 00:56:17 +1000
Message-Id: <20020924150424.415792C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020924155428.B4085@in.ibm.com> you write:
> On Tue, Sep 24, 2002 at 02:41:09PM +1000, Rusty Russell wrote:
> > On Mon, 23 Sep 2002 15:15:59 +0530
> > Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > > Later I will submit a full rcu_ltimer patch that contains
> > > the call_rcu_preempt() interface which can be useful for
> > > module unloading and the likes. This doesn't affect
> > > the non-preemption path.
> > 
> > You don't need this: I've dropped the requirement for module
> > unload.
> 
> Isn't wait_for_later() similar to synchornize_kernel() or has the
> entire module unloading design been changed since ?

Yes, that was *days* ago 8)

I now just use a synchronize_kernel() which schedules on every CPU,
and disable preempt in magic places.

Ingo growled at me...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
