Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270827AbRH1Mki>; Tue, 28 Aug 2001 08:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRH1Mk2>; Tue, 28 Aug 2001 08:40:28 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:37892 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S270827AbRH1MkQ>; Tue, 28 Aug 2001 08:40:16 -0400
Date: Tue, 28 Aug 2001 14:43:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
Message-ID: <20010828144326.R642@suse.de>
In-Reply-To: <20010827123700.B1092@suse.de> <m3itf85vlr.fsf@linux.local> <20010828125520.L642@suse.de> <20010828134141.M642@suse.de> <m3ae0k5qic.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ae0k5qic.fsf@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28 2001, Christoph Rohland wrote:
> Hi Jens,
> 
> On Tue, 28 Aug 2001, Jens Axboe wrote:
> > Ok found the bug -- SCSI was accidentally using blk_seg_merge_ok
> > when it just wanted to test if we were crossing a 4GB physical
> > address boundary or not. Doh! Attached incremental patch should fix
> > the SCSI performance issue. I'm testing right now...
> 
> Yup, performance is back to 2.4.9 level. But I do not see an
> improvement.
> 
> I will now do a database import.

Of course it depends on the type of work load how big an improvement you
see. How much RAM is in the machine?

It would be interesting to see profiles of stock + highmem kernels.

-- 
Jens Axboe

