Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261167AbREUO0M>; Mon, 21 May 2001 10:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbREUO0C>; Mon, 21 May 2001 10:26:02 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:60310 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S261167AbREUOZt>; Mon, 21 May 2001 10:25:49 -0400
Message-ID: <3B092555.DE564871@kegel.com>
Date: Mon, 21 May 2001 07:25:25 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sean@dev.sportingbet.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux scalability?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter wrote:
> On Sat, May 19, 2001 at 10:31:01AM +0200, Sasi Peter wrote: 
> > On Fri, 18 May 2001, Sean Hunter wrote: 
> > 
> > > Why would you want to run a web server with 8 processors rather than four 
> > > webservers with 2 each? 
> > 
> > As you might already know, after the interviews to Mingo I assumed, that a 
> > major portion of the achievements was enabled by the 2.4 scalability 
> > enhacements. That is why I wrote to LKML, to ask about the 2.4 
> > scalability, if anybody out there could tell us about the linux kernel's 
> > scalability possibily compared to W2k scalability... 
>
> Yup. The problem is that you're trying to measure scalability in performance 
> of an i/o-bound task by comparing a machine with greater i/o resource but less 
> processing power with one with greater processing but poorer i/o. Surprisingly 
> enough, the one with the best i/o wins. This isn't really a fair comparison 
> between the two platforms. 

The document tree (21 - 26 GB) is small enough to fit in RAM (32 GB),
so the speed of the disk is not likely to have a noticable impact.
(See http://boudicca.tux.org/hypermail/linux-kernel/2001week20/1276.html )

A lot of people during the Mindcraft discussion made the mistake
of calling the test unfair.
Regardless of whether the initial test was fair, it actually showed 
interesting performance weaknesses in Linux, ones the kernel team
has successfully addressed.

> My point was that in the real world having this configuration for a webserver 
> is unlikely to be sensible at all. 

That's certainly true.  On the other hand, worrying about how many
nanoseconds a system call takes isn't really an issue in the
real world, but kernel hackers love to optimize system call overhead
anyway.  This is the same sort of intellectual challenge.  Plus,
it impresses the beancounters, and they're the ones who buy the
systems and keep us all employed.

- Dan
