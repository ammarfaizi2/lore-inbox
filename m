Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264870AbUEYO1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbUEYO1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbUEYO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:27:31 -0400
Received: from mail.ccur.com ([208.248.32.212]:52491 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264870AbUEYO13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:27:29 -0400
Date: Tue, 25 May 2004 10:27:28 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: markh@compro.net, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20040525142728.GA10738@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20031003214411.GA25802@rudolph.ccur.com> <40ADE959.822F1C23@compro.net> <20040521191326.58100086.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521191326.58100086.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 07:13:26PM -0700, Andrew Morton wrote:
> Mark Hounschell <markh@compro.net> wrote:
> >
> > Joe Korty wrote:
> > > 
> > > 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> > > the registers of an IO device will hang that process uninterruptibly.
> > > The task runs in an infinite loop in get_user_pages(), invoking
> > > follow_page() forever.
> > > 
> > > Using binary search I discovered that the problem was introduced
> > > in 2.5.14, specifically in ChangeSetKey
> > > 
> > >     zippel@linux-m68k.org|ChangeSet|20020503210330|37095
> > > 
> > 
> > I know this is an old thread but can anyone tell me if this problem is
> > resolved in the current 2.6.6 kernel? 
> > 
> 
> There's an utterly ancient patch in -mm which might fix this.
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/broken-out/get_user_pages-handle-VM_IO.patch

[ 2nd send -- corporate email system in the throes of being scrambled / updated ]

Andrew,
I have been using this patch for ages.  Any chance of it being forwared to
the official tree?

Regards,
Joe
