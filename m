Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUHLShR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUHLShR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268491AbUHLShR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:37:17 -0400
Received: from havoc.gtf.org ([216.162.42.101]:52912 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268526AbUHLShP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:37:15 -0400
Date: Thu, 12 Aug 2004 14:37:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040812183713.GA29664@havoc.gtf.org>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <20040812173532.GD5136@suse.de> <20040812182914.GA16953@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812182914.GA16953@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 08:29:14PM +0200, Jens Axboe wrote:
>  			close = 1;
> ===== drivers/block/paride/pcd.c 1.38 vs edited =====
> --- 1.38/drivers/block/paride/pcd.c	2004-07-12 10:01:05 +02:00
> +++ edited/drivers/block/paride/pcd.c	2004-08-12 20:26:39 +02:00
> @@ -259,7 +259,7 @@
>  				unsigned cmd, unsigned long arg)
>  {
>  	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
> -	return cdrom_ioctl(&cd->info, inode, cmd, arg);
> +	return cdrom_ioctl(&cd->info, inode, file, cmd, arg);


If you have the struct file, can't you eliminate the inode argument?

	Jeff



