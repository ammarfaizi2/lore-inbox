Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSILW1E>; Thu, 12 Sep 2002 18:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSILW1E>; Thu, 12 Sep 2002 18:27:04 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:58803 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316860AbSILW1D>; Thu, 12 Sep 2002 18:27:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Jens Axboe <axboe@suse.de>
Subject: Re: 34-mm2 ide problems - unexpected interrupt
Date: Thu, 12 Sep 2002 18:30:51 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200209120838.44092.tomlins@cam.org> <20020912124247.GA11471@suse.de>
In-Reply-To: <20020912124247.GA11471@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209121830.51285.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 12, 2002 08:42 am, Jens Axboe wrote:
> On Thu, Sep 12 2002, Ed Tomlinson wrote:
> > Hi,
> >
> > Got this booting 34-mm2.  Think the are problems with the ide updates...
> > UP no preempth.  Everything look ok up to the int loop.
>
> just delete the printk from ide.c:ide_intr(), it's not useful on adapters
> with shared interrupts. patch has already been sent to Linus.
>
> feedback on success/problems with 34-mm2 (it seems to include bk patches
> up until now?) ide would also be appreciated.

No luck.  Without the printk it just sits there.  When the printk is enabled there are
hundreds (maybe thousands) of messages.  

I also noticed that DMA was disabled on hda.  This drive works at UDMA2 without
any problems.  The drives on promise controller should be able use support UDMA4
but timeout within 24hours when using it.  Degrading to UDMA2 lets me go weeks 
with problems (up to 2.4.19-ac2).

Ed Tomlinson


