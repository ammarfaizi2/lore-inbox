Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTBPKfm>; Sun, 16 Feb 2003 05:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTBPKfm>; Sun, 16 Feb 2003 05:35:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33728 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266233AbTBPKfl>;
	Sun, 16 Feb 2003 05:35:41 -0500
Date: Sun, 16 Feb 2003 11:45:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [BENCHMARK] 2.5.61-mm1 +/- as or cfq with contest
Message-ID: <20030216104503.GV26738@suse.de>
References: <200302162046.42103.kernel@kolivas.org> <20030216095149.GA6521@suse.de> <200302162053.36119.kernel@kolivas.org> <20030216095956.GA6612@suse.de> <20030216024321.7b5a570d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216024321.7b5a570d.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Sun, Feb 16 2003, Con Kolivas wrote:
> > > On Sun, 16 Feb 2003 08:51 pm, Jens Axboe wrote:
> > > > On Sun, Feb 16 2003, Con Kolivas wrote:
> > > > > Here are contest (http://contest.kolivas.org) results with osdl
> > > > > (http://www.osdl.org) hardware for 2.5.61-mm1 with either the as i/o
> > > > > scheduler or the cfq scheduler.
> > > > >
> > > > > io_load:
> > > > > Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> > > > > 2.5.60-mm1          3   112     67.0    15.7    7.1     1.42
> > > > > 2.5.61              2   143     52.4    32.9    13.3    1.81
> > > > > 2.5.61-mm1          2   634     12.5    257.3   24.6    7.83
> > > > > 2.5.61-mm1cfq       3   397     19.6    123.3   18.1    5.03
> > > >
> > > > These loo fishy, could be some other interaction. I'm consistently
> > > > beating 2.5.60-mm1/2.5.61 on io_load here, but that is 2.5.61 base and
> > > > not 2.5.61-mm1 base. Could be something odd happening there.
> > > 
> > > I dont think they're fishy - taken in the mm1 context -. I have tested cfq3a 
> > > without mm1 and it does beat the baseline. See a previous email I posted with 
> > > it.
> > 
> > I didn't mean that you have done something fishy, but that there's a
> > fishy interaction between -mm + CFQ :)
> > 
> 
> It is the CPU scheduler patch.  Con has eariler shown that this patch shoots
> io_load in the head.  2.5.60-mm1 did not have that patch.

and process_load, and dbench_load :)

Thanks, makes sense.

-- 
Jens Axboe

