Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWCDW2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWCDW2a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWCDW2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:28:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32733
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751859AbWCDW23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:28:29 -0500
Date: Sat, 04 Mar 2006 14:28:21 -0800 (PST)
Message-Id: <20060304.142821.105572446.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060304.142202.32211471.davem@davemloft.net>
References: <20060304.022546.85833873.davem@davemloft.net>
	<20060304141717.GA456@in.ibm.com>
	<20060304.142202.32211471.davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 04 Mar 2006 14:22:02 -0800 (PST)

> From: Dipankar Sarma <dipankar@in.ibm.com>
> Date: Sat, 4 Mar 2006 19:47:17 +0530
> 
> > Dave, there is a set of patches in -mm that may handle this
> > better -
> > 
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/rcu-batch-tuning.patch
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/fix-file-counting.patch
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/fix-file-counting-fixes.patch
> > 
> > Could you please try this in your setup ?
> > 
> > The rcu-batch tuning patch provides automatic switching to
> > process as many RCUs as possible if too many of them are queued.
> > The file counting fixes count the file structures correctly.
> 
> Thanks, I'll give these patches a spin.

Sigh, this is going to take a while, because there are -mm
dependencies in these patches such as percpu_counter_sum().

I'll have to fish those out of -mm before I can start testing
this.
