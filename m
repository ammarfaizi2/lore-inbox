Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUHGTVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUHGTVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUHGTVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:21:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21665 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264251AbUHGTVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:21:07 -0400
Date: Sat, 7 Aug 2004 15:31:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040807183121.GA26492@logos.cnet>
References: <20040805225549.GA18420@logos.cnet> <Pine.LNX.4.44.0408070828240.7317-100000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408070828240.7317-100000@nacho.alt.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 09:00:30AM -0700, Chris Caputo wrote:
> On Thu, 5 Aug 2004, Marcelo Tosatti wrote:
> > On Wed, Aug 04, 2004 at 02:55:38PM -0700, Chris Caputo wrote:
> > > Right now the 3 tests I have running are:
> > > 
> > >  Intel SDS2 mb / dual-PIII / 3ware / 2.4.26 / irqbalance --oneshot
> > >  Intel SDS2 mb / dual-PIII / 3ware / 2.4.27-rc5 / irqbalance ongoing
> > >  Intel STL2 mb / dual-PIII / DAC960 / 2.4.26 / irqbalance ongoing
> 
> Well, I ended up getting the same crash (report below) with the non-3ware
> (STL2 based) server, so I think I can rule the 3ware driver out as being
> an instigator.  The STL2 based server took 2 days 14.5 hours to get a
> corrupted inode_unused list.
> 
> This makes the list of motherboards I have seen the problem on be:
> 
>    Intel SE7501HG2 with dual-PIV's, 4 gig of ram
>    Intel SDS2 with dual-PIII's, 4 gig of ram
>    Intel STL2 with dual-PIII's, 2 gig of ram
> 
> At present the 2.4.26 with oneshot irqbalance and the 2.4.27-rc5 with
> normal irqbalance are continuing to run without problems.  Coming up on 3
> days without issues...  I'll keep them running.
> 
> Also, I'll start running 2.4.27-rc5 on a second server (the STL2) with a
> normal irqbalance.
> 
> > Hum perhaps CONFIG_DEBUG_STACKOVERFLOW? And CONFIG_DEBUG_SLAB? 
> > 
> > I recall you said you had CONFIG_DEBUG_SLAB set already?
> 
> I have been running kernels with both DEBUG_SLAB and DEBUG_STACKOVERFLOW
> set.
> 
> Marcelo, I take it the 8-proc server is still running fine?

Yes, its fine.

> Anyone else out there got a spare P3 or P4 dual-proc machine they can have
> run the following repro scenario with 2.4.26 for a week?

I have Dual P4 SE7501 here. I'll start the tests now with v2.4.26 plus your
corruption patches.
