Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266398AbUAVTnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266405AbUAVTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:43:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14060 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266398AbUAVTnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:43:31 -0500
Date: Thu, 22 Jan 2004 20:43:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alex <alex@meerkatsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot Set DMA via hdparm
Message-ID: <20040122194322.GN6441@fs.tum.de>
References: <4000230D.109@meerkatsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4000230D.109@meerkatsoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 01:06:37AM +0900, Alex wrote:

> Hi,

Hi Alex,

> I am having problems settng the DMA ( hdparm -d1 /dev/hda ) on a RH9 
> 2.4.28 Linux machine.

I assume you are talking about 2.4.18?

> I always get the following error messages:
> 
> HDIO_SET_DMA failed: Operatopm mpt @er,otted
> using_dma = 0 (off)
> 
> The Disk ST3120026A is properly recognized. It appears that the 
> motherboard is not supported. ( I am running linux on a Shuttle XPC with 
> the ATI Radeon 9100IGP / IXP150 Chipset.
> 
> Has anyone an idea how to get this dma setting work ?
> Will that chipset be supported in the future ?

It seems some experimental support for your chipset was added in later 
2.4 kernels.

Could you try whether kernel 2.4.24 with the alim15x3 driver available 
in the kernel configuration at

  ATA/IDE/MFM/RLL support
    ATA/IDE/MFM/RLL support
    IDE, ATA and ATAPI Block devices
      PCI IDE chipset support
      Generic PCI bus-master DMA support
      ALI M15x3 chipset support

works for you?

> Thanks
> Alex

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

