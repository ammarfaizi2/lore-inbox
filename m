Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUERALE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUERALE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUERALE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:11:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:23941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262585AbUERALB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:11:01 -0400
Date: Mon, 17 May 2004 17:13:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: mason@suse.com, torvalds@osdl.org, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, support@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040517171330.7d594eb1.akpm@osdl.org>
In-Reply-To: <200405171752.08400.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	<1084828124.26340.22.camel@spc0.esa.lanl.gov>
	<20040517142946.571a3e91.akpm@osdl.org>
	<200405171752.08400.elenstev@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> > 
> OK, applied your one-liner above with PREEMPT.
> 
> ...
> Found null start 0xfb259a end 0xfb3000 len 0xa66 line 478846
> 
> The above was on reiserfs and happened on the very first pull.
> 
> Attaching the source of saga.c for reference.

ok, thanks.

> So, what next doc?  Back out that one-liner and try your vmtruncate?

No, it won't help in that case.

> Or try Chris' patch for reiserfs?
> 
> At the moment I'm testing on ext3, which survived the two pull/unpulls.  
> This is like watching paint dry.
> 
> I'll do some more bk unpull and bk pull cycles until this breaks on ext3.

I guess it would be interesting to run it on a filesystem which has 2k or
even 1k blocksize.  If the corruption then terminates on a 2k- or
1k-boundary then that will rule out a few culprits.

I'd really like to see this happen on some other machine though.  It'd be
funny if you have a dud disk drive or something.
