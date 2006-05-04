Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWEDTU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWEDTU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWEDTU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:20:57 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49027 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030297AbWEDTU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:20:56 -0400
Date: Thu, 4 May 2006 21:25:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bob Picco <bob.picco@hp.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060504192528.GA26759@elte.hu>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504154652.GA4530@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bob Picco <bob.picco@hp.com> wrote:

> Dave Hansen wrote:	[Thu May 04 2006, 11:21:06AM EDT]
> > I haven't thought through it completely, but these two lines worry me:
> > 
> > > + start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
> > > + end = start + pgdat->node_spanned_pages;
> > 
> > Should the "end" be based off of the original "start", or the aligned
> > "start"?
>
> Yes. I failed to quilt refresh before sending. You mean end should be 
> end = pgdat->node_start_pfn + pgdat->node_spanned_pages before 
> rounding up.

do you have an updated patch i should try?

	Ingo
