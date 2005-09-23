Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVIWSsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVIWSsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVIWSsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:48:32 -0400
Received: from serv01.siteground.net ([70.85.91.68]:36266 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751129AbVIWSsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:48:31 -0400
Date: Fri, 23 Sep 2005 11:48:20 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
Message-ID: <20050923184820.GB4103@localhost.localdomain>
References: <20050923062529.GA4209@localhost.localdomain> <20050923001013.28b7f032.akpm@osdl.org> <20050923.001729.101033164.davem@davemloft.net> <1127463090.796.7.camel@localhost.localdomain> <20050923113636.GB5006@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923113636.GB5006@in.ibm.com>
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

On Fri, Sep 23, 2005 at 05:06:36PM +0530, Dipankar Sarma wrote:
> On Fri, Sep 23, 2005 at 06:11:30PM +1000, Rusty Russell wrote:
> > On Fri, 2005-09-23 at 00:17 -0700, David S. Miller wrote:
> > Now, that said, I wanted (and wrote, way back when) a far simpler
> > allocator which only worked for GFP_KERNEL and used the same
> > __per_cpu_offset[] to fixup dynamic per-cpu ptrs as static ones.  Maybe
> > not as "complete" as this one, but maybe less offensive.
> 
> The GFP_ATOMIC support stuff is needed only for dst entries. However
> using per-cpu refcounters in such objects like dentries and dst entries
> are problematic and that is why I hadn't tried changing those.
> Some of the earlier versions of the allocator were simpler and I think
> we need to roll this back and do some more analysis. No GFP_ATOMIC
> support, no early use. I haven't got around to look at this 

The patches I have submitted this time does not have GFP_ATOMIC support. The
early use enablement stuff are in seperate patches  (patch 5 and 6).  The
patchset would work without these two patches too.

Thanks,
Kiran
