Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVKCWke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVKCWke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVKCWke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:40:34 -0500
Received: from dvhart.com ([64.146.134.43]:21935 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932584AbVKCWke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:40:34 -0500
Date: Thu, 03 Nov 2005 14:40:30 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <44190000.1131057630@flay>
In-Reply-To: <Pine.LNX.4.64.0511031133040.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au><Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu><1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu><1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu><1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu><436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost><43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]><4369824E.2020407@yahoo.com.au><1131040786.2839.18.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511031006550.27915@g5.osdl.org><312300000.1131041824@[10.10.2.4]> <Pine.LNX.4.64.0511031029090.27915@g5.osdl.org><314480000.1131043874@[10.10.2.4]> <Pine.LNX.4.64.0511031133040.27915@g5.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, November 03, 2005 11:35:28 -0800 Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 3 Nov 2005, Martin J. Bligh wrote:
>> 
>> Possibly, I can redo the calculations easily enough (have to go for now,
>> but I just sent the other ones). But we don't keep a fixed percentage of
>> memory free - we cap it ... perhaps we should though?
> 
> I suspect the capping may well be from some old HIGHMEM interaction on x86 
> (ie "don't keep half a gig free in the normal zone just because we have 
> 16GB in the high-zone". We used to have serious balancing issues, and I 
> wouldn't be surprised at all if there are remnants from that. Stuff that 
> simply hasn't been visible, because not a lot of people had many many GB 
> of memory even on machines that didn't need HIGHMEM.

But pages_min is based on the zone size, not the system size. And we
still cap it. Maybe that's just a mistake?

M.

