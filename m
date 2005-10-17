Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVJQTrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVJQTrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJQTrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:47:55 -0400
Received: from serv01.siteground.net ([70.85.91.68]:54430 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751306AbVJQTry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:47:54 -0400
Date: Mon, 17 Oct 2005 12:47:43 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       discuss@x86-64.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com, muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017194743.GA8932@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <20051017184523.GB26239@granada.merseine.nu> <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org> <200510172109.54066.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510172109.54066.ak@suse.de>
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

On Mon, Oct 17, 2005 at 09:09:52PM +0200, Andi Kleen wrote:
> On Monday 17 October 2005 21:04, Linus Torvalds wrote:
> 
> > So the only thing that worried me (and made me ask whether there might be
> > machines where it doesn't work) is if some machines might have their high
> > memory (or no memory at all) on NODE(0). It does sound unlikely, but I
> > simple don't know what kind of strange NUMA configs there are out there.
> 
> It could happen in VirtualIron (they seem to interleave node 0 over many nodes 
> to get equal use of lowmem in 32bit NUMA), but should not in x86-64..
>  
> > And I'm definitely only interested in machines that are out there, not
> > some theoretical issues.
> 
> According to Alex W. it will break their sx1000 IA64 boxen.

sx1000 is probably already broken;  Unless the last pgdat happens to be the
memory only node with 0-4G?  How about the fix I suggested which would iterate 
across all nodes until it found the right node for swiotlb?

Thanks,
Kiran
