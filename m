Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754756AbWKITJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbWKITJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbWKITJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:09:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754756AbWKITJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:09:51 -0500
Date: Thu, 9 Nov 2006 13:58:29 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
In-Reply-To: <20061109091554.GB23876@elte.hu>
Message-ID: <Pine.LNX.4.64.0611091354060.17915@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
 <20061106200529.GA15370@elte.hu> <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
 <20061107235342.GA5496@elte.hu> <Pine.LNX.4.64.0611081254150.18340@dhcp83-20.boston.redhat.com>
 <20061109091554.GB23876@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Nov 2006, Ingo Molnar wrote:

> 
> * Jason Baron <jbaron@redhat.com> wrote:
> 
> > You are right though, i think that the data in the locks after lists 
> > is sufficient to re-create the entire graph, since its acyclic, but by 
> > simply printing out nodes of distance '1', the algorithm is greatly 
> > simplified. Otherwise, i'd have to first reconstruct the graph...
> 
> but ... the locks_after list should really only include locks that are 
> taken immediately after. I.e. there should only be 'distance 1' locks.
> 

hmmm...that's not how i read the lockdep code...and the little piece of 
code that i added to add a distance measurement to links, found mostly 
distance 1 links but there were a number of 2 and 3 links as well (i don't 
think i saw any greater than 3).

thanks.

-Jason
