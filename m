Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131456AbRAXREm>; Wed, 24 Jan 2001 12:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRAXREY>; Wed, 24 Jan 2001 12:04:24 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:34963 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129764AbRAXREM>; Wed, 24 Jan 2001 12:04:12 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Wed, 24 Jan 2001 10:03:41 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <01012208583400.01639@spc.esa.lanl.gov> <01012409085700.02477@spc.esa.lanl.gov> <20010124174439.W16110@suse.de>
In-Reply-To: <20010124174439.W16110@suse.de>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
MIME-Version: 1.0
Message-Id: <01012410034100.03192@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 January 2001 09:44, Jens Axboe wrote:
> On Wed, Jan 24 2001, Steven Cole wrote:
> > > Thanks! Could I talk you into doing one last run? pre8 with
> > > include/linux/elevator.h having these values set for
> > > ELEVATOR_LINUS:
> >
> > Here are two sets of dbench 48 runs with that mod. I can't explain why
> > the second set is faster.  The second set was performed with no reboot
> > after the first set.  The individual runs were performed with no wait
> > in-between.
>
> Was this the 2.4.1-pre8x tree? Regardless, it's about back to the

Yes, that kernel included the other change which was to blkdev.h which 
you suggested.  I ran dbench 48 four more times right after the previous 
email.  Here are those results, using exactly the same kernel (2.4.1-pre8 
with changes to blkdev.h and elevator.h).

Throughput 9.52243 MB/sec (NB=11.903 MB/sec  95.2243 MBit/sec)
Throughput 9.98258 MB/sec (NB=12.4782 MB/sec  99.8258 MBit/sec)
Throughput 9.41459 MB/sec (NB=11.7682 MB/sec  94.1459 MBit/sec)
Throughput 9.23102 MB/sec (NB=11.5388 MB/sec  92.3102 MBit/sec)

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
