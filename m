Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268528AbTBOEWG>; Fri, 14 Feb 2003 23:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268529AbTBOEWG>; Fri, 14 Feb 2003 23:22:06 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:15232 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S268528AbTBOEWF>; Fri, 14 Feb 2003 23:22:05 -0500
Date: Sat, 15 Feb 2003 04:34:05 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215043405.GB5438@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <20030214024046.GA18214@bjl1.jlokier.co.uk> <Pine.LNX.4.50.0302141603220.988-100000@blue1.dev.mcafeelabs.com> <20030215010153.GE4333@bjl1.jlokier.co.uk> <Pine.LNX.4.50.0302141744070.988-100000@blue1.dev.mcafeelabs.com> <20030215020838.GH4333@bjl1.jlokier.co.uk> <Pine.LNX.4.50.0302142005550.988-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302142005550.988-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Many ( many ) times, when you're going to wait for events, you want to
> specify a maximum wait time ( reletive time ) and not an absolute time.
> This is how ppl think about "timeouts". Different beast is the absolute
> timer, that you can easily achieve with POSIX timers ( TIMER_ABSTIME ) and
> a sigfd() dropped inside an event retrieval interface.

Agreed, both interfaces are useful.  You see that epoll_wait is
optimised for one in particular though.

Curiously.  I'll probably continue to use a calculated relative
timeout instead of using a POSIX timer, as the overhead of setting up
and tearing down the latter is more system calls which we still like
to avoid if it's not hard.

-- Jamie
