Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSHZTlE>; Mon, 26 Aug 2002 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSHZTlE>; Mon, 26 Aug 2002 15:41:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56816 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317603AbSHZTlC>;
	Mon, 26 Aug 2002 15:41:02 -0400
Message-ID: <3D6A8536.83B30C18@mvista.com>
Date: Mon, 26 Aug 2002 12:44:54 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Aleksandar Kacanski <kacanski@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory leak
References: <Pine.LNX.3.95.1020826152100.6296B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Mon, 26 Aug 2002, Aleksandar Kacanski wrote:
> 
> > Hello,
> > I am running 2.4.18-3 version of the kernel on smp dual
> > processor and 1GB of RAM. My memory usage is increasing and
> > I can't find what exactly is eating memory. Top and proc
> > are reporting increases, but I would like to know of a
> > better way of tracing usage of memory and possible leak in
> > application(s).
> >
> > Please reply to kacanski@yahoo.com
> > thanks                Sasha
> >
> >
> 
> Applications that use malloc() and friends, get more memory from
> the kernel by resetting the break address. It's called "morecore()".
> You can put a procedure, perhaps off SIGALRM, that periodically
> checks the break address and writes it to a log. Applications
> that end up with an ever-increasing break address have memory
> leaks. Note that the break address is almost never set back.
> This is not an error; malloc() assumes that if you used a lot
> of memory once, you'll probably use it again. Check out sbrk()
> and brk() in the man pages.

But this all comes back when the application ends.  You
should be able to see the memory reappear when the app
terminates.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
