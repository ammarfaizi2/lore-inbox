Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVFKOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVFKOho (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVFKOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:37:43 -0400
Received: from opersys.com ([64.40.108.71]:19460 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261714AbVFKOhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:37:22 -0400
Message-ID: <42AAF5CE.9080607@opersys.com>
Date: Sat, 11 Jun 2005 10:31:42 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>
In-Reply-To: <20050611070845.GA4609@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> could you send me the .config you used for the PREEMPT_RT tests? Also, 
> you used -47-08, which was well prior the current round of performance 
> improvements, so you might want to re-run with something like -48-06 or 
> better.

Much to our dislike, we only noticed that we forgot to disable the debug
options after posting the results :/ So, in all fairness, we will be
redoing the tests on PREEMPT_RT early next week. In the plethora of things
we wanted to try, it also seems that the "dd" test wasn't exactly as it
was supposed to be. There should've been a "bs=1M" in there; as it
currently is, the dd command doesn't really put any real load. We'll add
this one to our repeats.

I notice there are already suggestions regarding additional types of
tests, and that's good. We'll try to take as many of these as possible.
This is relatively simple given the scripts Kristian has put together.
Nevertheless, it must be understood that we don't have infinite resources.
So in sharing the framework we've developed, we hope others will be
motivated to conduct their own tests.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
