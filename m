Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319532AbSIMGCI>; Fri, 13 Sep 2002 02:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319534AbSIMGCI>; Fri, 13 Sep 2002 02:02:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20359 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319532AbSIMGCI>;
	Fri, 13 Sep 2002 02:02:08 -0400
Date: Fri, 13 Sep 2002 08:06:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 34-mm2 ide problems - unexpected interrupt
Message-ID: <20020913060647.GH1847@suse.de>
References: <200209120838.44092.tomlins@cam.org> <20020912124247.GA11471@suse.de> <200209121830.51285.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209121830.51285.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12 2002, Ed Tomlinson wrote:
> On September 12, 2002 08:42 am, Jens Axboe wrote:
> > On Thu, Sep 12 2002, Ed Tomlinson wrote:
> > > Hi,
> > >
> > > Got this booting 34-mm2.  Think the are problems with the ide updates...
> > > UP no preempth.  Everything look ok up to the int loop.
> >
> > just delete the printk from ide.c:ide_intr(), it's not useful on adapters
> > with shared interrupts. patch has already been sent to Linus.
> >
> > feedback on success/problems with 34-mm2 (it seems to include bk patches
> > up until now?) ide would also be appreciated.
> 
> No luck.  Without the printk it just sits there.  When the printk is
> enabled there are hundreds (maybe thousands) of messages.  

"just sits there" how? It stalls a boot? And where?  Does
2.4.20-pre5-ac4 work for you?

> I also noticed that DMA was disabled on hda.  This drive works at
> UDMA2 without any problems.  The drives on promise controller should
> be able use support UDMA4 but timeout within 24hours when using it.
> Degrading to UDMA2 lets me go weeks with problems (up to 2.4.19-ac2).

So I'm thinking that you did get it to boot.

Ed, I'm sorry but your report is woefully inadequate to diagnose
anything :-)

-- 
Jens Axboe

