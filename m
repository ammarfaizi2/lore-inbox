Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316464AbSEOSVN>; Wed, 15 May 2002 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSEOSVM>; Wed, 15 May 2002 14:21:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11013 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316464AbSEOSVL>; Wed, 15 May 2002 14:21:11 -0400
Date: Wed, 15 May 2002 14:16:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <20020515170025.GF27957@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1020515141208.5811B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, William Lee Irwin III wrote:

> Boots compiles and runs on an 4-way physical HT box. I didn't wake
> the evil twins to cut down on the number of variables so it stayed
> 4-way despite the ability to go 8-way.
> 
> Sliding window of 120 seconds, sampled every 15 seconds, under a
> repetitive kernel compile load:
> 
> Wed May 15 09:56:37 PDT 2002
> cpu  60701 0 5137 203545 9327
> cpu0 15048 0 1566 50868 2298
> cpu1 15257 0 1176 50818 2392
> cpu2 15248 0 1346 50802 2247
> cpu3 15148 0 1049 51057 2390
	[... snip ...]
> Wed May 15 09:58:22 PDT 2002
> cpu  98583 0 8082 204779 9328
> cpu0 24538 0 2254 51205 2298
> cpu1 24521 0 2065 51180 2393
> cpu2 24704 0 1978 51230 2247
> cpu3 24820 0 1785 51164 2390
> 
> 
> It looks very constant, not sure if it should be otherwise.

You show-offs with your big memory and everything in it... Okay, boot that
puppy with mem=256m and try that again, particularly with -j4 (or -j8 with
HT on). I bet THAT will give you some IOwait!

I think you do want to try HT after you find out the memory is small
enough. Pure curiousity on my part, I assume it will work, although the
results might not be what I expect.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

