Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVJaCq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVJaCq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJaCq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:46:58 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:4044 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751284AbVJaCq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:46:57 -0500
Date: Sun, 30 Oct 2005 21:46:48 -0500
From: Bob Picco <bob.picco@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Bob Picco <bob.picco@hp.com>, Dave Hansen <haveblue@us.ibm.com>,
       Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>,
       matthew.e.tolentino@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Message-ID: <20051031024648.GF6019@localhost.localdomain>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <200510310312.18395.ak@suse.de> <20051031014003.GE6019@localhost.localdomain> <200510310428.50201.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310428.50201.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:	[Sun Oct 30 2005, 10:28:49PM EST]
> On Monday 31 October 2005 02:40, Bob Picco wrote:
> > Added Matt to cc:
> > Andi Kleen wrote:	[Sun Oct 30 2005, 09:12:17PM EST]
> >
> > > On Monday 31 October 2005 01:17, Bob Picco wrote:
> > > > This is a slightly modified patch I used on x86_64 for EXTREME testing.
> > > > The original 2.6.13-rc1-mhp1 patch didn't apply cleanly against 2.6.14.
> > > > It will apply with this untested patch.  The patch needs to have
> > > > arch_sparse_init which is only active for SPARSEMEM. This patch was
> > > > just for testing EXTREME on x86_64 NUMA and needs review.
> > > >
> > > > I think the bootmem allocator is being used before initialized.  This
> > > > wouldn't have happened before SPARSEMEM_EXTREME became the default.
> > > >
> > > > If you feel my analysis is correct, I'll generate a cleaner patch and
> > > > test on my 4 way.
> > >
> > > Ok the question is - why did nobody submit this patch in time? When
> > > sparse was merged I assumed folks would actually test and maintain
> > > it. But that doesn't seem to be the case? Somewhat surprising.
> >
> > Well I did post it on lhms mailing list. 
> 
> Fixes for code that is in mainline needs to go to the appropiate mainline 
> mailing list (for x86-64 that is l-k and discuss@x86-64.org) and maintainers.
Well it wasn't intended for inclusion. I was just trying to help Dave out by
not pursuing an issue which I've already looked at some.
> 
> > However it's incomplete because 
> > it doesn't address !NUMA. 
> 
> So i should not apply it yet?
Nope. It's incomplete. I'll wait to see whether Matt is on this.  Otherwise,
I'll put a patch together and test it within the next couple of days.
> 
> -Andi
> 
bob
