Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUCYP17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUCYP16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:27:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3784 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263202AbUCYP1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:27:53 -0500
Date: Thu, 25 Mar 2004 16:27:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040325152749.GP3377@suse.de>
References: <20040324235702.GA497@elf.ucw.cz> <20040325073244.GE3377@suse.de> <20040325115129.GB300@elf.ucw.cz> <20040325121418.GK3377@suse.de> <20040325150129.GI1505@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325150129.GI1505@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25 2004, Pavel Machek wrote:
> Hi!
> 
> > > I actually ran it on real 2GB machine, and it seemed to do the trick,
> > > unless "too much" memory was full.
> > 
> > Well your patch really looked nothing more than a nasty hack, since it
> > has known and very real failures. Why do you need to copy all highmem
> > down to low mem? That cannot _ever_ work reliably?!
> 
> Because it is only solution I know that does not require rewriting half
> the kernel or rewriting all the block drivers. (see how swsusp already
> does copy of lowmem).

I don't understand, why would you need to rewrite block drivers?! Either
way, your patch surely is a bad idea no matter what way you look at it.

> Having special "poll" mode for block drivers might do the trick, but
> thats lot of work.

Maybe I'm missing something, but why doesn't the regular io paths work?

> Which operations are allowed to access highmem? Can I rely on
> block device read/write not accessing highmem?

You mean modify highmem pages, or?

-- 
Jens Axboe

