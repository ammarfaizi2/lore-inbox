Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbVKCSRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVKCSRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVKCSRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:17:16 -0500
Received: from dvhart.com ([64.146.134.43]:34990 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1030405AbVKCSRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:17:15 -0500
Date: Thu, 03 Nov 2005 10:17:12 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <312300000.1131041824@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org> <Pine.LNX.4.58.0511031613560.3571@skynet> 
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org> <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > For amusement, let me put in some tritely oversimplified math. For the
>> > sake of arguement, assume the free watermarks are 8MB or so. Let's assume
>> > a clean 64-bit system with no zone issues, etc (ie all one zone). 4K pages.
>> > I'm going to assume random distribution of free pages, which is 
>> > oversimplified, but I'm trying to demonstrate a general premise, not get
>> > accurate numbers.
>> 
>> that is VERY over simplified though, given the anti-fragmentation
>> property of buddy algorithm
> 
> Indeed. I write a program at one time doing random allocation and 
> de-allocation and looking at what the output was, and buddy is very good 
> at avoiding fragmentation.
> 
> These days we have things like per-cpu lists in front of the buddy 
> allocator that will make fragmentation somewhat higher, but it's still 
> absolutely true that the page allocation layout is _not_ random.

OK, well I'll quit torturing you with incorrect math if you'll concede
that the situation gets much much worse as memory sizes get larger ;-)

For order > 1 allocs, I think it's fixable. For order > 1, I think we
basically don't have a prayer on a largish system under pressure.

M.

