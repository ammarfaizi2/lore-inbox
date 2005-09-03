Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbVICHHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbVICHHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 03:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbVICHHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 03:07:11 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:9821 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1161174AbVICHHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 03:07:09 -0400
Date: Sat, 3 Sep 2005 00:06:39 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050903070639.GC4593@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <p73fysnqiej.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fysnqiej.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 11:17:08PM +0200, Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > 
> > Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
> > the technical reasons for merging gfs[2], ocfs2, both or neither?

clusterfilesystems are very common, there are companies that had/have a
whole business around it, veritas, polyserve, ex-sistina, thus now
redhat, ibm, tons of companies out there sell this, big bucks. as
someone said, it's different than nfs because for certian things there
is less overhead  but there are many other reasons, it makes it a lot
easier to create a clustered nfs server so you create a cfs on a set of
disks with a number of nodes and export that fs from all those, you can
easily do loadbalancing for applications, you have a lot of
infrastructure where people have invested in that allows for shared
storage...   

for ocfs we have tons of production customers running many terabyte
databases on a cfs. why ? because dealing with the raw disk froma number
of nodes sucks. because nfs is pretty broken for a lot of stuff, there
is no consistency across nodes when each machine nfs mounts a server
partition. yes nfs can be used for things but cfs's are very useful for
many things nfs just can't do. want a list ? 

companies building failover for services like to use things like this,
it creates a non single point of failure kind of setup much more easily.
andso on and so on, yes there are alternatives out there but fact is
that a lot of folks like to use it, have been using it for ages, and
want to be using it.

from an implementation point of view, as folks here have already said,
we 've tried our best to implement things as a real linux filesystem, no
abstractions to have something generic, it's clean and as tight as can
be for a lot of stuff. and compared to other cfs's it's pretty darned
nice, however I think it's silly to have competition between ocfs2 and
gfs2. they are different just like the ton of local filesystems are
different and people like to use one or/over the other. david said gfs
is popular and has been around, well, I can list you tons of folks that
have been using our stuff 24/7 for years (for free) just as well. it's
different. that's that. 

it'd be really nice if mainline kernel had it/them included. it would be
a good start to get more folks involved and instead of years of talk on
maillists that end up in nothing actually end up with folks
participating and contributing. 
