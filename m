Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWAXEle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWAXEle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWAXEle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:41:34 -0500
Received: from dvhart.com ([64.146.134.43]:30083 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030315AbWAXEle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:41:34 -0500
Message-ID: <43D5AFF9.10608@google.com>
Date: Mon, 23 Jan 2006 20:41:29 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com> <200601121739.17886.kernel@kolivas.org> <43D52E6F.7040808@google.com> <43D5821A.7050001@bigpond.net.au> <43D5A3F0.1000206@bigpond.net.au>
In-Reply-To: <43D5A3F0.1000206@bigpond.net.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oops.  I was looking at the graphs for Moe but 
> <http://test.kernel.org/perf/dbench.elm3b132.png> doesn't appear to be 
> demonstrating a problem either.  Given the fluctuation in the 
> 2.6.16-rc1 results (235, 234, 211, 228.5 and 237.5), the results for 
> 2.6.16-rc1-mm1 (229) and 2.6.16-mm2 (219) aren't significantly different.

I disagree. Look at the graph. mm results are consistent and stable, and 
significantly worse than mainline.

> Peter
> PS I have a modification for kernbench that calculates and displays 
> the standard deviations for the various averages if you're 
> interested.  This would enable you to display 95% (say) confidence 
> bars on the graphed results which in turn makes it easier to spot 
> significant differences.

Thanks, but I have that. What do you think those vertical bars on the 
graph are for? ;-) They're deviation of 5 runs. I throw away the best 
and worst first. If it was just random noise, then you'd get the same 
variance *between* runs inside the -mm train and inside mainline. You 
don't see that ...

Use the visuals in the graph .. it's very telling. -mm is *broken*.
It may well not be the same issue as last time though, I shouldn't
have jumped to that conclusion.

M.
