Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313802AbSDPSH5>; Tue, 16 Apr 2002 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313805AbSDPSH4>; Tue, 16 Apr 2002 14:07:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22788 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313802AbSDPSHy>;
	Tue, 16 Apr 2002 14:07:54 -0400
Date: Tue, 16 Apr 2002 20:07:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
Message-ID: <20020416180750.GQ1097@suse.de>
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16 2002, Mikael Pettersson wrote:
> I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
> boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:
> 
> 	if (drive->using_tcq) {
> 		int tag = ide_get_tag(drive);
> 
> 		BUG_ON(drive->tcq->active_tag != -1);
> 
> Relevant .config is
> # CONFIG_PCI is not set
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> (That's it. No chipset support selected; neither I nor Linux
> has ever detected any known IDE chipset in this box...)
> 
> Why is drive->using_tcq non-zero when CONFIG_BLK_DEV_IDE_TCQ=n
> and the disk is an early/mid-90s 500MB WD drive?

No ata pci adapter selected, probably. Apply 2.5.8-dj1, it should have
the most interesting parts for you. I'll update my stuff tomorrow.

-- 
Jens Axboe

