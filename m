Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270566AbTGSVuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 17:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270553AbTGSVuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 17:50:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20686 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270566AbTGSVtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 17:49:06 -0400
Date: Sun, 20 Jul 2003 00:03:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030719220356.GA6942@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com> <20030704121124.GB12633@fs.tum.de> <20030715224732.GA31942@neo.rr.com> <20030716182251.GW10191@fs.tum.de> <20030716184317.GC31942@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716184317.GC31942@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:43:17PM +0000, Adam Belay wrote:
> 
> Hi Adrian,

Hi Adam,

> Thanks for the information, I think I have a good idea of whats going here.
>...

thanks for looking into my problem.  :-)

> Could I see the following?
> 
> 1.) the output of /proc/dma

# cat /proc/dma 
 4: cascade
# 

> 2.) the output of
> # cd /sys/bus/pnp/devices
> # find */resources | xargs cat | grep dma

/sys/bus/pnp/devices# find */resources | xargs cat | grep dma
dma 4
dma 2
dma 3
dma 1
dma disabled
/sys/bus/pnp/devices# 

> 3.) the output of
> # cd /sys/bus/pnp/devices
> # find */resources | xargs cat | grep io

#  find */resources | xargs cat | grep io
io 0x20-0x21
io 0xa0-0xa1
io 0x0-0xf
io 0x81-0x83
io 0x87-0x87
io 0x89-0x8b
io 0x8f-0x91
io 0xc0-0xdf
io 0x40-0x43
io 0x70-0x71
io 0x60-0x60
io 0x64-0x64
io 0x61-0x61
io 0xf0-0xff
io 0x4d0-0x4d1
io 0xcf8-0xcff
io 0x480-0x48f
io 0x5000-0x507f
io 0x5080-0x50ff
io 0x208-0x20f
io 0x3f8-0x3ff
io 0x3f2-0x3f5
io 0x378-0x37f
io 0x778-0x77a
io 0x2f8-0x2ff
io 0x220-0x22f
io 0x388-0x38b
io 0x500-0x50f
io 0x330-0x331
/sys/bus/pnp/devices# 


> Also there is a kernel parameter to allow dma 0.  It is 'allowdma0' and
> I predict the extra dma will get the sound card working.

Yup, it works.  :-)))

> Thanks,
> Adam

Thanks
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

