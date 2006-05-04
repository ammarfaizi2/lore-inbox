Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWEDQIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWEDQIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWEDQIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:08:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:39335 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932343AbWEDQIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:08:04 -0400
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
From: Dave Hansen <haveblue@us.ibm.com>
To: Bob Picco <bob.picco@hp.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060504154652.GA4530@localhost>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de>
	 <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de>
	 <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>
	 <20060504013239.GG19859@localhost>
	 <1146756066.22503.17.camel@localhost.localdomain>
	 <20060504154652.GA4530@localhost>
Content-Type: text/plain
Date: Thu, 04 May 2006 09:07:09 -0700
Message-Id: <1146758829.22503.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 11:46 -0400, Bob Picco wrote:
> Dave Hansen wrote:	[Thu May 04 2006, 11:21:06AM EDT]
> > I haven't thought through it completely, but these two lines worry me:
> > 
> > > + start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
> > > + end = start + pgdat->node_spanned_pages;
> > 
> > Should the "end" be based off of the original "start", or the aligned
> > "start"?
> Yes. I failed to quilt refresh before sending. You mean end should be
> end = pgdat->node_start_pfn + pgdat->node_spanned_pages before rounding
> up.

Yep.  Looks good.

-- Dave

