Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269308AbRHTUt3>; Mon, 20 Aug 2001 16:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269291AbRHTUtT>; Mon, 20 Aug 2001 16:49:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4344 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269274AbRHTUtJ>; Mon, 20 Aug 2001 16:49:09 -0400
Message-ID: <3B8177BC.F8EB3EE@mvista.com>
Date: Mon, 20 Aug 2001 13:49:00 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: llx@swissonline.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: misc questions about kernel 2.4.x internals
In-Reply-To: <200108201452.f7KEqxk18219@mail.swissonline.ch> <3B815D97.680B37A5@mvista.com> <200108201946.f7KJkGk12091@mail.swissonline.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Widmer wrote:
> 
> thanks
> 
> > You would/ could assign it a real time priority and make it SCHED_FIFO
> > or SCHED_RR.
> 
> do you have references to an example how to to it?
> 
> > If you do this, it is a good idea to make the priority
> > used available to be "tuned".  Not every one will agree that _your_
> > handler is as important as you think it is.
> 
> ye i think so - in our cluster it's just fine at the moment :)
> 
> chris
Read the man page on sched_setscheduler(2).  If in the kernel, you would
need to make a system call.  I am afraid I don't know exactly how this
is done, but it is possible.  By the way, some scheduler patches allow
the real time priority to go well above 99, thus if you need this:

#ifndef MAX_PRI
#define MAX_PRI 99
#endif

if you want the maximum priority.

George
