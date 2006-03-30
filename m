Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWC3OiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWC3OiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWC3OiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:38:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15198 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932238AbWC3OiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:38:02 -0500
Date: Thu, 30 Mar 2006 16:38:10 +0200
From: Jens Axboe <axboe@suse.de>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330143809.GN13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060330175406.fbd6d82c.kamezawa.hiroyu@jp.fujitsu.com> <20060330135346.GL13476@suse.de> <20060330230509.b1ae0d8c.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330230509.b1ae0d8c.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, KAMEZAWA Hiroyuki wrote:
> On Thu, 30 Mar 2006 15:53:46 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > I don't know about sendfile() but this looks client can hold server's
> > > memory, when server uses sendfile() 64k/conn.
> > 
> > You mean when the server uses splice, 64kb (well 16 pages actually) /
> > connection? That's a correct observation, I wouldn't think that pinning
> > that small a number of pages is likely to cause any issues. At least I
> > can think of much worse pinning by just doing IO :-)
> > 
> My point is consumer can sleep forever and pages are pinnded forever.
> And people who use splice() will not notice they are pinning pages.
> 
> But as you say, it's not problem in usual situation.
> Maybe I'm too pessimistic how my cusomers play with Linux ;)

It's a valid concern, however as mentioned there's a number of ways in
which a user can pin memory already. Perhaps this general problem should
be capped elsewhere?

-- 
Jens Axboe

