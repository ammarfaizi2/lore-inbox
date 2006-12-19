Return-Path: <linux-kernel-owner+w=401wt.eu-S932803AbWLSMXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbWLSMXL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWLSMXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:23:11 -0500
Received: from main.gmane.org ([80.91.229.2]:57814 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932803AbWLSMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:23:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wiebe Cazemier <halfgaar@gmx.net>
Subject: Re: Software RAID1 (with non-identical discs) performance
Date: Tue, 19 Dec 2006 13:22:46 +0100
Message-ID: <em8lim$lqd$1@sea.gmane.org>
References: <em0pdq$r7o$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cc503261-a.eelde1.dr.home.nl
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, your message doesn't appear in the GMane mail-to-news gateway.
I've quoted your message here. Hopefully, the quoting isn't messed up.

> The entire concept of geometry is a a carryover from days gone by. These days
it is just a farse maintained for backwards compatibility. You can put fdisk
into sector mode with the 'u' command and create partitions of any number of
sectors you desire, regardless of the perceived geometry.

I remember when I did that, fdisk started complaining. But, I'm going to have
to experiment with this.

> > My first question is, is this a necessary/convenient technique to ensure
you
> > can replace discs over time, especially when you can't get the exact same
> > replacement disc?
> 
> I don't believe you need to do anything; md will simply not use the few extra
sectors at the end of the larger disk/partition and round down to the
appropriate size. 

If you can indeed make partitions equally big on different types of drives by
using sector mode, that would solve part of the problem. But what if a
replacement disk you got, is just a tad smaller than the original one, and
doesn't fit in the array? That's also a reason I always left some space
unpartitioned, since resizing the array to make it smaller, is a pain last
time I tried.

> Yes, it slows things down.  You want to try to match disk speeds as closely
as possible for best performance. 

My concern wasn't so much about the different speeds of the drives, but the
fact that they have a different geometry. But, because you said that is
simulated anyway, can I assume that as long as both drives are equal in speed,
using different types of drives doesn't matter?

