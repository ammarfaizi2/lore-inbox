Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312524AbSCUWCN>; Thu, 21 Mar 2002 17:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSCUWCC>; Thu, 21 Mar 2002 17:02:02 -0500
Received: from air-2.osdl.org ([65.201.151.6]:35712 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S312524AbSCUWBp>;
	Thu, 21 Mar 2002 17:01:45 -0500
Date: Thu, 21 Mar 2002 14:00:25 -0800
From: Bob Miller <rem@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 acct.c oops
Message-ID: <20020321140024.B1543@doc.pdx.osdl.net>
In-Reply-To: <Pine.LNX.3.96.1020321162155.18421A-100000@gatekeeper.tmr.com> <1016746490.5659.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 04:34:49PM -0500, Robert Love wrote:
> On Thu, 2002-03-21 at 16:26, Bill Davidsen wrote:
> 
> >   Please help my education... after looking at the code, I don't see why
> > the BUG_ON was removed rather than made dependent on SMP, assuming that
> > the BK comment and my hasty reading of code actually mean that it did work
> > for SMP.
> > 
> >   Is this a solid "can't happen" now and no test needed, or is a better
> > test in the works, or ???
> > 
> >   I didn't try to compile it, so there may be something I'm totally
> > missing.
> 
> While he could of wrapped the test dependent in #ifdef/#endif
> CONFIG_SMP, the test really is not overly needed.  It is more a result
> of the previous code, which Bob Miller himself fixed up and then much
> rewrote the locking for.
> 
> Since he recently did the cleanup (and even added that BUG_ON) I trust
> he knows if we can remove it.
> 
> 	Robert Love

As Robert has sermized...  When I did the cleanup I debated whether to put
the BUG_ON() in there in the first place.  I used it as an extra bit of
paranoia not knowing that it would not return correct results on a UP.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
