Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbTIIWb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264892AbTIIWbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:31:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:13202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264849AbTIIWax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:30:53 -0400
Date: Tue, 9 Sep 2003 15:12:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-Id: <20030909151246.6d42656b.akpm@osdl.org>
In-Reply-To: <3F5E4EF5.1030005@austin.ibm.com>
References: <3F5D023A.5090405@austin.ibm.com>
	<20030908155639.2cdc8b56.akpm@osdl.org>
	<3F5E4EF5.1030005@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-CAN_MIGRATE_TASK-fix.patch
> >
> This patch improves specjjb over test5 and has no real effect on any of 
> kernbench, volanomark or specsdet.

Fine, it's a good fix.

> >
> >and if you have time, also test5 plus sched-CAN_MIGRATE_TASK-fix.patch plus
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-balance-fix-2.6.0-test3-mm3-A0.patch
> >  
> >
> This patch degrades both specjbb and volanomark, and to a lesser degree 
> specsdet

ok.  And just confirming: that was test5 plus
sched-CAN_MIGRATE_TASK-fix.patch plus
sched-balance-fix-2.6.0-test3-mm3-A0.patch?

I didn't expect a regression from sched-balance-fix.

> >What I'm afraid of is that those patches will yield improved results over
> >test5, and that adding
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-2.6.0-test2-mm2-A3.patch
> >
> I tried adding this patch to stock test5 and it failed to apply 
> cleanly.  I have not had a chance to look at why.  Did you mean for this 
> to be applied by itself, or was this supposed to go on top of one of the 
> other patches?

Yes, it applies on top of the other two patches.

Thanks for working on this: it's pretty important right now.

