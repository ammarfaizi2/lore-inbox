Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312715AbSCVP2Q>; Fri, 22 Mar 2002 10:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312712AbSCVP2I>; Fri, 22 Mar 2002 10:28:08 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46605 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312715AbSCVP17>; Fri, 22 Mar 2002 10:27:59 -0500
Date: Fri, 22 Mar 2002 10:25:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Bob Miller <rem@osdl.org>
cc: Robert Love <rml@tech9.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 acct.c oops
In-Reply-To: <20020321140024.B1543@doc.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1020322101526.22096A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Bob Miller wrote:

> On Thu, Mar 21, 2002 at 04:34:49PM -0500, Robert Love wrote:

> > While he could of wrapped the test dependent in #ifdef/#endif
> > CONFIG_SMP, the test really is not overly needed.  It is more a result
> > of the previous code, which Bob Miller himself fixed up and then much
> > rewrote the locking for.
> > 
> > Since he recently did the cleanup (and even added that BUG_ON) I trust
> > he knows if we can remove it.
> > 
> > 	Robert Love
> 
> As Robert has sermized...  When I did the cleanup I debated whether to put
> the BUG_ON() in there in the first place.  I used it as an extra bit of
> paranoia not knowing that it would not return correct results on a UP.

  Okay, that's a reasonable decision. I'm all in favor of paranoia, any
problem at this point would be best detected early on, nut if you're
convinced that it's safe without it, I certainly can't argue, and wasn't
intending to initially.

  Actually I don't think CONFIG_SMP would completely avoid problems, if I
read the code right it would still have a problem if you had an SMP kernel
running "nosmp"  option at boot (or possibly booted on a uni, although I
haven't tried w/o 'nosmp'). 

  Thanks for all the information, clearly if any check is needed, that
check is not the one, at least as is.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

