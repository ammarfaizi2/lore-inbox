Return-Path: <linux-kernel-owner+w=401wt.eu-S964798AbXASDT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXASDT1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbXASDT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:19:27 -0500
Received: from verein.lst.de ([213.95.11.210]:42642 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798AbXASDT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:19:26 -0500
Date: Fri, 19 Jan 2007 04:19:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH] Cell SPU task notification
Message-ID: <20070119031902.GA16524@lst.de>
References: <45A805A0.2080000@us.ibm.com> <20070117003018.GA17955@lst.de> <45AE471C.8040909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AE471C.8040909@us.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 09:56:12AM -0600, Maynard Johnson wrote:
> I haven't seen that the scheduler patch series got applied yet.  This 
> Cell spu task notification patch is a pre-req for OProfile development 
> to support profiling SPUs.   When the scheduler patch gets applied to a 
> kernel version that fits our needs for our OProfile development, I don't 
> see any problem in using the sched_flags field instead of notify_active.

I'll hopefull commit these patches this weekend, I'm at a conference
currently so not really able to do a lot of work.  If you need to make
more progress until than just apply the hunk that introduces sched_flags
before doing your patch.

> Yes, the yield() and the memory barriers were leftovers from an earlier 
> ill-conceived attempt at solving this problem.  They should have been 
> removed.  They're gone now.

Ok.

> I hesitated doing this since it would entail changing spu_switch_notify 
> from being static to non-static.  I'd like to get Arnd's opinion on this 
> question before going ahead and making such a change.

There is no difference in impact between marking a function non-static
and adding a trivial wrapper around it, only that the latter creates
more bloat.  So I don't think there's a good argument against this.
