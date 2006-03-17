Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752583AbWCQK3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbWCQK3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbWCQK3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:29:13 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:60907 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752583AbWCQK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:29:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Pradeep Vincent" <pradeep.vincent@gmail.com>
Subject: Re: Priority in Memory management
Date: Fri, 17 Mar 2006 21:29:01 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <9fda5f510603170037v41d273c5naf36776e6f03246e@mail.gmail.com>
In-Reply-To: <9fda5f510603170037v41d273c5naf36776e6f03246e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603172129.01490.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 19:37, Pradeep Vincent wrote:
> I tried searching for discussions related to this but in vain A
> significant number of servers running Linux come under the category of
> "Caching Servers". These servers usually try to server data either
> from RAM or disk sub-systems and for obvious reasons want to serve as
> much data as possible from RAM. Even if the dataset is comparable to
> RAM size, other bon-performance critical activities on the system
> (such as logging, log rotation/compression, remote performance
> monitors, application code updates, security related searches )
> disturb the cache hit ratio.
>
> Mlocking the dataset is one option. Using fadvise/O_STREAM for
> everything else is another option - but this doesn't address all the
> cases.
>
> Instead of locking out all memory, being able to set priorities for
> virtual memory regions comes across as a better idea. This way if the
> system really really needs memory, kernel can reclaim the cache pages
> but not just because somebody is writing something and it might seem
> fair to reclaim the dataset cache.
>
>
> Has this come up in the past. Any history at all - I am all ears for
> ideas and concerns.

True priority support in the form of a "vm scheduler" is something I've 
mentioned many times in the past. The overhead would not be insignificant. 
Nonetheless I do have some weak priority support for page reclaiming in my 
-ck tree because doing so was not overly expensive. As far as I'm aware noone 
is currently working on a comprehensive vm scheduler.

Cheers,
Con
