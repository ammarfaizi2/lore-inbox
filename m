Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTEDAyo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTEDAyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 20:54:44 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:3595 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S263487AbTEDAyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 20:54:43 -0400
Date: Sat, 3 May 2003 18:04:06 -0700
From: jw schultz <jw@pegasys.ws>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.{4,5}.x] mod_timer fix for sch_cbq.c
Message-ID: <20030504010406.GC8288@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <1051971380.2018.128.camel@lima.royalchallenge.com> <1051973612.14504.7.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051973612.14504.7.camel@rth.ninka.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 07:53:32AM -0700, David S. Miller wrote:
> On Sat, 2003-05-03 at 07:16, Vinay K Nallamothu wrote:
> > Hi,
> > 
> > sch_cbq.c: trivial {del,add}_timer to mod_timer conversions.
> 
> Vinay, I sent you email earlier today saying that you
> need to send networking patches to the networking lists
> and to the networking maintainers.
> 
> Yet, you're still shoveling these patches to lkml.
> What is the problem?
> 

This looks like a timer fix that happens to be in network
code, not a network fix.  Judging from the others he just
posted he is fixing/upgrading timer code.

He only CC'd the kernel list.  The bug was sent to
davej@codemonkey.org.uk.  You are askiing him to filter
every piddly fix to identify which group it should go to.

I sypmathize with your position but i think you are setting
up too high a barrier.  When multiple poeple repeat the same
mistake it is called a systems problem and you fix the
system.

It strikes me that a filter subscribed to lkml could examine
the postings for lines like:

--- linux-2.5.68/net/sched/sch_cbq.c    2003-03-25 10:08:36.000000000 +0530
+++ linux-2.5.68-nvk/net/sched/sch_cbq.c        2003-05-03 19:29:08.000000000 +0530

and if present recognize "this is for the network list" and
send them there if the networking list isn't already
specified as a destination.  Such functionality, once
created, could be expanded for other lists or individuals
that want it.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
