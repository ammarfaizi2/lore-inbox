Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWCQJJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWCQJJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbWCQJJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:09:13 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:20616 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750988AbWCQJJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:09:12 -0500
Date: Fri, 17 Mar 2006 10:06:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [PATCH] mm: yield during swap prefetching
Message-ID: <20060317090653.GC13387@elte.hu>
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org> <200603090036.49915.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603090036.49915.kernel@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> > We do have SCHED_BATCH but even that doesn't really have the desired
> > effect. I know how much yield sucks and I actually want it to suck as much
> > as yield does.
> 
> Thinking some more on this I wonder if SCHED_BATCH isn't a strong 
> enough scheduling hint if it's not suitable for such an application. 
> Ingo do you think we could make SCHED_BATCH tasks always wake up on 
> the expired array?

yep, i think that's a good idea. In the worst case the starvation 
timeout should kick in.

	Ingo
