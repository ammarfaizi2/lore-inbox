Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTIHXPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTIHXPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:15:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:19687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263776AbTIHXPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:15:33 -0400
Date: Mon, 8 Sep 2003 15:56:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-Id: <20030908155639.2cdc8b56.akpm@osdl.org>
In-Reply-To: <3F5D023A.5090405@austin.ibm.com>
References: <3F5D023A.5090405@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> For specjbb things are looking good from a throughput point of view. 
> ...
> Volanomark, on the other hand is still off by quite a bit from test4 stock
> 

hmm, thanks.

I'm not sure that volanomark is very representative of any real-world
thing.

> ...
> If thre is any particular patch/tree combination you would like me to 
> try out, please let me know and I will see if I can get the results for 
> you. 

Could we please see test5 versus test5 plus Andrew's patch?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-CAN_MIGRATE_TASK-fix.patch

and if you have time, also test5 plus sched-CAN_MIGRATE_TASK-fix.patch plus

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-balance-fix-2.6.0-test3-mm3-A0.patch


What I'm afraid of is that those patches will yield improved results over
test5, and that adding

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-2.6.0-test2-mm2-A3.patch

will slow things down again.

