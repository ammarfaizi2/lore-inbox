Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbUBONLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 08:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbUBONLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 08:11:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25802 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264598AbUBONLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 08:11:31 -0500
Date: Sun, 15 Feb 2004 14:11:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jim Gifford <maillist@jg555.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] -- Fixes KCONFIG for initrd
Message-ID: <20040215131123.GR1308@fs.tum.de>
References: <0da201c3f2d8$78c9e1a0$d300a8c0@W2RZ8L4S02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da201c3f2d8$78c9e1a0$d300a8c0@W2RZ8L4S02>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 12:56:44AM -0800, Jim Gifford wrote:
> Description: Prevents initrd from being built if ram device is built
>              as a module.
> 
> --- linux-2.6.2/drivers/block/Kconfig.orig    2004-02-14 08:47:03.911807371
> +0000
> +++ linux-2.6.2/drivers/block/Kconfig 2004-02-14 08:49:37.739118285 +0000
> @@ -313,6 +313,7 @@
> 
>  config BLK_DEV_INITRD
>         bool "Initial RAM disk (initrd) support"
> +       depends on BLK_DEV_RAM && BLK_DEV_RAM!=m
>...

          depends on BLK_DEV_RAM=y


> Jim Gifford

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

