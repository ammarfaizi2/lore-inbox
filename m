Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbUCPRSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUCPRSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:18:08 -0500
Received: from mail.cyclades.com ([64.186.161.6]:28891 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264132AbUCPRRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:17:46 -0500
Date: Tue, 16 Mar 2004 13:59:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, <j-nomura@ce.jp.nec.com>,
       <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040316134756.GW30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403161356030.11875-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Mar 2004, Andrea Arcangeli wrote:

> On Tue, Mar 16, 2004 at 03:31:33AM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Sun, 14 Mar 2004, Andrew Morton wrote:
> > 
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > > 
> > > > > Having a magic knob is a weak solution: the majority of people who are
> > > > > affected by this problem won't know to turn it on.
> > > > 
> > > > that's why I turned it _on_ by default in my tree ;)
> > > 
> > > So maybe Marcelo should apply this patch, and also turn it on by default.
> > 
> > Hhhmm, not so easy I guess. What about the added overhead of 
> > lru_cache_add() for every anonymous page created? 
> > 
> > I bet this will cause problems for users which are happy with the current 
> > behaviour. Wont it?
> 
> the lru_cache_add is happening in 2.4 mainline, the only point of the
> patch is to _avoid_ calling lru_cache_add (tunable with a sysctl so you
> can get to the old behaviour of calling lru_cache_add for every anon
> page).

Uh oh, just ignore me. 

I misread the message, and misunderstood the whole thing. Will go reread
the patch, and the code.

> > Andrea, do you have any numbers (or at least estimates) for the added
> > overhead of instantly addition of anon pages to the LRU? That would be
> > cool to know.2A2A2A
> 
> I've the numbers for the removed overhead, that's significant in some
> workload, but only in the >=16-ways.

And for those workloads one should turn be able to turn it off - right.

> > Obviously we dont have, and dont want to, such things in 2.4.
> 
> agreed ;)
> 
> > Anyway, it seems this discussion is being productive. Glad!
> 
> yep!
> 

