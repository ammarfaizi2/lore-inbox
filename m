Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423232AbWJTVK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423232AbWJTVK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423239AbWJTVK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:10:28 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:62903 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1423232AbWJTVK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:10:26 -0400
Subject: Re: [PATCH] (update) more helpful WARN_ON and BUG_ON messages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4538FF32.8050604@sandeen.net>
References: <4538F81A.2070007@redhat.com>  <4538FF32.8050604@sandeen.net>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 19:02:26 +0200
Message-Id: <1161363746.5230.55.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 11:54 -0500, Eric Sandeen wrote:
> Eric Sandeen wrote:
> 
> > After a few bugs I encountered in FC6 in buffer.c, with output like:
> >
> > Kernel BUG at fs/buffer.c: 2791
> >
> > where buffer.c contains:
> >
> > ...
> >         BUG_ON(!buffer_locked(bh));
> >         BUG_ON(!buffer_mapped(bh));
> >         BUG_ON(!bh->b_end_io);
> > ...
> >
> > around line 2790, it's awfully tedious to go get the exact failing kernel tree
> > just to see -which- BUG_ON was encountered.
> >
> > Printing out the failing condition as a string would make this more helpful IMHO.
> >
> > This is mostly just compile-tested... comments?
> Whoops, missed WARN_ON_ONCE... thanks Peter.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

I like this, as you pointed out, its not always obvious which condition
is the offending one, this makes it more clear.


