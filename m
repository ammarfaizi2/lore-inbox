Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVBXIqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVBXIqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVBXIqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:46:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7825 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262031AbVBXIqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:46:33 -0500
Date: Thu, 24 Feb 2005 09:46:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 12/13] schedstats additions for sched-balance-fork
Message-ID: <20050224084622.GC10023@elte.hu>
References: <1109229491.5177.71.camel@npiggin-nld.site> <1109229542.5177.73.camel@npiggin-nld.site> <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <1109230087.5177.89.camel@npiggin-nld.site> <1109230125.5177.91.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109230125.5177.91.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>  [PATCH 11/13] sched-domains aware balance-on-fork
>   [PATCH 12/13] schedstats additions for sched-balance-fork
>  [PATCH 13/13] basic tuning

STREAMS numbers tricky. It's pretty much the only benchmark that 1)
relies on being able to allocate alot of RAM in a NUMA-friendly way 2)
does all of its memory allocation in the first timeslice of cloned
worker threads.

There is little help we get from userspace, and i'm not sure we want to
add scheduler overhead for this single benchmark - when something like a
_tiny_ bit of NUMAlib use within the OpenMP library would probably solve
things equally well!

Anyway, the code itself looks fine and it would be good if it improved
things, so:

 Acked-by: Ingo Molnar <mingo@elte.hu>

but this too needs alot of testing, and it the one that has the highest
likelyhood of actually not making it upstream.

	Ingo
