Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbTIOAMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTIOAMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 20:12:09 -0400
Received: from a-shells.com ([216.40.245.209]:42720 "EHLO fatima.utopus.net")
	by vger.kernel.org with ESMTP id S262200AbTIOAMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 20:12:07 -0400
Message-ID: <3F6503BF.405@plasticpenguins.com>
Date: Sun, 14 Sep 2003 20:11:43 -0400
From: Mike S <wickedchicken@plasticpenguins.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030428 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Jamie Lokier <jamie@shareable.org>, rusty@linux.co.intel.com,
       riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>	 <20030913174825.GB7404@mail.jlokier.co.uk> <1063476152.24473.30.camel@localhost>
In-Reply-To: <1063476152.24473.30.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - fatima.utopus.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - plasticpenguins.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> One thing to keep in mind is that during a real OOM condition, we cannot
> allocate _any_ memory.  None. Zilch.
> 
> And that makes some things very hard.  When we start getting into things
> such as complicated policies that kill nonessential services first, et
> cetera... there comes a time where a lot of communication is needed
> (probably with user-space).  Hard to do that with no memory.

A possible, but not very efficient workaround is to reserve memory or 
swap just for this condition. Obviously this limits available memory for 
other process (which in theory could cause an OOM in the first place) 
and would be wasted most of the time. Possibly this reserved memory 
would be used as a filesystem read cache until OOM, when it would be 
cleared out and used for whatever.

-- 

~Mike
wickedchicken@plasticpenguins.com

