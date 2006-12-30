Return-Path: <linux-kernel-owner+w=401wt.eu-S1030350AbWL3Vhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWL3Vhr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWL3Vhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 16:37:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1229 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030350AbWL3Vhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 16:37:46 -0500
Date: Sat, 30 Dec 2006 22:37:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Josh Boyer <jwboyer@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Make JFFS depend on CONFIG_BROKEN
Message-ID: <20061230213749.GE20714@stusta.de>
References: <625fc13d0612180525m500fcecdta08edebb3dd526a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0612180525m500fcecdta08edebb3dd526a6@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 07:25:56AM -0600, Josh Boyer wrote:
> Mark JFFS as broken and provide a warning to users that it is
> deprecated and scheduled for removal in 2.6.21
> 
> Signed-off-by: Josh Boyer <jwboyer@gmail.com>
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index b3b5aa0..4ac367d 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -1204,13 +1204,16 @@ config EFS_FS
> 
> config JFFS_FS
> 	tristate "Journalling Flash File System (JFFS) support"
> -	depends on MTD && BLOCK
> +	depends on MTD && BLOCK && BROKEN
> 	help
> 	  JFFS is the Journalling Flash File System developed by Axis
> 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
> 	  file system for disk-less embedded devices. Further information is
> 	  available at (<http://developer.axis.com/software/jffs/>).
> 
> +	  NOTE: This filesystem is deprecated and is scheduled for removal in
> +	  2.6.21.  See Documentation/feature-removal-schedule.txt
>...

$ grep -i jffs Documentation/feature-removal-schedule.txt 
$ 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

