Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVJQUaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVJQUaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVJQUaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:30:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59605 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751345AbVJQUaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:30:23 -0400
Date: Tue, 18 Oct 2005 01:54:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017202419.GG13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org> <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org> <4353FDE8.8070909@cosmosbay.com> <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org> <435408AD.4060505@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435408AD.4060505@nortel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:25:17PM -0600, Christopher Friesen wrote:
> Linus Torvalds wrote:
> 
> >Yes, it may screw up some latency stuff, but quite frankly, even with your 
> >patch and even ignoring the call_rcu_bh case, I'm convinced you can easily 
> >get into the situation where softirqd just doesn't run soon enough.
> >
> >But at least I think I understand _why_ rcu processing was delayed.
> 
> Could this be related to the "rename14 LTP test with /tmp as tmpfs and 
> HIGHMEM causes OOM-killer invocation due to zone normal exhaustion" issue?

Could very well be. Chris, could you please try booting
with rcupdate.maxbatch=10000 and see if the problem goes away ?

Thanks
Dipankar
