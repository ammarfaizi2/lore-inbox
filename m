Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUB1QHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 11:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUB1QGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 11:06:47 -0500
Received: from leviathan.ele.uri.edu ([131.128.51.64]:4335 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S261876AbUB1QGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 11:06:45 -0500
Subject: can generic_make_request in 2.4 kernel sleep?
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077984402.4422.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 28 Feb 2004 11:06:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a quick question.

In 2.4 kernel, can generic_make_request sleep?

I read the 2.4.24 kernel and find that there is printk in it. so i
assume it can sleep. if so, why the per queue make_request_fn can not
sleep base on the LDD book? and i do not see any place that the
io_request_lock is held. is this lock removed from system? or we do not
need this lock at this place any more?

and in md code, it use blk_queue_make_request to use its own request_fn
instead a queue, for example, in raid1_make_request(), it calls
raid1_alloc_r1ch() which also call schedule() if need, then this own
request_fn can sleep?

i think i am little confused about the LDD (linux device driver 2nd)
book and the new kernel code. can anybody point out some latest
reference for me?

thanks a bunch.


ming


