Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDMM4S>; Fri, 13 Apr 2001 08:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRDMM4I>; Fri, 13 Apr 2001 08:56:08 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:38490 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130493AbRDMM4A>;
	Fri, 13 Apr 2001 08:56:00 -0400
Date: Fri, 13 Apr 2001 07:55:53 -0500
From: Michael Raymond <mraymond@sgi.com>
To: Mark Salisbury <gonar@mediaone.net>
Cc: george anzinger <george@mvista.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
Message-ID: <20010413075553.A102611@fsgi654.americas.sgi.com>
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org> <m1snjdtgcc.fsf@frodo.biederman.org> <3AD6B894.39848F3F@mvista.com> <002d01c0c414$346b2140$6501a8c0@gonar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002d01c0c414$346b2140$6501a8c0@gonar.com>; from gonar@mediaone.net on Fri, Apr 13, 2001 at 08:20:56AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 08:20:56AM -0400, Mark Salisbury wrote:
> inner loop, i.e. interrupt timer code should never have to convert from some
> real time value into number of decrementer ticks in order to set up the next
> interrupt as that requires devides (and 64 bit ones at that) in a tickless
> system.
> 
> this is why any variable interval list/heap/tree/whatever should be kept in
> local ticks.  frequently used values can be pre-computed at boot time to
> speed up certain calculations (like how many local ticks/proc quantum)

    What about machines without synchronized local ticks?  We're going to
have to end up doing conversions anyway because of drift and machines
without even the same speed CPUs.  A time based system using local cached
values such as cycles_per_usec would better be able to handle this.
       	       		       	     	       	    Michael

-- 
Michael A. Raymond              Office: (651) 683-3434
Irix Core Kernel Group
