Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTAUOEw>; Tue, 21 Jan 2003 09:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTAUOEw>; Tue, 21 Jan 2003 09:04:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41962 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267081AbTAUOEu>; Tue, 21 Jan 2003 09:04:50 -0500
Date: Tue, 21 Jan 2003 15:13:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: groudier@free.fr, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5 patch] MegaRAID driver: remove kernel 2.0 and 2.2 code
Message-ID: <20030121141351.GB6870@fs.tum.de>
References: <20030118162243.GF10647@fs.tum.de> <1043117030.13113.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043117030.13113.15.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 02:43:51AM +0000, Alan wrote:
> On Sat, 2003-01-18 at 16:22, Adrian Bunk wrote:
> > The patch below removes obsolete #if'd code for kernel 2.0 and 2.2 from
> > drivers/scsi/megaraid.{h,c} (this includes the expansion of some
> > #define's that were definded differently for different kernel versions).
> > 
> > I've tested the compilation with 2.5.59.
> 
> AMI still issue 2.2 versions of this driver so its probably excessive
> (AMI ? -- LSI now I guess)

In megaraid.c IO_LOCK_IRQ and IO_UNLOCK_IRQ are only defined for >= 2.4
(they are present since 2.5.1-pre2) and the since Al Viro's
kdev_t -> block_device * conversion you get a compile error when trying 
to use megaraid.{c,h} in 2.2.23.

If it's intended that this file is still used in kernels < 2.4 some
changes are needed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

