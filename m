Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSFRUPY>; Tue, 18 Jun 2002 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSFRUPX>; Tue, 18 Jun 2002 16:15:23 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:43190 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317597AbSFRUPX>; Tue, 18 Jun 2002 16:15:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Schwartz <davids@webmaster.com>
Cc: mgix@mgix.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Question about sched_yield() 
In-reply-to: Your message of "Tue, 18 Jun 2002 12:12:30 MST."
             <20020618191233.AAA27954@shell.webmaster.com@whenever> 
Date: Wed, 19 Jun 2002 06:19:40 +1000
Message-Id: <E17KPS1-0003pP-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020618191233.AAA27954@shell.webmaster.com@whenever> you write:
> 
> On Wed, 19 Jun 2002 04:56:06 +1000, Rusty Russell wrote:
> 
> >On Mon, 17 Jun 2002 17:46:29 -0700
> >David Schwartz <davids@webmaster.com> wrote:
> 
> >>"The sched_yield() function shall force the running thread to relinquish
> >>the processor until it again becomes the head of its thread list.
> >> It takes no arguments."
> 
> >Notice how incredibly useless this definition is.  It's even defined in 
> >terms of UP.
> 
> =09Huh?! This definition is beautiful in that it makes no such=
> assumptions. How would you say this is invalid on an SMP machine? By
> "the= processor", they mean "the process on which the thread is
> running" (the only one= it could relinquish, after all).

Read again: they use "relinquish ... until", not "relinquish".  Subtle
difference.

I have 32 processors and 32 threads.  One does a yield().  What
happens?  What should happen?

Given that yield is "sleep for some time but I won't tell you what I'm
doing", I have no sympathy for yield users 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
