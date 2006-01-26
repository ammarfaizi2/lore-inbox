Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWAZXB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWAZXB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWAZXB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:01:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030197AbWAZXBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:01:55 -0500
Date: Fri, 27 Jan 2006 00:01:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vasil Kolev <vasil@ludost.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com,
       linux-ide@vger.kernel.org
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
Message-ID: <20060126230152.GP3668@stusta.de>
References: <1138093728.5828.8.camel@lyra.home.ludost.net> <20060124223527.GA26337@kroah.com> <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com> <1138175680.5857.4.camel@lyra.home.ludost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138175680.5857.4.camel@lyra.home.ludost.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 09:54:40AM +0200, Vasil Kolev wrote:
> ?? ????, 2006-01-24 ?? 23:58 +0100, Bartlomiej Zolnierkiewicz ????????????:
> > On 1/24/06, Greg KH <greg@kroah.com> wrote:
> > > On Tue, Jan 24, 2006 at 11:08:47AM +0200, Vasil Kolev wrote:
> > > > Hello,
> > > > I have a machine that's currently running 2.4.28 with the promise_old
> > > > driver, which runs ok. I tried upgrading it last night to 2.6.15, and
> > > > the following error occured, and no drives were detected/made available:
> > > >
> > > >  [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
> > > >  [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
> > > >  [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
> > > >  [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
> > > >  [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
> > > >  [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0x7d/0x84
> > > >  [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_driver+0x13/0x35
> > > >  [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 [pdc202xx_old]
> > > >  [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
> > > >  [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb
> > >
> > > This means that some other driver tried to register with the same exact
> > > name for the same bus.  As it looks like this is the ide bus, I suggest
> > > asking on the linux ide mailing list.
> > 
> 
> Well, now I remember that in /sys in the proper place there were two
> directories called Promise_Old_IDE, maybe the driver tried to register
> twice?
>...

Greg, IIRC, weren't there plans to turn this case into a BUG()?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

