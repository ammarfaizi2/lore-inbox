Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268491AbUHLSnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268491AbUHLSnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUHLSnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:43:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19126 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268491AbUHLSnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:43:52 -0400
Date: Thu, 12 Aug 2004 20:43:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040812184341.GA18035@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <20040812173532.GD5136@suse.de> <20040812182914.GA16953@suse.de> <20040812183713.GA29664@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812183713.GA29664@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2004, Jeff Garzik wrote:
> On Thu, Aug 12, 2004 at 08:29:14PM +0200, Jens Axboe wrote:
> >  			close = 1;
> > ===== drivers/block/paride/pcd.c 1.38 vs edited =====
> > --- 1.38/drivers/block/paride/pcd.c	2004-07-12 10:01:05 +02:00
> > +++ edited/drivers/block/paride/pcd.c	2004-08-12 20:26:39 +02:00
> > @@ -259,7 +259,7 @@
> >  				unsigned cmd, unsigned long arg)
> >  {
> >  	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
> > -	return cdrom_ioctl(&cd->info, inode, cmd, arg);
> > +	return cdrom_ioctl(&cd->info, inode, file, cmd, arg);
> 
> 
> If you have the struct file, can't you eliminate the inode argument?

How so?

-- 
Jens Axboe

