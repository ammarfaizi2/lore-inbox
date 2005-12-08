Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVLHVz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVLHVz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLHVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:55:28 -0500
Received: from serv01.siteground.net ([70.85.91.68]:23687 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751223AbVLHVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:55:28 -0500
Date: Thu, 8 Dec 2005 13:55:14 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, zach@vmware.com, shai@scalex86.org,
       nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051208215514.GE3776@localhost.localdomain>
References: <20051208194232.GC3776@localhost.localdomain> <20051208201518.GN11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208201518.GN11190@wotan.suse.de>
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

On Thu, Dec 08, 2005 at 09:15:18PM +0100, Andi Kleen wrote:
> On Thu, Dec 08, 2005 at 11:42:32AM -0800, Ravikiran G Thirumalai wrote:
> >  
> > -	.align  L1_CACHE_BYTES
> > +	/* zero the remaining page */
> > +	.fill PAGE_SIZE / 8 - GDT_ENTRIES,8,0
> > +	
> >  ENTRY(idt_table)	
> 
> Why can't the IDT not be shared with the GDT page? It should be mostly
> read only right and putting r-o data on that page should be ok, right?

Yes, you are right.  This should not have been a problem.  
Some people reported this symbol (cpu_gdt) though.  Will have to go back and
check.

Thanks,
Kiran
