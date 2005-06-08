Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVFHC2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVFHC2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVFHC2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:28:03 -0400
Received: from www.rapidforum.com ([80.237.244.2]:52876 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S262072AbVFHC0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:26:48 -0400
Message-ID: <42A65759.8050507@rapidforum.com>
Date: Wed, 08 Jun 2005 04:26:33 +0200
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ben Greear <greearb@candelatech.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	 <422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>	 <422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>	 <422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>	 <422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>	 <422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>	 <422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com>	 <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com>	 <4231ED18.2050804@candelatech.com>  <4231F112.60403@rapidforum.com>	 <1110775215.5131.17.camel@npiggin-nld.site> <423518C7.10207@rapidforum.com> <1110776689.5131.37.camel@npiggin-nld.site>
In-Reply-To: <1110776689.5131.37.camel@npiggin-nld.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes me seriously to despair.... the bug/lock/freeze is still there in 2.6.12rc6 ...

I am seriously offering 1000 dollars to the one who fixes this. (No Joke. I NEED that fixed. If you 
want me to give that money to some organization, tell me.)

Please come back to me if you need more details or tell me what I can do to help you track this 
down. Review all postings before please. Its a vm-lock because even opening a /proc file needs 
around 20-30 seconds...

Nick Piggin wrote:
> On Mon, 2005-03-14 at 05:53 +0100, Christian Schmid wrote:
> 
> 
>>>The other thing that worries me is your need for lower_zone_protection.
>>>I think this may be due to unbalanced highmem vs lowmem reclaim. It
>>>would be interesting to know if those patches I sent you improve this.
>>>They certainly improve reclaim balancing for me... but again I guess
>>>you'll be reluctant to do much experimentation :\
>>
>>I have tested your patch and unfortunately on 2.6.11 it didnt change anything :( I reported this 
>>before, or do you mean something else? I am of course willing to test patches as I do not want to 
>>stick with 2.6.10 forever.
> 
> 
> Well I hope that scheduler developments in progress will put future
> kernels at least on par with 2.6.10 again (and hopefully better).
> 
> Yes you did report that my patch didn't help 2.6.11, but could those
> results have been influenced by the suboptimal HT scheduling? If so,
> I was interested in the results with HT turned off.
> 
> Nick
> 
> 
> Find local movie times and trailers on Yahoo! Movies.
> http://au.movies.yahoo.com
> 
> 
