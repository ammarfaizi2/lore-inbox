Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTDCTOW 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263494AbTDCTM7 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:12:59 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:18314 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S263493AbTDCTLD 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:11:03 -0500
Date: Thu, 3 Apr 2003 21:22:50 +0200 (CEST)
From: Stephan van Hienen <raid@a2000.nu>
To: Ross Vandegrift <ross@willow.seitz.com>
cc: "Peter L. Ashford" <ashford@sdsc.edu>,
       Jonathan Vardy <jonathan@explainerdc.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: RAID 5 performance problems
In-Reply-To: <20030403184756.GA7971@willow.seitz.com>
Message-ID: <Pine.LNX.4.53.0304032120490.3085@ddx.a2000.nu>
References: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com>
 <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
 <20030403184756.GA7971@willow.seitz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Ross Vandegrift wrote:

> > I've benchmarked RAW disk speeds with an Ultra-100 and
> > WD1200JB drives, and gotten 50MB/S from each disk, as opposed to your
> > 26MB/S (there should be almost no difference for the BB drives).
>
> Makes perfect sense - he's getting 50M/s to each channel, but it's split
> over two drives, so drive throughput is about halved.
the fasttrak-tx4 is an 4 channel controller (it is an dual ultra-100 on 1
pci board)
Jonathans WD1200BB's should be a bit faster than 30MB/sec maybe, but the
main problem is his /dev/md0...

> Absolutely correct - you should *never* run IDE RAID on a channel that
> has both a master and slave.  When one disk on an IDE channel has an
Jonathan is only using master devices, no slaves...
