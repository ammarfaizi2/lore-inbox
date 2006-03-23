Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWCWH7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWCWH7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWCWH7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:59:25 -0500
Received: from main.gmane.org ([80.91.229.2]:21475 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030188AbWCWH7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:59:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Ryan M." <kubisuro@att.net>
Subject: Re: -mm merge plans
Date: Thu, 23 Mar 2006 16:59:09 +0900
Message-ID: <4422554D.6000602@att.net>
References: <20060322205305.0604f49b.akpm@osdl.org>
Reply-To: kubisuro@att.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 210.120.111.10
User-Agent: Thunderbird 1.5 (X11/20051201)
In-Reply-To: <20060322205305.0604f49b.akpm@osdl.org>
Cc: ck@vds.kolivas.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:
 > A look at the -mm lineup for 2.6.17:
 >

 >
 > mm-implement-swap-prefetching.patch
 > mm-implement-swap-prefetching-fix.patch
 > mm-implement-swap-prefetching-tweaks.patch
 >
 >   Still don't have a compelling argument for this, IMO.

I hate to make a comparison based on the little information there is, 
but Windows Vista will have something like prefetch, albeit, 
exponentially more intrusive (read MS' explanation on their website). 
However, when I see that such technology is being embraced by the 
competitor to help improve the desktop (and it follows, the server 
space) and I see this better, non-invasive solution nearly rejected, I 
can't help but feel rather disappointed.

To prefetch applications from swap to physical memory when there is 
little activity seems so obvious that I can't believe it hasn't been 
implemented before.

I play World of Warcraft which saps away 1gb of physical memory in a 
heart-beat.  During that period of time I run gobs of other networking 
applications as any desktop users might.  They sometimes swap.  I leave 
World of Warcraft and I can  see them prefetched back to physical memory 
while not being removed from swap.  To do something useful, particularly 
when it helps interactivity, when idle is a very smart use of resources. 
  It is even smarter to save future swapping of those same applications 
because they're likely not to be removed from swap unless swap space is 
becoming limited.  It is practically free and for long running desktop 
systems that seems a necessity.

I don't have quantitative evidence, but I think the objective of swap 
prefetch speaks volumes itself.  I can imagine it being useful in 
server-space, because having had anything swapped out in the past and it 
not having to be swapped again after prefetched could seriously help 
reduce disk accesses -- extremely important during heavy i/o loads.

I hope others join me in explaining the very usefulness of swap prefetch 
  -- it'd be great for someone with the time and abilities  to provide 
quantitative reasons for this existing in mainline.

best,
Ryan M.

