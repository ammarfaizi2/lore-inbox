Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275353AbSITXkH>; Fri, 20 Sep 2002 19:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275357AbSITXkH>; Fri, 20 Sep 2002 19:40:07 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:5762 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S275353AbSITXkG>; Fri, 20 Sep 2002 19:40:06 -0400
Date: Fri, 20 Sep 2002 16:45:09 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920234509.GA2810@gnuppy.monkey.org>
References: <20020920120606.GA4961@gnuppy.monkey.org> <Pine.LNX.4.44.0209201658240.5862-100000@localhost.localdomain> <20020920215029.GB1527@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920215029.GB1527@gnuppy.monkey.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 02:50:29PM -0700, Bill Huey wrote:
> > how frequently does the GC thread run?
> 
> Don't remember off hand, but it's like to be several times a second which is
> often enough to be a problem especially on large systems with high load.
> 
> The JVM with incremental GC is being targetted for media oriented tasks
> using the new NIO, 3d library, etc... slowness in safepoints would cripple it
> for these tasks. It's a critical item and not easily address by the current
> 1:1 model.

Also throwing a signal to get the ucontext is pretty a expensive way of getting
it. But you folks know this already. Solaris threading has this via a some special
libraries. For large number of actively running threads, say, executing in a middle
of a method block it is potentially a huge problem for scalability.

Again, it's a critical issue from what I see of this.

bill

