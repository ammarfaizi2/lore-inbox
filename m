Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUKVQzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUKVQzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUKVQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:53:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45325 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262212AbUKVQvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:51:48 -0500
Date: Mon, 22 Nov 2004 17:51:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-ID: <20041122165145.GH19419@stusta.de>
References: <20041121220251.GE13254@stusta.de> <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de> <1101140745.9784.7.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101140745.9784.7.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:25:45PM +0300, Evgeniy Polyakov wrote:
> On Mon, 2004-11-22 at 14:33 +0100, Adrian Bunk wrote:
> > On Mon, Nov 22, 2004 at 10:31:12AM +0300, Evgeniy Polyakov wrote:
> > > On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> > > > Hi Evgeniy,
> > > 
> > > Hello, Adrian.
> > 
> > Hi Evgeniy,
> > 
> > > > drivers/w1/Makefile in recent 2.6 kernels contains:
> > > >   obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
> > > >   ds9490r-objs    := dscore.o
> > > > 
> > > > Is there a reason, why dscore.c isn't simply named ds9490r.c ?
> > > 
> > > dscore.c is a core function set to work with ds2490 chip.
> > > ds9490* is built on top of it.
> > > Any vendor can create it's own w1 bus master using this chip, 
> > > not ds9490.
> > 
> > if it was built on top of it, I'd have expected ds9490r.o to contain 
> > additional object files.
> 
> DS9490 does not have anything except this chip and simple 64bit memory
> chip,
> so it is not needed to have any additional code.
> 
> > How would a different w1 bus master chip look like in 
> > drivers/w1/Makefile?
> 
> obj-m: proprietary_module.o
> proprietary_module-objs: dscore.o proprietary_module_init.o
> 
> Actually it will live outside the kernel tree, but will require ds2490
> driver.
> It could be called ds2490.c but I think dscore is better name.

Why are you talking about proprietary modules living outside the kernel 
tree?

The only interesting case is the one of modules shipped with the kernel.
And for them, this will break at link time if two such modules are 
included statically into the kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

