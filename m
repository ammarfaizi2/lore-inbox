Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319604AbSIMLcq>; Fri, 13 Sep 2002 07:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319605AbSIMLcq>; Fri, 13 Sep 2002 07:32:46 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:18888 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319604AbSIMLcp>; Fri, 13 Sep 2002 07:32:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Jens Axboe <axboe@suse.de>
Subject: Re: 34-mm2 ide problems - unexpected interrupt
Date: Fri, 13 Sep 2002 07:36:36 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200209120838.44092.tomlins@cam.org> <200209121830.51285.tomlins@cam.org> <20020913060647.GH1847@suse.de>
In-Reply-To: <20020913060647.GH1847@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130736.36966.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 13, 2002 02:06 am, Jens Axboe wrote:
> On Thu, Sep 12 2002, Ed Tomlinson wrote:
> > On September 12, 2002 08:42 am, Jens Axboe wrote:
> > > On Thu, Sep 12 2002, Ed Tomlinson wrote:
> > > > Hi,
> > > >
> > > > Got this booting 34-mm2.  Think the are problems with the ide
> > > > updates... UP no preempth.  Everything look ok up to the int loop.
> > >
> > > just delete the printk from ide.c:ide_intr(), it's not useful on
> > > adapters with shared interrupts. patch has already been sent to Linus.
> > >
> > > feedback on success/problems with 34-mm2 (it seems to include bk
> > > patches up until now?) ide would also be appreciated.
> >
> > No luck.  Without the printk it just sits there.  When the printk is
> > enabled there are hundreds (maybe thousands) of messages.
>
> "just sits there" how? It stalls a boot? And where?  Does

It sits at the same point I started getting the unexpected interrupt message.
I waited over five minutes to see if the boot would resume.

> 2.4.20-pre5-ac4 work for you?

I have not built any of the recient ac series - been waiting for a reiserfs patch.
Will try 2.4.20-pre5-ac4 and pre6-acx tonight.

> > I also noticed that DMA was disabled on hda.  This drive works at
> > UDMA2 without any problems.  The drives on promise controller should
> > be able use support UDMA4 but timeout within 24hours when using it.
> > Degrading to UDMA2 lets me go weeks with problems (up to 2.4.19-ac2).
>
> So I'm thinking that you did get it to boot. 

No.  The boot stalled.  The hda stuff is from the dmseg log on a serial 
console.  The other comments on general info on long standing promise 
issues (hopfully fixed in ac).

> Ed, I'm sorry but your report is woefully inadequate to diagnose
> anything :-)

Realize how anemic this report is.  I am willing to get more info on
this - just am not sure what you need or how to get the info.  IDE and
the boot sequence is not an area of the kernel I know much about.  

Please let me know what would give you the best clues.

Meanwhile I wil try the recient ac(s).

Ed




