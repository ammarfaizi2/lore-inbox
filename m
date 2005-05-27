Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVE0GVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVE0GVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVE0GVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:21:08 -0400
Received: from brick.kernel.dk ([62.242.22.158]:51845 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261824AbVE0GU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:20:58 -0400
Date: Fri, 27 May 2005 08:21:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ide-cd problem in 2.6.12-rc5 + todays snapshot
Message-ID: <20050527062155.GG1435@suse.de>
References: <Pine.SOC.4.61.0505261816190.28439@math.ut.ee> <20050526171425.GX1419@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526171425.GX1419@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jens Axboe wrote:
> On Thu, May 26 2005, Meelis Roos wrote:
> > Background: I have a Sony CDU5211 CD drive with Intel D815EEA2 mainboard 
> > (ICH2 IDE in 815 chipset). Since 2.4.21 timeframe IDE DMA for this CD 
> > drive is broken (see my post 
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/0480.html). This 
> > happens on at least 2 identical machines. This is the first problem 
> > (that I have learned to live with).
> > 
> > Now, since ide-cd dma is broken, the first access to cd always gets DMA 
> > timeout and turns off DMA, then it works. I have hddtemp installed and 
> > it probes for drives on boot. In 2.6.12 (and I think I tested pristine 
> > 2.6.12-rc5 too) the cd works as before - dma timeout+disable on first 
> > access (by hddtemp).
> > 
> > Now, in 2.6.12-rc5 + todays git snapshot, it does not work any more. I 
> > suspect the DMA alignment change.
> 
> It must be, thanks for reporting this so quickly. Linus, can you exclude
> that patch again? Rather miserably slow burning for some, than broken
> hardware for others.
> 
> Seems we do need finer granularity setting of alignment/length
> restrictions.

BTW Meelis, any chance you can change that 3 into a 15 for testing
purposes?

-- 
Jens Axboe

