Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbTC0XMP>; Thu, 27 Mar 2003 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTC0XMP>; Thu, 27 Mar 2003 18:12:15 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:48342 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261460AbTC0XMO>; Thu, 27 Mar 2003 18:12:14 -0500
Date: Thu, 27 Mar 2003 15:34:51 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.recent: device_remove_file() doesn't
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, andmike@us.ibm.com
Message-id: <3E838A9B.8040707@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <Pine.LNX.4.33.0303271154080.1001-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, it resolved that problem.

- Dave


> --- 1.84/fs/sysfs/inode.c	Tue Mar 11 15:30:18 2003
> +++ edited/fs/sysfs/inode.c	Thu Mar 27 11:53:44 2003
> @@ -97,7 +97,7 @@
>  				 atomic_read(&victim->d_count));
>  
>  			simple_unlink(dir->d_inode,victim);
> -
> +			d_delete(victim);
>  		}
>  		/*
>  		 * Drop reference from sysfs_get_dentry() above.
> 
> 



