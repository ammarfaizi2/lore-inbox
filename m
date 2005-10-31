Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVJaBkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJaBkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJaBkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:40:07 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:59304 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751275AbVJaBkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:40:05 -0500
Date: Sun, 30 Oct 2005 20:40:03 -0500
From: Bob Picco <bob.picco@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Bob Picco <bob.picco@hp.com>, Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       matthew.e.tolentino@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Message-ID: <20051031014003.GE6019@localhost.localdomain>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <1130607017.12551.5.camel@localhost> <20051031001727.GC6019@localhost.localdomain> <200510310312.18395.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310312.18395.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added Matt to cc:
Andi Kleen wrote:	[Sun Oct 30 2005, 09:12:17PM EST]
> On Monday 31 October 2005 01:17, Bob Picco wrote:
> 
> > This is a slightly modified patch I used on x86_64 for EXTREME testing. The
> > original 2.6.13-rc1-mhp1 patch didn't apply cleanly against 2.6.14. It will
> > apply with this untested patch.  The patch needs to have arch_sparse_init
> > which is only active for SPARSEMEM. This patch was just for testing EXTREME
> > on x86_64 NUMA and needs review.
> >
> > I think the bootmem allocator is being used before initialized.  This
> > wouldn't have happened before SPARSEMEM_EXTREME became the default.
> >
> > If you feel my analysis is correct, I'll generate a cleaner patch and
> > test on my 4 way.
> 
> Ok the question is - why did nobody submit this patch in time? When
> sparse was merged I assumed folks would actually test and maintain
> it. But that doesn't seem to be the case? Somewhat surprising.
Well I did post it on lhms mailing list.  However it's incomplete because
it doesn't address !NUMA. I used it specifically for looking at performance
regression as a result of SPARSEMEM_EXTREME which we were analyzing at that
time. It wasn't intended for inclusion.  Also EXTREME came later in the
initial SPARSEMEM submission to address very sparse arch platforms. So I think 
it slipped by us; at least me.
> 
> I personally don't care much about sparsemem right now because it doesn't have 
> any advantage and if it's unmaintained would consider to mark it 
> CONFIG_BROKEN. That's simply because we can't have highly experimental 
> CONFIGs in a production kernel that unsuspecting users can just set and break 
> their configuration.
> 
> Dave, is there someone in charge for sparsemem on x86-64?  
Well I think Matt (matthew.e.tolentino@intel.com) is maintaining but could be 
wrong. I'll pick it up should Matt not have the time or no other volunteer 
come forward.
> 
> -Andi
bob
