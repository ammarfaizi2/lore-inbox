Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270897AbUJUUhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270897AbUJUUhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270938AbUJUUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:32:30 -0400
Received: from kanga.kvack.org ([66.96.29.28]:5019 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S270897AbUJUU3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:29:24 -0400
Date: Thu, 21 Oct 2004 16:29:04 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/timer.c: xtime lock missing
Message-ID: <20041021202904.GB30847@kvack.org>
References: <20041021190312.GA30847@kvack.org> <1098390198.20778.226.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098390198.20778.226.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 01:23:32PM -0700, john stultz wrote:
> Looking at the comment above that function, the xtime_lock should
> already be held when executing that code. timer_interrupt() should be
> the function which grabs the lock and calls do_timer_interrupt() then
> do_timer() then update_times().
> 
> Or am I missing something?

No, you're right; I'm blind.  That is a very distant chain between where 
the lock is acquired and where it matters, perhaps a few more comments 
are in order.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
