Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268224AbTCFSSG>; Thu, 6 Mar 2003 13:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268256AbTCFSSG>; Thu, 6 Mar 2003 13:18:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9996 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268224AbTCFSSF>; Thu, 6 Mar 2003 13:18:05 -0500
Date: Thu, 6 Mar 2003 10:26:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <9420000.1046974427@flay>
Message-ID: <Pine.LNX.4.44.0303061024050.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Martin J. Bligh wrote:
> 
> It would be nice if we had a "batch-job-able" simulation of this situation,
> to do more accurate testing with ... can anyone think of an easy way to
> do such a thing? "waggle a few windows around on X and see if it feels 
> better to you or not" is kind of hard to do accurate testing with.
> Of course, the simulation has to be accurate too, or it gets stupid ;-)

It should be possible to use the same approach that the other latency
testers use (ie contest&co), by just generating some specific background
load (say, different mixtures of X clients and plain compute-bound things 
like kernel compiles).

Ie measure directly exactly what we're interested in: the latency of some
general X request, under different loads.

		Linus

