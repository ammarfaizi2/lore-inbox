Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUD3Tcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUD3Tcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbUD3Tcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:32:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24764 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265232AbUD3TcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:32:11 -0400
Date: Fri, 30 Apr 2004 15:31:55 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
In-Reply-To: <4092A636.7050304@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0404301527400.6976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Shailabh Nagar wrote:
> Rik van Riel wrote:

> > User Mode Linux could definitely be an option for implementing
> > resource management, provided that the overhead can be kept
> > low enough.
> 
> ....and provided the groups of processes that are sought to be 
> regulated as a unit are relatively static.

Good point, I hadn't thought of that one.

It works for most of the workloads I had in mind, but
you're right that it's not good enough for eg. the
university shell server.

> > For these purposes, "low enough" could be as much as 30%
> > overhead, since that would still allow people to grow the
> > utilisation of their server from a typical 10-20% to as
> > much as 40-50%.
> 
> In overhead, I presume you're including the overhead of running as 
> many uml instances as expected number of classes. Not just the 
> slowdown of applications because they're running under a uml instance 
> (instead of running native) ?
> 
> I think UML is justified more from a fault-containment point of view 
> (where overheads are a lower priority) than from a performance 
> isolation viewpoint.
> 
> In any case, a 30% overhead would send a large batch of higher-end 
> server admins running to get a stick to beat you with :-)

True enough, but from my pov the flip side is that
merging the CKRM memory resource enforcement module
has the potential of undoing lots of the performance
tuning that was done to the VM in 2.6.

That could result in bad performance even for the
people who aren't using workload management at all...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

