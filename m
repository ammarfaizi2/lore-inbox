Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSA3HyD>; Wed, 30 Jan 2002 02:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSA3Hxy>; Wed, 30 Jan 2002 02:53:54 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:19372 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S288827AbSA3Hxn>; Wed, 30 Jan 2002 02:53:43 -0500
Message-Id: <200201291649.g0TGnnD8001332@tigger.cs.uni-dortmund.de>
To: vda@port.imtp.ilyichevsk.odessa.ua
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs 
In-Reply-To: Message from Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> 
   of "Mon, 28 Jan 2002 23:20:32 -0200." <200201282120.g0SLKUE24961@Port.imtp.ilyichevsk.odessa.ua> 
Date: Tue, 29 Jan 2002 17:49:49 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:

[...]

> diff -u --recursive linux-2.4.18-pre6mhv_ll/fs/devfs/base.c 
> linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c
> --- linux-2.4.18-pre6mhv_ll/fs/devfs/base.c     Fri Jan 25 15:49:53 2002
> +++ linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c       Mon Jan 28 23:05:44 
> 2002
> @@ -3490,8 +3489,8 @@
>      int err;
> 
>      if ( !(boot_options & OPTION_MOUNT) ) return;
> -    err = do_mount ("none", "/dev", "devfs", 0, "");
> -    if (err == 0) printk ("Mounted devfs on /dev\n");
> +    err = do_mount ("devfs", "/dev", "devfs", 0, "");
> +    if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
>      else printk ("Warning: unable to mount devfs, err: %d\n", err);
                    ^^^^^
                     Missed this one
>  }   /*  End Function mount_devfs_fs  */
-- 
Horst von Brand			     http://counter.li.org # 22616
