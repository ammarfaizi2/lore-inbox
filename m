Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWDUQnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWDUQnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWDUQnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:43:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53514 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751288AbWDUQnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:43:10 -0400
Date: Fri, 21 Apr 2006 18:43:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421164309.GE19754@stusta.de>
References: <1145636558.3856.118.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145636558.3856.118.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 05:22:38PM +0100, Steven Whitehouse wrote:

>...
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
>...
>
>  source "fs/nls/Kconfig"
> +source "fs/dlm/Kconfig"
>...

File doesn't exist

> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_SYSFS)         += sysfs/
>  obj-y                                += devpts/
>
>  obj-$(CONFIG_PROFILING)              += dcookies.o
> +obj-$(CONFIG_DLM)            += dlm/
>...

Directory doesn't exist.

> --- /dev/null
> +++ b/fs/gfs2/Kconfig
> @@ -0,0 +1,46 @@
> +config GFS2_FS
> +        tristate "GFS2 file system support"
> +	default m
> +	depends on EXPERIMENTAL
> +        select FS_POSIX_ACL
> +        select SYSFS
>...

- tabs <-> spaces (tabs are correct)
- please remove the "default m"
- "depends on SYSFS" instead of the select

> +config GFS2_FS_LOCKING_DLM
> +	tristate "GFS2 DLM locking module"
> +	depends on GFS2_FS
> +	select DLM
>...

DLM in -mm depends on IPV6 || IPV6=n, so if you are select'ing it you 
have to add this dependency to GFS2_FS_LOCKING_DLM.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

