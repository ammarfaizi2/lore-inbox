Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTBJHWz>; Mon, 10 Feb 2003 02:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTBJHWy>; Mon, 10 Feb 2003 02:22:54 -0500
Received: from [195.223.140.107] ([195.223.140.107]:43649 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264610AbTBJHWb>;
	Mon, 10 Feb 2003 02:22:31 -0500
Date: Mon, 10 Feb 2003 08:31:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, David Lang <david.lang@digitalinsight.com>,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210073159.GH31401@dualathlon.random>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <Pine.LNX.4.50L.0302100245310.12742-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302100245310.12742-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 02:47:19AM -0200, Rik van Riel wrote:
> On Sun, 9 Feb 2003, Andrew Morton wrote:
> > David Lang <david.lang@digitalinsight.com> wrote:
> > >
> > > note that issuing a fsync should change all pending writes to 'syncronous'
> > > as should writes to any partition mounted with the sync option, or writes
> > > to a directory with the S flag set.
> >
> > We know, at I/O submission time, whether a write is to be waited upon.
> > That's in writeback_control.sync_mode.
> 
> An fsync might change already submitted asynchronous writes
> into synchronous writes, but this is not something I'm going
> to lose sleep over. ;)

correct.

> 
> > That, combined with an assumption that "all reads are synchronous" would
> > allow the outgoing BIOs to be appropriately tagged.
> >
> > It's still approximate.
> 
> Sounds like a good enough approximation to me.

yes, the approximation should be more than enough IMHO

Andrea
