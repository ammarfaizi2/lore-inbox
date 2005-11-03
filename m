Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVKCQwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVKCQwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKCQwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:52:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030383AbVKCQwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:52:37 -0500
Date: Thu, 3 Nov 2005 08:46:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
cc: Arjan van de Ven <arjan@infradead.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.58.0511031613560.3571@skynet>
Message-ID: <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost>
 <20051101142959.GA9272@elte.hu>  <1130856555.14475.77.camel@localhost>
 <20051101150142.GA10636@elte.hu>  <1130858580.14475.98.camel@localhost>
 <20051102084946.GA3930@elte.hu>  <436880B8.1050207@yahoo.com.au>
 <1130923969.15627.11.camel@localhost>  <43688B74.20002@yahoo.com.au>
 <255360000.1130943722@[10.10.2.4]>  <4369824E.2020407@yahoo.com.au> 
 <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org> <Pine.LNX.4.58.0511031613560.3571@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Mel Gorman wrote:

> On Thu, 3 Nov 2005, Linus Torvalds wrote:
> 
> > This is why fragmentation avoidance has always been totally useless. It is
> >  - only useful for big areas
> >  - very hard for big areas
> >
> > (Corollary: when it's easy and possible, it's not useful).
> >
> 
> Unless you are a user that wants a large area when it suddenly is useful.

No. It's _not_ suddenly useful.

It might be something you _want_, but that's a totally different issue.

My point is that regardless of what you _want_, defragmentation is 
_useless_. It's useless simply because for big areas it is so expensive as 
to be impractical.

Put another way: you may _want_ the moon to be made of cheese, but a moon 
made out of cheese is _useless_ because it is impractical.

The only way to support big areas is to have special zones for them.

(Then, we may be able to use the special zones for small things too, but 
under special rules, like "only used for anonymous mappings" where we 
can just always remove them by paging them out. But it would still be a 
special area meant for big pages, just temporarily "on loan").

			Linus
