Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSFORRf>; Sat, 15 Jun 2002 13:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSFORRe>; Sat, 15 Jun 2002 13:17:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20448 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315445AbSFORRd>;
	Sat, 15 Jun 2002 13:17:33 -0400
Date: Sat, 15 Jun 2002 19:17:11 +0200
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020615171711.GH1359@suse.de>
In-Reply-To: <20020615104239.GA30698@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15 2002, rwhron@earthlink.net wrote:
> > One possibile culprit here is the doubling of the request queue size
> > in 2.5.20.  A long time ago it was 1024 slots.  Then it went to
> > 128.  That's where it is in Marcelo kernels.  Then -ac kernels
> > went up to 1024 because they have read-latency2.  Somehow 2.5 found
> > itself at 256 slots.  In 2.5.20 it slealthily snuck up to 512
> > slots.  I didn't squeak about this because I was interested to see what
> > effect it would have.
> 
> Interesting.  I've seen read-latency2 drop dbench throughput in -aa
> kernels (but I use it anyway).  I'd like to capture the request
> queue size.  Is there a command or file in /proc that displays 
> it, or should I just grep drivers/block/ll_rw_blk.c?

There is currently no way you can capture the queue request state. In
the past I've done sysrq hacks to display it, but that's about it.

-- 
Jens Axboe

