Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265438AbUEUHlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUEUHlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 03:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUEUHlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 03:41:22 -0400
Received: from havoc.gtf.org ([216.162.42.101]:2501 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265438AbUEUHlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 03:41:15 -0400
Date: Fri, 21 May 2004 03:41:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ramfs lfs limit
Message-ID: <20040521074112.GA29558@havoc.gtf.org>
References: <20040521073702.GM3044@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521073702.GM3044@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 09:37:02AM +0200, Andrea Arcangeli wrote:
> Hi Andrew,
> 
> this fixes the 2G limit on ramfs
> 
> --- sles/fs/ramfs/inode.c.~1~	2003-10-31 05:54:29.000000000 +0100
> +++ sles/fs/ramfs/inode.c	2004-05-21 07:55:07.394369104 +0200
> @@ -181,6 +181,7 @@ static int ramfs_fill_super(struct super
>  	struct inode * inode;
>  	struct dentry * root;
>  
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;


Why don't we change the default in alloc_super() instead?

We should not default to "lame" :)

	Jeff



