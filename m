Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbTEFEAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbTEFEAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:00:06 -0400
Received: from dp.samba.org ([66.70.73.150]:56491 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262340AbTEFD7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:59:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Mon, 05 May 2003 18:52:48 MST."
             <20030505185248.3c3a478f.akpm@digeo.com> 
Date: Tue, 06 May 2003 14:11:27 +1000
Message-Id: <20030506041213.B80E42C2E0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030505185248.3c3a478f.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > > +#define PERCPU_POOL_SIZE 32768
> > > 
> > > What's this?
> > 
> > OK.  It has a size restriction: PERCPU_POOL_SIZE is the maximum total
> > kmalloc_percpu + static DECLARE_PER_CPU you'll get, ever.  This is the
> > main downside.  It's allocated at boot.
> 
> And is subject to fragmentation.

Absolutely.  However, we're looking at an allocation at module insert,
and maybe at each mount (if used for your fuzzy counters).  Until we
see this in practice, I don't think complicating the allocator is
worth it.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
