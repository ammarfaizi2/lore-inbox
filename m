Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263889AbRFDVDT>; Mon, 4 Jun 2001 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263887AbRFDVDI>; Mon, 4 Jun 2001 17:03:08 -0400
Received: from 246.35.232.212.infosources.fr ([212.232.35.246]:47109 "HELO
	fjord.dyndns.org") by vger.kernel.org with SMTP id <S263883AbRFDVCy>;
	Mon, 4 Jun 2001 17:02:54 -0400
Date: Mon, 4 Jun 2001 23:02:15 +0200
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide retry on 2.4.5-ac7
Message-ID: <20010604230215.A6188@alezan.dyndns.org>
In-Reply-To: <20010604140207.A529@alezan.dyndns.org> <20010604221404.A19333@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010604221404.A19333@suse.de>; from axboe@suse.de on Mon, Jun 04, 2001 at 10:14:04PM +0200
From: profeta@crans.ens-cachan.fr (PROFETA Mickael)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2001 at 10:14:04PM +0200, Jens Axboe wrote:
> 
> It worked sucessfully for you in 2.4.5-ac4 but not in -ac7? I can't see
> any changes to the patch, so more details on the nature of the problem
> would be helpful.

Ok, this is the results of a hdparm -tT on my second hard disk:

hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide1: reset: success
64 MB in  7.03 seconds =  9.10 MB/sec

and then the kernel has shifted to udma3 and I have no more error in this
session with that hard disk

I tried the same thing on -ac7 and I always have the errors, the kernel does
not reset ide... Looking at the different change on ac patches, I can not see 
why...

Mike
> 
> -- 
> Jens Axboe

