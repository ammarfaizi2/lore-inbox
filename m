Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269833AbUIDIWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269833AbUIDIWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269835AbUIDIWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:22:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269833AbUIDIWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:22:38 -0400
Date: Sat, 4 Sep 2004 10:21:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: bug in md write barrier support?
Message-ID: <20040904082121.GB2343@suse.de>
References: <20040903172414.GA6771@lst.de> <16697.4817.621088.474648@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16697.4817.621088.474648@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04 2004, Neil Brown wrote:
> On Friday September 3, hch@lst.de wrote:
> > md_flush_mddev just passes on the sector relative to the raid device,
> > shouldn't it be translated somewhere?
> 
> Yes.  md_flush_mddev should simply be removed.  
> The functionality should be, and largely is, in the individual
> personalities. 

Yes, sorry I was a little lazy there even though I followed the plugging
conversion :(

> Is there documentation somewhere on exactly what an issue_flush_fn
> should do (is it  allowed to sleep? what must happen before it is
> allowed to return, what is the "error_sector" for,  that sort of thing).

It is allowed to sleep, you should return when the flush is complete.
error_sector is the failed location, which really should be a dev,sector
tupple.

-- 
Jens Axboe

