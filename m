Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVKCRXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKCRXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVKCRXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:23:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750877AbVKCRXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:23:11 -0500
Date: Thu, 3 Nov 2005 09:19:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Mel Gorman <mel@csn.ul.ie>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <309420000.1131036740@[10.10.2.4]>
Message-ID: <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au> 
 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au> 
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu> 
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu> 
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> 
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> 
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> 
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> 
 <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]>
 <1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
 <Pine.LNX.4.58.0511031613560.3571@skynet> <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
 <309420000.1131036740@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Martin J. Bligh wrote:
> 
> The problem is how these zones get resized. Can we hotplug memory between 
> them, with some sparsemem like indirection layer?

I think you should be able to add them. You can remove them. But you can't 
resize them.

And I suspect that by default, there should be zero of them. Ie you'd have 
to set them up the same way you now set up a hugetlb area.

		Linus
