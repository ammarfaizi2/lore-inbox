Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVIIMnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVIIMnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIIMnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:43:40 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:32818
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751441AbVIIMnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:43:39 -0400
Message-Id: <43219FDF0200007800024975@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 14:44:47 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmmod notifier chain
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <20050908151624.GA11067@infradead.org> <432073610200007800024489@emea1-mh.id2.novell.com> <20050908184659.6aa5a136.akpm@osdl.org>
In-Reply-To: <20050908184659.6aa5a136.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's funny - on one hand I'm asked to not submit huge patches (not
by
>> you, but by others), but on the other hand not having the consuming
code
>> in the same patch as the providing one is now deemed to be a
problem.
>
>Nope.
>
>Each patch should do a single logical thing.  That doesn't mean that
we
>want to trickle patches in across a period of months.  It means that
a
>bunch of spearate (and separately reviewed) patches can all go in at
the
>same time.
>
>So the split-it-up request is for reviewing (and debugging)
convenience
>only.

Forgive my non-understanding:

First, I rarely saw any kind of positive review feedback from lkml
besides the notification that you added something to your -mm tree
(negative things of course always arrive), yet no feedback at all is far
from meaning that a given patch is ever going to be accepted (as a
really good example take the tiny patch to fix the broken range check in
i386's low level NMI handler).

Second, since patches depend on one another in many cases it seemed
most natural to me to first break out things that aren't directly
related to nlkd or, if directly related, could still be viewed as
independent pieces of work. Hence I wouldn't consider it reasonable to
break up the debugger patch entirely and submit all the pieces at once,
because that could easily mean that if one intermediate piece doesn't
get accepted all the dependent pieces have been separated out
pointlessly.

I'd be curious to know how you, considering yourself in my position,
would have approached breaking up and submitting that size a patch.

Thanks,
Jan

