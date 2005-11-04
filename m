Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVKDBUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVKDBUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVKDBUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:20:18 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:62339 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932146AbVKDBUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:20:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=w981km/Wq62E27mjOjuFgIgq5A7XO8fvltS0iVDEP36j802D/8l2hmUYTb0ske2wrCJp9eJjORchsTwWB/ZXJZrra03xnlw3vfclR4hV+9VNLrFbjGLu/TE6RQcgWRL5j2i169WygGwqUvy8ssf8RkGmU066/R+BE84b0aVORbM=  ;
Message-ID: <436AB7CA.6060603@yahoo.com.au>
Date: Fri, 04 Nov 2005 12:22:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>, Mel Gorman <mel@csn.ul.ie>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366C559.5090504@yahoo.com.au> <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org> <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org> <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.1! 0.2.4]> <436AB241.2030403@yahoo.com.au> <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 4 Nov 2005, Nick Piggin wrote:
> 
>>Looks like ppc64 is getting 64K page support, at which point higher
>>order allocations (eg. for stacks) basically disappear don't they?
> 
> 
> Yes and no, HOWEVER, nobody sane will ever use 64kB pages on a 
> general-purpose machine.
> 
> 64kB pages are _only_ usable for databases, nothing else.
> 
> Why? Do the math. Try to cache the whole kernel source tree in 4kB pages 
> vs 64kB pages. See how the memory usage goes up by a factor of _four_.
> 

Yeah that's true. But Martin's worried about future machines
with massive memories - so maybe it is safe to assume those will
be using big pages, I don't know.

Maybe the solution is to bloat the kernel sources enough to make
64KB pages worthwhile?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
