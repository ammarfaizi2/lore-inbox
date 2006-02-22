Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWBXWDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWBXWDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWBXWDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:03:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61455 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932597AbWBXWDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:03:13 -0500
Date: Wed, 22 Feb 2006 18:50:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [13/16]
Message-ID: <20060222185059.GC2633@ucw.cz>
References: <1140793524.6400.734.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140793524.6400.734.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  Documentation/filesystems/gfs2.txt |   44 +++++++++++++++++++++++++++++++++++
>  fs/Kconfig                         |    6 ++--
>  fs/Makefile                        |    2 +
>  fs/gfs2/Kconfig                    |   46 +++++++++++++++++++++++++++++++++++++
>  fs/gfs2/Makefile                   |   42 +++++++++++++++++++++++++++++++++
>  5 files changed, 137 insertions(+), 3 deletions(-)
> 
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -883,8 +884,6 @@ config CONFIGFS_FS
>  	  Both sysfs and configfs can and should exist together on the
>  	  same system. One is not a replacement for the other.
>  
> -	  If unsure, say N.
> -

Why? Most users probably still want configfs_fs=N.

> @@ -1327,7 +1326,7 @@ config UFS_FS
>  
>  config UFS_FS_WRITE
>  	bool "UFS file system write support (DANGEROUS)"
> -	depends on UFS_FS && EXPERIMENTAL
> +	depends on UFS_FS && EXPERIMENTAL && BROKEN
>  	help

Well, maybe, but I thought this is gfs2 patch...


> +To use gfs as a local file system, no external clustering systems are
> +needed, simply:
> +
> +  $ mkfs -t gfs2 -p lock_nolock -j 1 /dev/block_device
> +  $ mount -t gfs2 /dev/block_device /dir
> +
> +GFS2 is not on-disk compatible with previous versions of GFS.
> +
> +The following man pages can be found at the URL above:
> +  gfs2_mkfs	to make a filesystem

I thought conventional name would be mkfs.gfs2 ... could you use that
variant?

								Pavel
-- 
Thanks, Sharp!
