Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269365AbUIYRMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269365AbUIYRMG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUIYRMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:12:06 -0400
Received: from holomorphy.com ([207.189.100.168]:45803 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269365AbUIYRMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:12:01 -0400
Date: Sat, 25 Sep 2004 10:11:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040925171151.GQ9106@holomorphy.com>
References: <20040924014643.484470b1.akpm@osdl.org> <20040925124334.GL9106@holomorphy.com> <20040925163724.GB11525@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925163724.GB11525@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25 2004, William Lee Irwin III wrote:
>> I hope this isn't terribly redundant, but I've tripped over a bogon in
>> 2.6.9-rc2-mm3 similar to the one I reported for 2.6.9-rc2-mm1. The box
>> was actually idle at the time.

On Sat, Sep 25, 2004 at 06:37:27PM +0200, Jens Axboe wrote:
> Same bug, not fixed yet. I'll see if I can get it fixed on monday, I've
> seen it here a few times as well. Seems not to be easily reproducable
> and no real pattern to when it does. In the mean time, you can replace
> the BUG_ON() with a
> 	if (cfqq->allocated[crq->is_write] == 0) {
> 		WARN_ON(1);
> 		cfqq->allocated[crq->is_write] = 1;
> 	}
> and the system should work fine.

I can work with that. I merely thought it may be a useful datapoint to
show that it wasn't a one-off occurrence and/or that it occurred with
multiple kernels with varying combinations of patches and fixes, rather
than pressing the issue per se (though apparently you can reproduce it).
Thanks for looking into it.

-- wli
