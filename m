Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945903AbWBOL7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWBOL7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWBOL7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:59:08 -0500
Received: from smtp.nedstat.nl ([194.109.98.184]:32153 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S1422770AbWBOL7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:59:07 -0500
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
Subject: Re: + vmscan-rename-functions.patch added to -mm tree
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, christoph@lameter.com
In-Reply-To: <43F2E7C8.9040600@yahoo.com.au>
References: <200602120605.k1C65QFE028051@shell0.pdx.osdl.net>
	 <2cd57c900602141847m7af4ec7ap@mail.gmail.com>
	 <43F29B84.6020009@yahoo.com.au>
	 <1139985978.6722.14.camel@localhost.localdomain>
	 <43F2E7C8.9040600@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 12:59:00 +0100
Message-Id: <1140004740.6087.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 19:35 +1100, Nick Piggin wrote:
> Peter Zijlstra wrote:
> > On Wed, 2006-02-15 at 14:09 +1100, Nick Piggin wrote:
> 
> >>shrink_zone and do_shrink_zone don't really say any more to me than
> >>shrink_zone and shrink_cache.
> > 
> > 
> > I know not everybody believes in a plugable reclaim policy, but that is
> > what I'm building. And from that POV I'd rather not see the
> > active/inactive names get used here.
> > 
> 
> active/inactive is what we have now. If you manage to get a pluggable
> reclaim policy merged then I assure you, renaming these yet again will
> be the least of your worries :)

True indeed.

> > My vote goes to Coywolf's suggestion.
> > 
> 
> What was that?

Hmm, seems like I shouldn't read email before waking up, apparently I
got the quoting levels mixed up.

Anyway, this one:

>>        try_to_free_pages
>>        ->shrink_zones(struct zone **zones, ..)
>>          ->shrink_zone(struct zone *, ...)
>>            ->do_shrink_zone(struct zone *, ...)
>>              ->shrink_page_list(struct list_head *, ...)


