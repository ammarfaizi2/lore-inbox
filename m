Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285409AbRLNQZl>; Fri, 14 Dec 2001 11:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285404AbRLNQYt>; Fri, 14 Dec 2001 11:24:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28677 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285407AbRLNQYV>;
	Fri, 14 Dec 2001 11:24:21 -0500
Date: Fri, 14 Dec 2001 17:24:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Stephen Lord <lord@sgi.com>
Cc: "David S. Miller" <davem@redhat.com>, gibbs@scsiguy.com,
        LB33JM16@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
Message-ID: <20011214162403.GE1180@suse.de>
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com> <1008277112.22093.7.camel@jen.americas.sgi.com> <1008278244.22208.12.camel@jen.americas.sgi.com> <20011213.132734.38711065.davem@redhat.com> <20011214151642.GE30529@suse.de> <20011214161506.GB1180@suse.de> <3C1A27FA.7000807@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1A27FA.7000807@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Stephen Lord wrote:
> >--- linux/drivers/scsi/sym53c8xx.c~	Fri Dec 14 11:10:38 2001
> >+++ linux/drivers/scsi/sym53c8xx.c	Fri Dec 14 11:10:51 2001
> >@@ -12174,7 +12174,7 @@
> >
> >		use_sg = map_scsi_sg_data(np, cmd);
> >		if (use_sg > MAX_SCATTER) {
> >-			unmap_scsi_sg_data(np, cmd);
> >+			unmap_scsi_data(np, cmd);
> >			return -1;
> >		}
> >		data = &cp->phys.data[MAX_SCATTER - use_sg];
> >
> There is one of these in ncr53c8xx.c as well, line 8135

Agrh crap, thanks Steve!

-- 
Jens Axboe

