Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUEWM6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUEWM6y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 08:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUEWM6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 08:58:54 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:42651 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S262794AbUEWM6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 08:58:52 -0400
Message-ID: <40B0A007.544FFC23@compro.net>
Date: Sun, 23 May 2004 08:58:47 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
References: <20031003214411.GA25802@rudolph.ccur.com>
			<40ADE959.822F1C23@compro.net> <20040521191326.58100086.akpm@osdl.org> <40AF2FC4.911DB14B@compro.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:
> 
> Andrew Morton wrote:
> >
> > Mark Hounschell <markh@compro.net> wrote:
> > >
> > > Joe Korty wrote:
> > > >
> > > > 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> > > > the registers of an IO device will hang that process uninterruptibly.
> > > > The task runs in an infinite loop in get_user_pages(), invoking
> > > > follow_page() forever.
> > > >
> > > > Using binary search I discovered that the problem was introduced
> > > > in 2.5.14, specifically in ChangeSetKey
> > > >
> > > >     zippel@linux-m68k.org|ChangeSet|20020503210330|37095
> > > >
> > >
> > > I know this is an old thread but can anyone tell me if this problem is
> > > resolved in the current 2.6.6 kernel?
> > >
> >
> > There's an utterly ancient patch in -mm which might fix this.
> >
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm4/broken-out/get_user_pages-handle-VM_IO.patch
> 
> Thanks for that. I'll try it.
> 
> Mark

Thank you. That definatly fixed my problem. Is fixing this main line
WIP? 

Regards
Mark
