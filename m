Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSLFU00>; Fri, 6 Dec 2002 15:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267586AbSLFU00>; Fri, 6 Dec 2002 15:26:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34550 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265727AbSLFU0Z>;
	Fri, 6 Dec 2002 15:26:25 -0500
Message-ID: <3DF109A3.A359A56@mvista.com>
Date: Fri, 06 Dec 2002 12:33:39 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@ccur.com
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer (let's try again)
References: <Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com> <3DF10408.83ECE6C8@ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> 
> Linus Torvalds wrote:
> 
> Hi Linus,
> 
> Sorry about my last message (which quoted everything but didn't add
> anything).  I shouldn't try to answer email and talk on the phone at
> the same time.
> 
> > It's been tested, and the only problem I found (which is kind of
> > fundamental) is that if the system call gets interrupted by a signal and
> > restarted, and then later returns successfully, the partial restart will
> > have updated the "remaining time" field to whatever was remaining when the
> > restart was started.
> >
> 
> George's Posix timers patch sets the time remaining to zero in the
> success case.  I think this is the right thing to do.
> 
> I don't have a copy of the spec in front of me.  IIRC, it says that you have
> to set the time remaining in the interrupted case.  It says nothing
> about setting it on the success case.  I would leave the lawyers out
> of writing software.
> 
> I wish the IEEE would make the Posix specs available online for free.
> I gave the IEEE money for years...

Try: http://www.opengroup.org/onlinepubs/007904975/toc.htm
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
