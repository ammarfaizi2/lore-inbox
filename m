Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSFJVKn>; Mon, 10 Jun 2002 17:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFJVKm>; Mon, 10 Jun 2002 17:10:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35845 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316258AbSFJVKk>; Mon, 10 Jun 2002 17:10:40 -0400
Date: Mon, 10 Jun 2002 17:05:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rick Bressler <rickb@mushroom.ca.boeing.com>
cc: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [PATCH] scheduler hints
In-Reply-To: <200206060046.g560kJi04034@mushroom.ca.boeing.com>
Message-ID: <Pine.LNX.3.96.1020610165913.23851B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Rick Bressler wrote:

> > So I went ahead and implemented scheduler hints on top of the O(1)
> > scheduler. 
> 
> > Other hints could be "I am interactive" or "I am a batch (i.e. cpu hog)
> > task" or "I am cache hot: try to keep me on this CPU". 
> 
> Sequent had an interesting hint they cooked up with Oracle. (Or maybe it
> was the other way around.)  As I recall they called it 'twotask.'
> Essentially Oracle clients processes spend a lot of time exchanging
> information with its server process. It usually makes sense to bind them
> to the same CPU in an SMP (and especially NUMA) machine.  (Probably
> obvious to most of the folks on the group, but it is generally lots
> better to essentially communicate through the cache and local memory
> than across the NUMA bus.)

Are you really saying that you think serializing all the clients through a
single processor will gain more than than you lose by not using all the
other CPUs for clients?
 
> As I recall it made a significant difference in Oracle performance, and
> would probably also translate to similar performance in many situations
> where you had a client and server process doing lots of interaction in
> an SMP environment.

I've certainly seen a "significant difference" between uni and SMP, but it
was always in the other direction. Is this particular to some hardware, or
running multiple servers somehow? I'm only fmailiar with Linux, AIX and
Solaris, maybe this is Sequent magic? Or were you talking about having
only one client total on the machine and just making that run fast?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

