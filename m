Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUIIPqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUIIPqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIIPqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:46:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48877 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266006AbUIIPkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:40:42 -0400
Date: Thu, 9 Sep 2004 17:38:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Message-ID: <20040909153803.GF1737@suse.de>
References: <200409082126.49832.bzolnier@elka.pw.edu.pl> <200409091554.41718.bzolnier@elka.pw.edu.pl> <20040909144705.GD1737@suse.de> <200409091731.23439.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409091731.23439.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 09 September 2004 16:47, Jens Axboe wrote:
> > On Thu, Sep 09 2004, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > On Thursday 09 September 2004 05:17, Jeff Garzik wrote:
> > > > Bartlomiej Zolnierkiewicz wrote:
> > > > > +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> > > > > +{
> > > > > +	memset(sg, 0, sizeof(*sg));
> > > > > +
> > > > > +	sg->page = virt_to_page(buf);
> > > > > +	sg->offset = offset_in_page(buf);
> > > > > +	sg->length = buflen;
> > > > > +}
> > > > > +
> > > > 
> > > > 
> > > > Surely this should be more generic?
> > > 
> > > Any idea where to put it? linux/blkdev.h?
> > 
> > How about asm/scatterlist.h?
> 
> I would like to avoid duplicating it for every arch
> as it is not arch specific.

Maybe add linux/scatterlist.h then? It should not be in blkdev.h at
least, as it really has nothing to do with block devices.

-- 
Jens Axboe

