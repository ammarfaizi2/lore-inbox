Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVHHNqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVHHNqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVHHNqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:46:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21145 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750888AbVHHNqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:46:34 -0400
Date: Mon, 8 Aug 2005 15:46:26 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/Kconfig: quota help text updates
Message-ID: <20050808134626.GB7541@atrey.karlin.mff.cuni.cz>
References: <20050806132254.GS4029@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806132254.GS4029@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Looks fine. Giving CC to Andrew to queue it for inclusion. Andrew,
can you please also add

  Signed-off-by: Jan Kara <jack@suse.cz>

							Thanks
								Honza


> This patch contains the following updates to the help texts:
> - QUOTA: most people will get the quota utilities from their 
>          distribution, and if not the mini-HOWTO will tell them
> - QFMT_V2: quota utilities 3.01 are no longer recent, they are now 
>            ancient
>            and 3.01 is lower than the minimal version documented in
>            Documentation/Changes
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  fs/Kconfig |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.13-rc4-mm1-full/fs/Kconfig.old	2005-08-06 15:13:43.000000000 +0200
> +++ linux-2.6.13-rc4-mm1-full/fs/Kconfig	2005-08-06 15:14:59.000000000 +0200
> @@ -405,18 +405,16 @@
>  config QUOTA
>  	bool "Quota support"
>  	help
>  	  If you say Y here, you will be able to set per user limits for disk
>  	  usage (also called disk quotas). Currently, it works for the
>  	  ext2, ext3, and reiserfs file system. ext3 also supports journalled
>  	  quotas for which you don't need to run quotacheck(8) after an unclean
> -	  shutdown. You need additional software in order to use quota support
> -	  (you can download sources from
> -	  <http://www.sf.net/projects/linuxquota/>). For further details, read
> -	  the Quota mini-HOWTO, available from
> +	  shutdown.
> +	  For further details, read the Quota mini-HOWTO, available from
>  	  <http://www.tldp.org/docs.html#howto>, or the documentation provided
>  	  with the quota tools. Probably the quota support is only useful for
>  	  multi user systems. If unsure, say N.
>  
>  config QFMT_V1
>  	tristate "Old quota format support"
>  	depends on QUOTA
> @@ -426,16 +424,15 @@
>  	  format say Y here.
>  
>  config QFMT_V2
>  	tristate "Quota format v2 support"
>  	depends on QUOTA
>  	help
>  	  This quota format allows using quotas with 32-bit UIDs/GIDs. If you
> -	  need this functionality say Y here. Note that you will need recent
> -	  quota utilities (>= 3.01) for new quota format with this kernel.
> +	  need this functionality say Y here.
>  
>  config QUOTACTL
>  	bool
>  	depends on XFS_QUOTA || QUOTA
>  	default y
>  
>  config DNOTIFY
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
