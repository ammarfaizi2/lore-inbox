Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSKHLgx>; Fri, 8 Nov 2002 06:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSKHLgx>; Fri, 8 Nov 2002 06:36:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39111 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261848AbSKHLgw>;
	Fri, 8 Nov 2002 06:36:52 -0500
Date: Fri, 8 Nov 2002 12:43:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021108114318.GX32005@suse.de>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee> <20021108015316.GA1041@www.kroptech.com> <3DCB1D09.EE25507D@digeo.com> <20021108024905.GA10246@www.kroptech.com> <20021108080558.GR32005@suse.de> <20021108111428.F628@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108111428.F628@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08 2002, Ingo Oeser wrote:
> Hi Jens,
> 
> On Fri, Nov 08, 2002 at 09:05:58AM +0100, Jens Axboe wrote:
> > Ok I'm just about convinced now, I'll make 16 the default batch count.
> > I'm very happy to hear that the deadline scheduler gets the job done
> > there.
> 
> Isn't it exactly seek_cost, which you want?

Yes it's one request for a non-contig range, or a number of contig ones.
It isn't quite clear that this is always a good thing. Since we are
moving request from the sorted list, there's a chance that even though
serving X and then X+1 will incur a seek, it will be a small one. But
for now, yes, a seek is a seek and 16 is equal to seek_cost and
therefore it will be just the one.

> Would you like to make it tunable from user space somehow?

Yes of course, that has been the plan all along. I'm in fact doing that
right now.

> Since Adam already noticed, that there might not be a "perfect"
> value for all, this is the logical next step.

Noone ever questioned the fact that these tunables should in fact be
tunable.

> PS: If you update, please consider an update of your comments
>    there, too ;-)

Patch is sent hours ago, and I did.

-- 
Jens Axboe

