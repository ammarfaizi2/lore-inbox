Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUAGVbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266318AbUAGVbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:31:05 -0500
Received: from waste.org ([209.173.204.2]:31675 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266287AbUAGVaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:30:18 -0500
Date: Wed, 7 Jan 2004 15:30:14 -0600
From: Matt Mackall <mpm@selenic.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040107213014.GF18208@waste.org>
References: <20040106054859.GA18208@waste.org> <20040107140640.GC16720@suse.de> <20040107185039.GC18208@waste.org> <20040107211045.GJ16720@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107211045.GJ16720@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For the sake of our other readers, I'll point out that mempool doesn't
> > intrinisically reduce deadlock odds to zero unless we have a hard
> > limit on requests in flight that's strictly less than pool size.
> 
> That's not true, depends entirely on usage. It's not a magic wand. And
> you don't need a hard limit, you only need progress guarentee.

Yes, definitely depends on usage.

> Typically just a single pre-allocated object can make you 100%
> deadlock free, if stacking is not involved. So for most cases, I
> think it would be much better if you just hard wired min_nr to 1,
> that would move you from 90% to 99% safe :-)

Sure, I've considered that. I'll put an option for that on my todo list.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
