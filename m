Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVI2IAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVI2IAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 04:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVI2IAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 04:00:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:58278 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750831AbVI2IAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 04:00:45 -0400
Date: Thu, 29 Sep 2005 10:00:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ixp4xx MTD driver module build
Message-ID: <20050929080037.GD16687@wohnheim.fh-wedel.de>
References: <20050928234254.GA21547@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050928234254.GA21547@plexity.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 September 2005 16:42:54 -0700, Deepak Saxena wrote:
> 
> Missing ';' breaks module build.
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
> diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
> --- a/drivers/mtd/maps/ixp4xx.c
> +++ b/drivers/mtd/maps/ixp4xx.c
> @@ -254,6 +255,6 @@ module_init(ixp4xx_flash_init);
>  module_exit(ixp4xx_flash_exit);
>  
>  MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("MTD map driver for Intel IXP4xx systems")
> +MODULE_DESCRIPTION("MTD map driver for Intel IXP4xx systems");
>  MODULE_AUTHOR("Deepak Saxena");

Applied to mtd cvs.  (Actually, with cvs it was easier to just redo
the change myself, but basically...)

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
