Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTBUPJQ>; Fri, 21 Feb 2003 10:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTBUPJQ>; Fri, 21 Feb 2003 10:09:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17160 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267496AbTBUPJN>; Fri, 21 Feb 2003 10:09:13 -0500
Date: Fri, 21 Feb 2003 10:15:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
In-Reply-To: <20030220093422.GA16369@wotan.suse.de>
Message-ID: <Pine.LNX.3.96.1030221095706.21493E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Andi Kleen wrote:

> On Thu, Feb 20, 2003 at 01:20:43AM -0800, Simon Kirby wrote:
> > On Thu, Feb 20, 2003 at 08:52:46AM +0100, Andi Kleen wrote:
> > 
> > > That's probably because of the lazy ICMP socket locking used for the
> > > ICMP socket. When an ICMP is already in process the next ICMP triggered
> > > from a softirq (e.g. ECHO-REQUEST) is dropped  
> > > (see net/ipv4/icmp_xmit_lock_bh())
> > 
> > Hmm...and this is considered desired behavior?  It seems like an odd way
> > of handling packets intended to test latency and reliability. :)
> 
> IP is best-effort. Dropping packets in odd cases to make locking simpler
> is not unreasonable. Would you prefer an slower kernel?

  Software is not a zero sum exercise. Therefore "fast" and "correct" are
not mutually exclusive.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

