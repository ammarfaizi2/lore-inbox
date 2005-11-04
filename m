Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbVKDBHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbVKDBHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbVKDBHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:07:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161079AbVKDBHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:07:34 -0500
Date: Thu, 3 Nov 2005 17:06:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>, Mel Gorman <mel@csn.ul.ie>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <436AB241.2030403@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu>
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu>
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu>
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost>
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]>
 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
 <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
 <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
 <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
 <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.1!
 0.2.4]> <436AB241.2030403@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Nick Piggin wrote:
> 
> Looks like ppc64 is getting 64K page support, at which point higher
> order allocations (eg. for stacks) basically disappear don't they?

Yes and no, HOWEVER, nobody sane will ever use 64kB pages on a 
general-purpose machine.

64kB pages are _only_ usable for databases, nothing else.

Why? Do the math. Try to cache the whole kernel source tree in 4kB pages 
vs 64kB pages. See how the memory usage goes up by a factor of _four_.

		Linus
