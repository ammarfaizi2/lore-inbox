Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUERBms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUERBms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUERBms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:42:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:34492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262194AbUERBmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:42:46 -0400
Date: Mon, 17 May 2004 18:42:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: elenstev@mesatop.com, mason@suse.com, torvalds@osdl.org, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040517184208.2206e8c4.akpm@osdl.org>
In-Reply-To: <20040518013439.GA23497@work.bitmover.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<1084828124.26340.22.camel@spc0.esa.lanl.gov>
	<20040517142946.571a3e91.akpm@osdl.org>
	<200405171752.08400.elenstev@mesatop.com>
	<20040517171330.7d594eb1.akpm@osdl.org>
	<20040518013439.GA23497@work.bitmover.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> wrote:
>
>  > I'd really like to see this happen on some other machine though.  It'd be
>  > funny if you have a dud disk drive or something.
> 
>  We can easily rule that out.  Steven, do a 
> 
>  	dd if=/dev/zero of=USE_SOME_SPACE bs=1048576 count=500
> 
>  which will eat up 500 MB and should eat up any bad blocks.  I _really_
>  doubt it is a bad disk.

Yes, me too.  The sensitivity to CONFIG_PREEMPT makes that unlikely.

Two things I'm not clear on:

a) Has is been established that CONFIG_PREEMPT causes ppp to fail?

b) Has the file corruption been observed when PPP was not in use at all?


