Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSHTLnJ>; Tue, 20 Aug 2002 07:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHTLnJ>; Tue, 20 Aug 2002 07:43:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11959 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316857AbSHTLnJ>; Tue, 20 Aug 2002 07:43:09 -0400
Date: Tue, 20 Aug 2002 17:14:31 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Question regarding Qdisc.stats
Message-ID: <20020820171431.K1992@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where do the Qdisc.stats show up? in /proc? (Assuming CONFIG_NET_SCHED is
not defined) I can see that it is copied to the skb from 
qdisc_copy_stats with 'TCA_STATS' attribute, but where is it being 
reported? or what is it being used for ?? Specifically, does 
Qdisc.stats.drops get reported anywere?

While I am at it, I see that qdisc->enqueue routines kfree the skb with the
dev->queue_lock held (when the enqueue routine drops the packet -- 
NET_XMIT_DROP)  from dev_queue_xmit. kfree_skb can be done outside the 
lock.... right? I can make a patch for this if I am not missing something.....

TIA
Kiran
