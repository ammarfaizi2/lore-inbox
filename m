Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312970AbSDKVHP>; Thu, 11 Apr 2002 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312971AbSDKVHO>; Thu, 11 Apr 2002 17:07:14 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7922
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312970AbSDKVHN>; Thu, 11 Apr 2002 17:07:13 -0400
Date: Thu, 11 Apr 2002 14:09:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>, Jens Axboe <axboe@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
Message-ID: <20020411210916.GO23513@matchmail.com>
Mail-Followup-To: Zlatko Calusic <zlatko.calusic@iskon.hr>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	"Stephen C. Tweedie" <sct@redhat.com>, Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr> <20020411150219.A10486@infradead.org> <878z7u6tjd.fsf@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 07:20:54PM +0200, Zlatko Calusic wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> > I'm unable to reproduce it here - I only have idle partition though..
> 
> Here is how it looks here (SMP machine, it could matter):
> 
> 
> major minor #blocks name rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
> 
> 34 0 40011552 hdg 23 62 189 70 4 3 32 0 -1 946410 -946410
> 33 0 60051600 hde 8349 18725 214666 108230 3781 15234 152176 91700 -1 927060 -746550
>  3 0 19938240 hda 848 1023 14565 5470 1303 1542 22768 300 -1 942120 -940710
> 
> 
> Notice negative numbers for running, aveq. Kernel is 2.4.19-pre5-ac3.

major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

   3     0   10037774 ide/host0/bus0/target0/lun0/disc 2381496 3602026 12295120 24796300 2167401 11887863 28592436 168474630 -1 849341880 -666064880
   3     1     488344 ide/host0/bus0/target0/lun0/part1 53667 86 430048 544050 18970 47327 535456 2558790 0 499660 3105630
   3     2    9549288 ide/host0/bus0/target0/lun0/part2 2327827 3601934 11865056 24252240 2148431 11840536 28056980 165915840 0 16504720 190278950

2.4.19-pre4-ac3

Did I misunderstand when you reported that statistics were not reported for
partitions in a previous message?  Also -1 only shows up for the drive and
not the partitions.

Mike
