Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbRAVXMj>; Mon, 22 Jan 2001 18:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131090AbRAVXMS>; Mon, 22 Jan 2001 18:12:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48135 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131022AbRAVXMP>;
	Mon, 22 Jan 2001 18:12:15 -0500
Date: Tue, 23 Jan 2001 00:11:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Steven Cole <scole@lanl.gov>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010123001155.B8225@suse.de>
In-Reply-To: <01012208583400.01639@spc.esa.lanl.gov> <Pine.LNX.4.21.0101221823070.8054-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101221823070.8054-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Jan 22, 2001 at 06:30:03PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22 2001, Marcelo Tosatti wrote:
> 
> Jens, 
> 
> Steven is a seeing a slowdown in his results, too. 
> 
> 
> On Mon, 22 Jan 2001, Steven Cole wrote:
> 
> > On Thursday 18 January 2001 14:49, Marcelo Tosatti wrote:
> > 
> > > Steven,
> > >
> > > The issue is the difference between pre4 and pre8.
> > >
> > > Could you please try pre4 and report results ?
> > >
> > > Thanks
> > 
> > Ok, here are the results for 2.4.1-pre4, along with the original -pre8 
> > results.  There does appear to be a slowdown.
> > 
> > 2.4.1-pre4
> > average:   9.77876 MB/sec
> > 
> > Throughput 10.3677 MB/sec (NB=12.9597 MB/sec  103.677 MBit/sec)
> > Throughput 9.61291 MB/sec (NB=12.0161 MB/sec  96.1291 MBit/sec)
> > Throughput 9.92944 MB/sec (NB=12.4118 MB/sec  99.2944 MBit/sec)
> > Throughput 9.20502 MB/sec (NB=11.5063 MB/sec  92.0502 MBit/sec)
> > 
> > 2.4.1-pre8:
> > Average    9.25707 MB/sec
> > 
> > Throughput 8.93444 MB/sec (NB=11.1681 MB/sec  89.3444 MBit/sec)
> > Throughput 9.43609 MB/sec (NB=11.7951 MB/sec  94.3609 MBit/sec)
> > Throughput 9.5075 MB/sec (NB=11.8844 MB/sec  95.075 MBit/sec)
> > Throughput 9.15026 MB/sec (NB=11.4378 MB/sec  91.5026 MBit/sec)
> > 
> > This was done on a dual P-III, 256MB machine.

Stephen,

To rule out other factors, could you try 2.4.1-pre8 with
blk_started_io() and blk_finished_io() defined to nothing
in include/linux/blkdev.h? This will disable the max-locked-buffers
heuristic.

Also, are the numbers above consistent for repeated runs (with
boots in between)?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
