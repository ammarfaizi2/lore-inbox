Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130756AbRATEdA>; Fri, 19 Jan 2001 23:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136178AbRATEck>; Fri, 19 Jan 2001 23:32:40 -0500
Received: from mtiwmhc27.worldnet.att.net ([204.127.131.52]:21137 "EHLO
	mtiwmhc27.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S130756AbRATEc3>; Fri, 19 Jan 2001 23:32:29 -0500
Message-ID: <3A691602.EA63E415@att.net>
Date: Fri, 19 Jan 2001 23:37:22 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  
 available
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKIEIINCAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
>         How can you tell when select wakes up the process? What you are seeing has
> nothing whatsoever to do with select and simply has to do with the fact that
> the kernel does not give the CPU to a process the second that process may
> want it.

I guess I can't. But on an idle machine, I would expect a process that
becomes runnable would be run immediately, not on the next clock tick.
strace reports that each select() is taking 0.009xxx seconds of real
time, and the system's CPU load (as reported by top) is under 1%.

...
>         If you have scheduling latency requirements, you MUST communicate them to
> the scheduler. If your process had an altered scheduling class, then you
> would be right -- it should get the CPU immediately. Otherwise, there's no
> reason for the scheduler to give that process the CPU immediately.

OK, if this is the case, how do I alter the scheduling class?

--
Mike Lindner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
