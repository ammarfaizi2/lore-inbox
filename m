Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUKSCsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUKSCsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUKSCs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:48:27 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:58712 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261244AbUKSCkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 21:40:17 -0500
Message-ID: <419D5D05.4020707@yahoo.com.au>
Date: Fri, 19 Nov 2004 13:40:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] fix __flush_tlb*() preemption bug on CONFIG_PREEMPT
References: <20041118124656.GA4256@elte.hu> <Pine.LNX.4.58.0411180742290.2222@ppc970.osdl.org> <20041118194619.GA23483@elte.hu> <Pine.LNX.4.58.0411181056550.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411181056550.2222@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> But yes, it may well make perfect sense to say "we have to hold the page 
> table spinlock in order to flush the tlb". Is that actually true right 
> now?
> 

Can we try not to ratify a rule like that? :)

We're somewhat closeish to being able to entirely remove the ptl, so
it might just get awkward if people think they can rely on that rule.

Of course, _if_ holding the ptl is the nicest way to do things in the
mainline kernel then yeah OK I can't argue with that... but if at all
possible... pretty please?

Thanks,
Nick
