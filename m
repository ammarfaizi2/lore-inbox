Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVIWSnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVIWSnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIWSnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:43:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51822 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750705AbVIWSnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:43:22 -0400
Date: Fri, 23 Sep 2005 20:43:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: Block Device <blockdevice@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Trapping Block I/O
Message-ID: <20050923184342.GJ22655@suse.de>
References: <64c7635405092305433356bd17@mail.gmail.com> <1e62d137050923103843058e92@mail.gmail.com> <20050923180407.GG22655@suse.de> <1e62d137050923111046d0b762@mail.gmail.com> <20050923181435.GI22655@suse.de> <1e62d13705092311306853e7d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e62d13705092311306853e7d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23 2005, Fawad Lateef wrote:
> On 9/23/05, Jens Axboe <axboe@suse.de> wrote:
> > Well it's pretty new, so no wonder. But it should do everything you want
> > and lots more. There's a list for it here:
> >
> > linux-btrace@vger.kernel.org
> >
> > I'm a little pressed for time these days, but I'll do a proper announce
> > / demo of all the features starting next week since it's basically
> > feature complete now.
> >
> > If you don't use git, there are also snapshots available on kernel.org,
> > more precisely here:
> >
> > kernel.org/pub/linux/kernel/people/axboe/blktrace/
> >
> > but kernel.org is pretty slow these days, so pulling from the git repo
> > above is greatly recommended.
> >
> 
> Ya, I looked at it and its looking very good tool to tracing block I/O
> layer, but this tracing requires recompilation of the kernel and have
> to use on kernel directly from kernel.org but its not a big deal, I
> hope it will get into the main kernel soon ....

That is true, I plan on submitting it for 2.6.15. The goal was to get
relayfs pushed in first and that did happen for 2.6.14.

> By the way my approach about creating wrapper and getting the device
> requests without modification into the kernel and can be easily used
> on any block device ...... ;)

There are certainly a lot of ways to get the data out to user space, by
far the bulk of the code is in the monitoring application. blktrace
should be pretty fast though, one of the goals was to make sure it would
be very light weight on the kernel side (which it is) and very fast on
getting the data out (also achieved, relayfs works very well). The
xprobe approach does have certain advantages, the main one being that
you can easily modify it.

-- 
Jens Axboe

