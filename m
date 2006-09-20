Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751992AbWITRMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWITRMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWITRMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:12:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54243 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751992AbWITRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:12:37 -0400
Date: Wed, 20 Sep 2006 10:12:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <20060920170735.GB22913@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609201008160.30793@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <20060920164404.GA22913@wotan.suse.de> <Pine.LNX.4.64.0609200944420.30793@schroedinger.engr.sgi.com>
 <20060920170735.GB22913@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Nick Piggin wrote:

> Look at what the patches do. These are not only for hard partitioning
> of memory per container but also those that share memory (eg. you might
> want each to share 100MB of memory, up to a max of 80MB for an individual
> container).

So far I have not been able to find the hooks to the VM. The sharing 
would also work with nodes. Just create a couple of nodes with the sizes you 
want and then put the node with the shared memory into the cpusets for the 
apps sharing them.

> The nodes+cpusets stuff doesn't seem to help with that because you
> with that because you fundamentally need to track pages on a per
> container basis otherwise you don't know who's got what.

Hmmm... That gets into issues of knowing how many pages are in use by an 
application and that is fundamentally difficult to do due to pages being 
shared between processes.

> Now if, in practice, it turns out that nobody really needed these
> features then of course I would prefer the cpuset+nodes approach. My
> point is that I am not in a position to know who wants what, so I
> hope people will come out and discuss some of these issues.

I'd really be interested to have proper tracking of memory use for 
processes but I am not sure what use the containers would be there.

