Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVAXS3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVAXS3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAXS3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:29:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23562 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261557AbVAXS3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:29:30 -0500
Date: Mon, 24 Jan 2005 19:29:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124182926.GM3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 09:43:36PM +0300, Evgeniy Polyakov wrote:
> On Mon, 24 Jan 2005 18:54:49 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > It seems noone who reviewed the SuperIO patches noticed that there are 
> > now two modules "scx200" in the kernel...
> 
> They are almost mutually exlusive(SuperIO contains more advanced), 
> so I do not see any problem here.

The Kconfig files allow building both modular at the same time.

> Only one of them can be loaded in a time.

You are assuming the module support was in able to correctly handle two 
modules with the same name...

> So what does exactly bother you?

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.11-rc2-mm1; fi
WARNING: /lib/modules/2.6.11-rc2-mm1/kernel/drivers/i2c/busses/scx200_i2c.ko needs unknown symbol scx200_gpio_base
WARNING: /lib/modules/2.6.11-rc2-mm1/kernel/drivers/i2c/busses/scx200_i2c.ko needs unknown symbol scx200_gpio_configure
WARNING: /lib/modules/2.6.11-rc2-mm1/kernel/drivers/i2c/busses/scx200_i2c.ko needs unknown symbol scx200_gpio_shadow
WARNING: /lib/modules/2.6.11-rc2-mm1/kernel/drivers/char/scx200_gpio.ko needs unknown symbol scx200_gpio_base
WARNING: /lib/modules/2.6.11-rc2-mm1/kernel/drivers/char/scx200_gpio.ko needs unknown symbol scx200_gpio_configure
WARNING: /lib/modules/2.6.11-rc2-mm1/kernel/drivers/char/scx200_gpio.ko needs unknown symbol scx200_gpio_shadow


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

