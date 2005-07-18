Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVGRKOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVGRKOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 06:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGRKOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 06:14:06 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:14561 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261427AbVGRKOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 06:14:05 -0400
Date: Mon, 18 Jul 2005 19:12:22 +0900 (JST)
Message-Id: <20050718.191222.71104647.taka@valinux.co.jp>
To: pj@sgi.com
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050717082000.349b391f.pj@sgi.com>
References: <20050715150034.GA6192@infradead.org>
	<20050715131610.25c25c15.akpm@osdl.org>
	<20050717082000.349b391f.pj@sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > What, in your opinion, makes it "obviously unmergeable"?

Controlling resource assignment, I think that concept is good.
But the design is another matter that it seems somewhat overkilled
with the current CKRM.

> I suspect that the main problem is that this patch is not a mainstream
> kernel feature that will gain multiple uses, but rather provides
> support for a specific vendor middleware product used by that
> vendor and a few closely allied vendors.  If it were smaller or
> less intrusive, such as a driver, this would not be a big problem.
> That's not the case.

I believe this feature would also make desktop users happier -- controlling
X-server, mpeg player, video capturing and all that -- if the code
becomes much simpler and easier to use.

> A major restructuring of this patch set could be considered,  This
> might involve making the metric tools (that monitor memory, fork
> and network usage rates per task) separate patches useful for other
> purposes.  It might also make the rate limiters in fork, alloc and
> network i/o separately useful patches.  I mean here genuinely useful
> and understandable in their own right, independent of some abstract
> CKRM framework.

That makes sense.

> Though hints have been dropped, I have not seen any public effort to
> integrate CKRM with either cpusets or scheduler domains or process
> accounting.  By this I don't mean recoding cpusets using the CKRM
> infrastructure; that proposal received _extensive_ consideration
> earlier, and I am as certain as ever that it made no sense.  Rather I
> could imagine the CKRM folks extending cpusets to manage resources
> on a per-cpuset basis, not just on a per-task or task class basis.
> Similarly, it might make sense to use CKRM to manage resources on
> a per-sched domain basis, and to integrate the resource tracking
> of CKRM with the resource tracking needs of system accounting.

>From a standpoint of the users, CKRM and CPUSETS should be managed
seamlessly through the same interface though I'm not sure whether
your idea is the best yet.


Thanks,
Hirokazu Takahashi.
