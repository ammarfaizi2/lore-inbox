Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWHGX3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWHGX3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWHGX3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:29:05 -0400
Received: from xenotime.net ([66.160.160.81]:17088 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932349AbWHGX3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:29:04 -0400
Date: Mon, 7 Aug 2006 16:31:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Paul.Clements@steeleye.com
Subject: Re: [PATCH -mm 1/5] nbd: printk format warning
Message-Id: <20060807163147.547b6861.rdunlap@xenotime.net>
In-Reply-To: <20060807230726.GA2724@elf.ucw.cz>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
	<20060807230726.GA2724@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 01:07:26 +0200 Pavel Machek wrote:

> Hi!
> 
> > Fix printk format warning(s):
> > drivers/block/nbd.c:410: warning: long unsigned int format, different type arg (arg 4)
> > 
> 
> ACK, but notice that we have new nbd maintainer... for a few years
> now.

Please notice that I could not find that info in either of
MAINTAINERS or CREDITS.... :(

Please have him/her send a patch.

> 							Pavel
> 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  drivers/block/nbd.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-2618-rc3mm2.orig/drivers/block/nbd.c
> > +++ linux-2618-rc3mm2/drivers/block/nbd.c
> > @@ -407,7 +407,7 @@ static void do_nbd_request(request_queue
> >  		struct nbd_device *lo;
> >  
> >  		blkdev_dequeue_request(req);
> > -		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%lx)\n",
> > +		dprintk(DBG_BLKDEV, "%s: request %p: dequeued (flags=%x)\n",
> >  				req->rq_disk->disk_name, req, req->cmd_type);
> >  
> >  		if (!blk_fs_request(req))
> > 
> > 
> > ---


---
~Randy
