Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265476AbUEZKmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUEZKmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265475AbUEZKmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:42:37 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:18560 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265447AbUEZKlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:41:08 -0400
Date: Wed, 26 May 2004 11:48:11 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405261048.i4QAmBgw000886@81-2-122-30.bradfords.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Roger Luethi <rl@hellgate.ch>, Anthony DiSante <orders@nodivisions.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40B4737E.3050709@yahoo.com.au>
References: <40B43B5F.8070208@nodivisions.com>
 <20040526082712.GA32326@k3.hellgate.ch>
 <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk>
 <20040526093007.GA4324@k3.hellgate.ch>
 <200405261035.i4QAZrGo000803@81-2-122-30.bradfords.org.uk>
 <40B4737E.3050709@yahoo.com.au>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> John Bradford wrote:
> > Quote from Roger Luethi <rl@hellgate.ch>:
> > 
> >>On Wed, 26 May 2004 10:23:32 +0100, John Bradford wrote:
> >>
> >>>A run-away process on a server with too much swap can cause it to grind to
> >>>almost a complete halt, and become almost compltely unresponsive to remote
> >>>connections.
> >>>
> >>>If the total amount of storage is just enough for the tasks the server is
> >>>expected to deal with, then a run-away process will likely be terminated
> >>>quickly stopping it from causing the machine to grind to a halt.
> >>
> >>I'm not sure your optimism about the correct (run-away) process being
> >>terminated is justified. Granted, there are definitely scenarios
> >>where swapless operation is preferable, but in most circumstances --
> >>especially workstations as the original poster described -- I'd rather
> >>minimize the risk of losing data.
> > 
> > 
> > Well, I am basing this on experience.  I know an ISP who had their main
> > customer webserver down for hours because of this kind of problem - the whole
> > thing created a lot of work and wasted a lot of time.
> > 
> > In this particular scenario, I think the run-away process was probably using
> > up almost two thirds of the total RAM, so I'm pretty confident the correct
> > process would have been terminated.
> > 
> 
> I think this is somewhat orthogonal to whether swap should be
> used or not.
> 
> What we should be doing here is enforcing the RSS rlimit. I
> have a patch from Rik to do this which needs to be merged.
> 
> Hopefully this would give you the best case situation of
> having only the runaway process really slow down, without
> killing anything until the admin arrives.

Ideally, yes - by the way, this was some time ago, (I think the machine was
running a 2.2 kernel).

John.
