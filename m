Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSGWW1z>; Tue, 23 Jul 2002 18:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSGWW1y>; Tue, 23 Jul 2002 18:27:54 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53258 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318229AbSGWW1y>; Tue, 23 Jul 2002 18:27:54 -0400
Date: Tue, 23 Jul 2002 18:25:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: venom@sns.it, Robert Sinko <RSinko@island.com>,
       "'Hubbard, Dwight'" <DHubbard@midamerican.com>, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count
In-Reply-To: <Pine.LNX.3.95.1020719082245.159A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020723182031.2194F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Richard B. Johnson wrote:

> On Fri, 19 Jul 2002 venom@sns.it wrote:
> 
> > 
> > yes, as bios option.
> > 
> > On my point of view it would be interesting to verify is hyperthreading is
> > really usefull or not.
> > 
> 
> It would be interesting to determine if "hyperthreading" in the CPU 
> actually exists. It may just be an artifact of dual instruction units,
> actually a defect (perhaps harmless), that is hyped as a feature.

Clearly not, it requires another set of registers including instruction
counter.
 
> For instance, it has long been known that if a CPU were to have as
> many instruction units as possible instruction branches, program
> jumps upon logical conditions would not slow the machine down. The
> hardware just continues using the instruction unit that contains the
> correct program-flow while the others are re-loaded.

That is not correct, it certainly can slow the machine down. Speculative
execution is used, but it's not free, since it requires fetching
instructions not used through a limited bandwidth to memory. Much on this
in comp.arch, there is a tradeoff between avoiding stalls and causing
them, separate branch target cache, etc. Details probably a lot better to
be discussed there. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

