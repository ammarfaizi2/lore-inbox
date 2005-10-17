Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVJQPa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVJQPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVJQPa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:30:26 -0400
Received: from serv01.siteground.net ([70.85.91.68]:46475 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751371AbVJQPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:30:26 -0400
Date: Mon, 17 Oct 2005 08:30:20 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, torvalds@osdl.org,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017153020.GB7652@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <20051017025007.35ae8d0e.akpm@osdl.org> <200510171153.56063.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510171153.56063.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 11:53:54AM +0200, Andi Kleen wrote:
> On Monday 17 October 2005 11:50, Andrew Morton wrote:
> 
> >
> > This is an ia64 patch - what point was there in testing it on an x460?
> >
> > Is something missing here?
> 
> x86-64 shares that code with ia64.
> 
> The patch is actually not quite correct - in theory node 0 could be too small 
> to contain the full swiotlb bounce buffers.

Good point. I missed that possibility. 

> 
> The real fix would be to get rid of the pgdata lists and just walk the 
> node_online_map on bootmem.c. The memory hotplug guys have
> a patch pending for this.

Yes, I just saw Yasunori-san's patch.  Would that be merged for 2.6.14?
'Cause 2.6.14 is broken as of now for x86_64 boxes with more than 4G ram.

Thanks,
Kiran
