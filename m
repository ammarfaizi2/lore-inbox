Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135432AbRDMHXl>; Fri, 13 Apr 2001 03:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135437AbRDMHXW>; Fri, 13 Apr 2001 03:23:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36441 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135442AbRDMHXK>; Fri, 13 Apr 2001 03:23:10 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: george anzinger <george@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Apr 2001 01:21:39 -0600
In-Reply-To: Andre Hedrick's message of "Thu, 12 Apr 2001 21:04:28 -0700 (PDT)"
Message-ID: <m1snjdtgcc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> On Thu, 12 Apr 2001, george anzinger wrote:
> 
> > Actually we could do the same thing they did for errno, i.e.
> > 
> > #define jiffies get_jiffies()
> > extern unsigned get_jiffies(void);
> 
> > No, not really.  HZ still defines the units of jiffies and most all the
> > timing is still related to it.  Its just that interrupts are only "set
> > up" when a "real" time event is due.
> 
> Great HZ always defines units of jiffies, but that is worthless if there
> is not a ruleset that tells me a value to divide by to return it to a
> specific quantity of time.

Actually in rearranging it.  jiffies should probably be redefined as
the smallest sleep we are prepared to take.  And then HZ because the
number of those smallest sleeps per second.  So we might see HZ values
up in the millions but otherwise things should be pretty much as
normal.

It's an interesting question though.  How large should HZ be with
programmable timers.

Eric
