Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLBQOK>; Sat, 2 Dec 2000 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbQLBQOB>; Sat, 2 Dec 2000 11:14:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129421AbQLBQNr>;
	Sat, 2 Dec 2000 11:13:47 -0500
Date: Sat, 2 Dec 2000 16:42:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
Message-ID: <20001202164234.B31217@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de> <3A2840AB.EE085CAA@thebarn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A2840AB.EE085CAA@thebarn.com>; from cattelan@thebarn.com on Fri, Dec 01, 2000 at 06:22:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01 2000, Russell Cattelan wrote:
> > If performance is down, then that problem is most likely elsewhere.
> > I/O limited benchmarking typically thrives on lots of request
> > latency -- with that comes better throughput for individual threads.
> >
> > > Anyway, I'll try your patch.
> 
> Well this patch does help with the request starvation problem.
> Unfortunately it has introduced another problem.
> Running 4 doio programs, on and XFS partion with KIO buf IO turned on.

This looks like a generic aic7xxx problem, and not block related. Since
you are doing such nice traces, what is the other CPU doing? CPU1
seems to be stuck grabbing the io_request_lock (for reasons not entirely
clear from reading the aic7xxx source...)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
