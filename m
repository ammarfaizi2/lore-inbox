Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUIIPhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUIIPhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUIIPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:37:33 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:49382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S265930AbUIIPe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:34:29 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Date: Thu, 9 Sep 2004 17:31:23 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200409082126.49832.bzolnier@elka.pw.edu.pl> <200409091554.41718.bzolnier@elka.pw.edu.pl> <20040909144705.GD1737@suse.de>
In-Reply-To: <20040909144705.GD1737@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091731.23439.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 16:47, Jens Axboe wrote:
> On Thu, Sep 09 2004, Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Thursday 09 September 2004 05:17, Jeff Garzik wrote:
> > > Bartlomiej Zolnierkiewicz wrote:
> > > > +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> > > > +{
> > > > +	memset(sg, 0, sizeof(*sg));
> > > > +
> > > > +	sg->page = virt_to_page(buf);
> > > > +	sg->offset = offset_in_page(buf);
> > > > +	sg->length = buflen;
> > > > +}
> > > > +
> > > 
> > > 
> > > Surely this should be more generic?
> > 
> > Any idea where to put it? linux/blkdev.h?
> 
> How about asm/scatterlist.h?

I would like to avoid duplicating it for every arch
as it is not arch specific.
