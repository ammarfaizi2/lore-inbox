Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUIIODK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUIIODK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUIIOB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:01:58 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37081 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264377AbUIIN4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:56:25 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Date: Thu, 9 Sep 2004 15:54:41 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200409082126.49832.bzolnier@elka.pw.edu.pl> <413FCB61.7060604@pobox.com>
In-Reply-To: <413FCB61.7060604@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091554.41718.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 09 September 2004 05:17, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> > +{
> > +	memset(sg, 0, sizeof(*sg));
> > +
> > +	sg->page = virt_to_page(buf);
> > +	sg->offset = offset_in_page(buf);
> > +	sg->length = buflen;
> > +}
> > +
> 
> 
> Surely this should be more generic?

Any idea where to put it? linux/blkdev.h?
