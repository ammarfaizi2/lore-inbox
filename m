Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUHTCLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUHTCLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHTCLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:11:19 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:30808 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264973AbUHTCLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:11:16 -0400
Message-ID: <41255DBA.3030909@yahoo.com.au>
Date: Fri, 20 Aug 2004 12:11:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add scheduler domains for ia64
References: <200408131108.40502.jbarnes@engr.sgi.com> <200408141352.01486.jbarnes@engr.sgi.com> <411EB463.5090809@yahoo.com.au> <200408171657.32357.jbarnes@engr.sgi.com>
In-Reply-To: <200408171657.32357.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Saturday, August 14, 2004 8:54 pm, Nick Piggin wrote:
> 
>>Yeah, all the SD_*_INIT values are overridable. We could even say, put
>>in an SD_NODE2_INIT for a 2nd level NUMA domain in the generic code,
>>for example.
> 
> 
> Yeah, we'll need different values for each level in the hierarchy.
> 
> 
>>I'd say your closest-node setup would probably get close to what you want.
>>The main thing you want is to not do huge amounts of balancing work in
>>interrupt context, and also not to move a task from one side of the
>>system to the other when one node is a little bit out of balance.
>>
>>I guess if you want to do anything fancier then we can take a look at
>>re-exporting the domain setup.
> 
> 
> Ok, sounds good.  How does this look?  It sits on top of 2.6.8.1-mm1, ripping 
> out the ia64 specific bits and moving things to sched.c.  I've also added an 
> ia64 specific SD_NODE_INIT and an #if !defined to sched.c
> 

Sorry I haven't replied earlier.  I think this looks good, provided
it does the right thing for you (I can't test it myself). Send it to
Andrew to get merged if you'd like.
