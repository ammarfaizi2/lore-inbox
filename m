Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263917AbSITXGe>; Fri, 20 Sep 2002 19:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263924AbSITXGe>; Fri, 20 Sep 2002 19:06:34 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:29825 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S263917AbSITXGd>; Fri, 20 Sep 2002 19:06:33 -0400
Date: Fri, 20 Sep 2002 16:11:33 -0700
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920231133.GA2599@gnuppy.monkey.org>
References: <20020920215029.GB1527@gnuppy.monkey.org> <Pine.LNX.4.44.0209201528360.22066-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209201528360.22066-100000@twinlark.arctic.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 03:30:19PM -0700, dean gaudet wrote:
> > It's better to have an explict pthread_suspend_[thread,all]() function
> 
> could this be implemented by having a gc thread in a unique process group
> and then suspending the jvm process group?

Suspending how ? via signal ?  

Possibly, but having an explicit syscall() call is important since interrupts
are also suspended under that condition, pthread_cond_timedwait(), etc...
It really needs to be suspended in a way that's different than the SIGSOMETHING
mechanism. I was fixing bugs in libc_r, so I know the issues to a certain degree
and bad logic those particular corner cases was screwing me up.

bill

