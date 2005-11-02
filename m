Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbVKBKyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbVKBKyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVKBKyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:54:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:20642 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751572AbVKBKyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:54:50 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
In-Reply-To: <43688B74.20002@yahoo.com.au>
References: <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>
	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>
	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>
	 <436880B8.1050207@yahoo.com.au> <1130923969.15627.11.camel@localhost>
	 <43688B74.20002@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 11:54:35 +0100
Message-Id: <1130928875.15627.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 20:48 +1100, Nick Piggin wrote:
> > So, if you have to add to NORMAL/DMA on the fly, how do you handle a
> > case where the new NORMAL/DMA ram is physically above
> > HIGHMEM/HOTPLUGGABLE?  Is there any other course than to make a zone
> > required to be able to span other zones, and be noncontiguous?  Would
> > that represent too much of a change to the current model?
> > 
> 
> Perhaps. Perhaps it wouldn't be required to get a solution that is
> "good enough" though.
> 
> But if you can reclaim your ZONE_RECLAIMABLE, then you could reclaim
> it all and expand your normal zones into it, bottom up.

That's a good point.  It would be slow, because you have to wait on page
reclaim, but it would work.  I do worry a bit that this might make
adding memory to slow of an operation to be useful for short periods,
but we'll see how it actually behaves.

-- Dave

