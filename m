Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSIWVKW>; Mon, 23 Sep 2002 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbSIWVKW>; Mon, 23 Sep 2002 17:10:22 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:58240 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261392AbSIWVKV>; Mon, 23 Sep 2002 17:10:21 -0400
Date: Mon, 23 Sep 2002 14:12:19 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923211219.GB2075@gnuppy.monkey.org>
References: <20020920215029.GB1527@gnuppy.monkey.org> <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 09:38:52AM -0400, Bill Davidsen wrote:
> Could you comment on how whell this works (or not) with linuxthreads,
> Solaris, and NGPT? I realize you probably haven't had time to look at NPTL
> yet. If an N:M model is really better for your application you might be
> able to just run NGPT.

I can't. I'm in a different OS community, FreeBSD, and I deal with issues
related to threading systems there. There's many variables that could be
at play for various performance categories.

> Since preempt threads seem a problem, cound a dedicated machine run w/o
> preempt? I assume when you say "high load" that you would be talking a
> server, where performance is critical.

The JVM itself can has a habit of really stretching the amount of resources
available in many areas and fringe logic in commonly used systems. I can't
really say what the problems are until the Blackdown folks start integrating
the new threading model and then start testing it.

However, there is a mutex fast path in the code itself that can be optionally
used in place of the the OS back version. They felt it was significant to do
the work for that for some reason, so I'm just going to assume that this is
important until otherwise noted.

bill

