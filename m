Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264520AbSIWAJ3>; Sun, 22 Sep 2002 20:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264626AbSIWAJ3>; Sun, 22 Sep 2002 20:09:29 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:7809 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S264520AbSIWAJ3>; Sun, 22 Sep 2002 20:09:29 -0400
Date: Sun, 22 Sep 2002 17:11:25 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923001125.GA1983@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com> <m1u1khkgt7.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u1khkgt7.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 12:41:40PM -0600, Eric W. Biederman wrote:
> They are talking about an incremental GC routine so it does not need to stop
> all threads simultaneously.  Threads only need to be stopped when the GC is gather
> a root set.  This is what the safe points are for right?  And it does
> not need to be 100% accurate in finding all of the garbage.  The
> collector just needs to not make mistakes in the other direction.

There's a mixture of GC algorithms in HotSpot including generational and I
believe a traditional mark/sweep. GC isn't my expertise per se.

Think, you have a compiled code block and you suspend/interrupt threads when
you either start hitting the stack yellow guard or by a periodic GC thread...

That can happen anytime, so you can't just expect things to drop onto a
regular boundary in the compiled code block. It's for that reason that
you have to some kind of OS level threading support to get the ucontext.

bill

