Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUBYQ1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbUBYQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:26:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25069 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261419AbUBYQ0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:26:05 -0500
Date: Wed, 25 Feb 2004 17:25:56 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 adaptec I2O will not compile
Message-ID: <20040225162555.GQ5499@fs.tum.de>
References: <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <Pine.LNX.4.58.0402201350160.20714@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402201350160.20714@dlang.diginsite.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 01:52:24PM -0800, David Lang wrote:
> when attempting to compile in support for the adaptec 2100/3100 series
> Raid card I get the following errors. I have attached my config
> 
>   CC      drivers/scsi/aic7xxx/aic7xxx_pci.o
>   CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
>   CC      drivers/scsi/aic7xxx/aic7xxx_proc.o
>   CC      drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
>   LD      drivers/scsi/aic7xxx/aic7xxx.o
>   LD      drivers/scsi/aic7xxx/built-in.o
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
> root@dlang:/usr/src/linux# make  bzImage
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/asm-i386/asm_offsets.h
>   CHK     include/linux/compile.h
>   CC      drivers/scsi/dpt_i2o.o
> drivers/scsi/dpt_i2o.c:32:2: #error Please convert me to
> Documentation/DMA-mapping.txt
> drivers/scsi/dpt_i2o.c: In function `adpt_install_hba':
> drivers/scsi/dpt_i2o.c:977: warning: passing arg 2 of `request_irq' from
> incompatible pointer type
> drivers/scsi/dpt_i2o.c: In function `adpt_scsi_to_i2o':
> drivers/scsi/dpt_i2o.c:2118: structure has no member named `address'
> include/scsi/scsi_host.h: At top level:
> drivers/scsi/dpt_i2o.c:165: warning: `dptids' defined but not used
> make[2]: *** [drivers/scsi/dpt_i2o.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
>...
> #
> # Automatically generated make config: don't edit
> #
>...
> CONFIG_BROKEN=y
>...

You've disabled
  Code maturity level options
    Select only drivers expected to compile cleanly

> CONFIG_SCSI_DPT_I2O=y
>...

This driver is known to not compile in 2.6 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

