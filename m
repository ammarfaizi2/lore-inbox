Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUERB5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUERB5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUERB5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:57:05 -0400
Received: from taco.zianet.com ([216.234.192.159]:54795 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S262279AbUERB5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:57:01 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 19:56:28 -0600
User-Agent: KMail/1.6.1
Cc: Larry McVoy <lm@bitmover.com>, mason@suse.com, torvalds@osdl.org,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <20040518013439.GA23497@work.bitmover.com> <20040517184208.2206e8c4.akpm@osdl.org>
In-Reply-To: <20040517184208.2206e8c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405171956.28747.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 07:42 pm, Andrew Morton wrote:
> Larry McVoy <lm@bitmover.com> wrote:
> >
> >  > I'd really like to see this happen on some other machine though.  It'd be
> >  > funny if you have a dud disk drive or something.
> > 
> >  We can easily rule that out.  Steven, do a 
> > 
> >  	dd if=/dev/zero of=USE_SOME_SPACE bs=1048576 count=500

I'll get to Larry's test a little later.  Pizza's about to come out of the oven.

> > 
> >  which will eat up 500 MB and should eat up any bad blocks.  I _really_
> >  doubt it is a bad disk.
> 
> Yes, me too.  The sensitivity to CONFIG_PREEMPT makes that unlikely.
> 
> Two things I'm not clear on:
> 
> a) Has is been established that CONFIG_PREEMPT causes ppp to fail?

At the risk of a "post hoc ergo propter hoc" fallacy, I'd say yes.  I have not
seen ppp fail without PREEMPT.  No PREEMPT, no ppp problems.

> 
> b) Has the file corruption been observed when PPP was not in use at all?

No, at least I don't have any specific memory of corruption without ppp.

I made a fresh 3.9G reiserfs fs on my second disk, and cloned a kernel
tree to it.  I can use it for testing, but its currently in sync with linux.bkbits.net/linux-2.5.

Later,
Steven 
