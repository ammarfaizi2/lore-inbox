Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262252AbSJARKk>; Tue, 1 Oct 2002 13:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbSJARK0>; Tue, 1 Oct 2002 13:10:26 -0400
Received: from bitmover.com ([192.132.92.2]:31171 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262252AbSJARKP>;
	Tue, 1 Oct 2002 13:10:15 -0400
Date: Tue, 1 Oct 2002 10:15:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
Message-ID: <20021001101539.F5595@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@digeo.com>,
	Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <E17wNeG-0005th-00@starship> <Pine.LNX.4.44L.0210011348060.653-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0210011348060.653-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 01, 2002 at 01:52:25PM -0300
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 01:52:25PM -0300, Rik van Riel wrote:
> On Tue, 1 Oct 2002, Daniel Phillips wrote:
> > On Monday 30 September 2002 07:57, Andrew Morton wrote:
> > > I'll take a look at some preferential throttling later on.  But
> > > I must say that I'm not hugely worried about performance regression
> > > under wild swapstorms.  The correct fix is to go buy some more
> > > RAM, and the kernel should not be trying to cater for underprovisioned
> > > machines if that affects the usual case.
> >
> > The operative phrase here is "if that affects the usual case".
> > Actually, the quicksort bench is not that bad a model of a usual case,
> > i.e., a working set 50% bigger than RAM.
> 
> Having the working set of one process larger than RAM is
> a highly unusual case ...

"bk -r check -acv" on the linux-2.5 tree shows up as 39MB RSS in top and is
actually much bigger, it wants all of the SCCS files in ram to go fast. 
If they are, it's about 15 seconds on a Ghz box, if they aren't, it's 
mucho longer.  I _think_ we're careful to not go back and look at the
same files twice but I might be smoking crack.   All I know is that 
running a check on a 128MB machine is painful as hell.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
