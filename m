Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTHSVaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSV1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:27:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:36265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbTHSVYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:24:42 -0400
Date: Tue, 19 Aug 2003 14:10:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm3
Message-Id: <20030819141000.7df20405.akpm@osdl.org>
In-Reply-To: <20030819183249.GD19465@matchmail.com>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<20030819183249.GD19465@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> On Tue, Aug 19, 2003 at 01:38:34AM -0700, Andrew Morton wrote:
> > +disable-athlon-prefetch.patch
> > 
> >  Disable prefetch() on all AMD CPUs.  It seems to need significant work to
> >  get right and we're currently getting rare oopses with K7's.
> 
> Is this going to stay in -mm, or will it eventually propogate to stock?

That depends if someone does any work on it in the next few days I guess. 
Right now we're getting mysterious oopses down inside fine_inode_fast,
which is unacceptable.

> If it does, can this be added to the to-do list of things to fix before 2.6.0?
> 
> I'd hate to see this feature lost...

Show me a workload in which it makes a measurable difference.

But no, it won't get forgotten.
