Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312512AbSCUVf6>; Thu, 21 Mar 2002 16:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312511AbSCUVfi>; Thu, 21 Mar 2002 16:35:38 -0500
Received: from zero.tech9.net ([209.61.188.187]:8978 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312510AbSCUVf2>;
	Thu, 21 Mar 2002 16:35:28 -0500
Subject: Re: [PATCH] 2.5.7 acct.c oops
From: Robert Love <rml@tech9.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Bob Miller <rem@osdl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020321162155.18421A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 21 Mar 2002 16:34:49 -0500
Message-Id: <1016746490.5659.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-21 at 16:26, Bill Davidsen wrote:

>   Please help my education... after looking at the code, I don't see why
> the BUG_ON was removed rather than made dependent on SMP, assuming that
> the BK comment and my hasty reading of code actually mean that it did work
> for SMP.
> 
>   Is this a solid "can't happen" now and no test needed, or is a better
> test in the works, or ???
> 
>   I didn't try to compile it, so there may be something I'm totally
> missing.

While he could of wrapped the test dependent in #ifdef/#endif
CONFIG_SMP, the test really is not overly needed.  It is more a result
of the previous code, which Bob Miller himself fixed up and then much
rewrote the locking for.

Since he recently did the cleanup (and even added that BUG_ON) I trust
he knows if we can remove it.

	Robert Love

