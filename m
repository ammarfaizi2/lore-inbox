Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311687AbSCNRS5>; Thu, 14 Mar 2002 12:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311688AbSCNRSs>; Thu, 14 Mar 2002 12:18:48 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17930 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311687AbSCNRSe>; Thu, 14 Mar 2002 12:18:34 -0500
Date: Thu, 14 Mar 2002 12:16:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@suse.de>
cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314171300.H19636@suse.de>
Message-ID: <Pine.LNX.3.96.1020314121029.9630B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Dave Jones wrote:

> On Thu, Mar 14, 2002 at 10:53:01AM -0500, Bill Davidsen wrote:
  
>  It's not a matter of codesize, it's a correctness issue in the source.
>  #ifndef CONFIG_M686 is wrong. It assumes a P6 is the only CPU family
>  in existence without the bug, despite the fact there are probably close
>  to a dozen others.

  No problem with that, it obviously should be done for all chips which
could have the bug, both Intel and faithful clones :-(
 
>  > that many people would set it off not knowing was it was much less whether
>  > they needed it. This is not like a missing FPU where you can do a graceful
>  > reject of the instructions, if you have the bug and not the fix you are
>  > vulnerable to sudden total failures, correct?
> 
>  No. You at worse vulnerable to a malicious user running hand-crafted code
>  (no compiler generates this code-sequence) bringing down the machine.

  Having the machine lock suddenly when user mode code is executed fits MY
definition of sudden total failure! Malicious user meaning anyone who d/l
something and runs it. Doesn't take malicious, just dumb. Somone wanting
to try the new screen saver or some such.
 
>  The proposal however was not to remove anything that we currently have.
>  Every kernel that is possible to be run on an affected box (i386/i486/i586)
>  would still have the workaround present. We just won't generate it in
>  Cyrix III, Athlon, Pentium 4, etc kernels..

  As long as it's not something the user can easily set wrong. If they
build a kernel for K6 and they have a P-II "stupidity, like virtue, is its
own reward."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

