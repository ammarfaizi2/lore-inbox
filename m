Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSKLJOJ>; Tue, 12 Nov 2002 04:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSKLJOJ>; Tue, 12 Nov 2002 04:14:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43750 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266356AbSKLJOH>;
	Tue, 12 Nov 2002 04:14:07 -0500
Date: Tue, 12 Nov 2002 10:20:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021112092045.GB832@suse.de>
References: <3DD046BD.799F36D4@digeo.com> <XFMail.20021112095219.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20021112095219.pochini@shiny.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12 2002, Giuliano Pochini wrote:
> 
> On 12-Nov-2002 Andrew Morton wrote:
> > Con Kolivas wrote:
> >>
> >> io_load:
> >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >> 2.4.18 [3]              474.1   15      36      10      6.64
> >> 2.4.19 [3]              492.6   14      38      10      6.90
> >> 2.5.46 [1]              600.5   13      48      12      8.41
> >> 2.5.46-mm1 [5]          134.3   58      6       8       1.88
> >> 2.5.47 [3]              165.9   46      9       9       2.32
> >> 2.5.47-mm1 [5]          126.3   61      5       8       1.77
> >>
> >
> > We've increased the kernel build speed by 3.6x while decreasing the
> > speed at which writes are retired by 5.3x.
> 
> Did the elevator change between .46 and .47 ?

No, but the fifo_batch count (which controls how many requests are moved
sort list to dispatch queue) was halved. This gives lower latency, at
the possible cost of dimishing throughput.

-- 
Jens Axboe

