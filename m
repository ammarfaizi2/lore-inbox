Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbTIXAN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTIXAN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:13:29 -0400
Received: from palrel10.hp.com ([156.153.255.245]:190 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261190AbTIXAN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:13:26 -0400
Date: Tue, 23 Sep 2003 17:13:33 -0700
From: Grant Grundler <iod00d@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030924001333.GD10490@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923185104.GA8477@cup.hp.com> <20030923115122.41b7178f.davem@redhat.com> <20030923203819.GB8477@cup.hp.com> <20030923134529.7ea79952.davem@redhat.com> <20030923223540.GA10490@cup.hp.com> <20030923163542.55fd8ed9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923163542.55fd8ed9.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 04:35:42PM -0700, David S. Miller wrote:
> On Tue, 23 Sep 2003 15:35:40 -0700
> Grant Grundler <iod00d@hp.com> wrote:
> 
> > And someone at Intel obviously agrees the newer architectures
> > should support misaligned access in SW since ever RISC chip
> > they've built (starting with i860, ~1989) does it that way.
> 
> That's a amusing coincidence since at least some people think ia64
> will end up the same way the i860 did :-)

It might. I be happy to share what I know about i860/i960 over pizza.
I worked on ATT SVR4 port to i860 in 1989/90 and things were quite
different then...

> In the past I did always advocate things the way you are right now,
> but these days I think I've been wrong the whole time and Intel on x86
> is doing the right thing.

I'm not so interested in "right" or "wrong". I'd just like to see other
arches besides x86 work well (ia64, parisc in particular) and that includes
how linux deals with unaligned accesses. If x86 is the gold standard
for "the right way", we'd be using bounce buffers for DMA to highmem
(well, PAE support would get added somehow) and 64-bit kernels wouldn't
have happened...but linux so far seems to accomodate other arches *when
reasonable*.  I'll follow Andrew Morton's comments...

> They do everything in hardware and this makes the software so much
> simpler.  Sure, there's a lot of architectually inherited complexity
> in the x86 family, but their engineering priorities mean there is so
> much other stuff you simply never have to think about as a programmer.

Yes, true.  But I think we are digressing from the original thread here...
(/me works his way around another really big rat hole :^)

thanks,
grant
