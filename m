Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291193AbSAaRlf>; Thu, 31 Jan 2002 12:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291195AbSAaRlZ>; Thu, 31 Jan 2002 12:41:25 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:35491 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291193AbSAaRlI>; Thu, 31 Jan 2002 12:41:08 -0500
Date: Thu, 31 Jan 2002 12:41:07 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201311741.g0VHf7c15207@devserv.devel.redhat.com>
To: rathamahata@php4.ru, Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Cc: linux390@de.ibm.com
Subject: Re: [PATCH] fs/partitions/ibm.c compile fixes
In-Reply-To: <mailman.1012486827.28619.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1012486827.28619.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
> +	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo))
> @@ -131,7 +131,7 @@
> -	data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
> +	data = read_dev_sector(bdev, info->label_block*blocksize, &sect);

I did that too, but 2.4.17 does not boot for me on a 31-bit VM.
It's probably not bootable in nature. I wish IBM people updated
actual kernels instead of posting pachsets on developerwoks
website.

-- Pete
