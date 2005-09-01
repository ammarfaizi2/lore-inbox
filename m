Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVIAUFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVIAUFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVIAUFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:05:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54192 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030353AbVIAUFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:05:38 -0400
Date: Thu, 1 Sep 2005 21:05:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Brett Russ <russb@emc.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Message-ID: <20050901200532.GA14650@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Brett Russ <russb@emc.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <43175B23.8040803@pobox.com> <20050901195832.GA14602@infradead.org> <43175E8F.7080700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43175E8F.7080700@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:03:27PM -0400, Jeff Garzik wrote:
> Christoph Hellwig wrote:
> >On Thu, Sep 01, 2005 at 03:48:51PM -0400, Jeff Garzik wrote:
> >
> >>Christoph Hellwig wrote:
> >>
> >>>>+#include <linux/kernel.h>
> >>>>+#include <linux/module.h>
> >>>>+#include <linux/pci.h>
> >>>>+#include <linux/init.h>
> >>>>+#include <linux/blkdev.h>
> >>>>+#include <linux/delay.h>
> >>>>+#include <linux/interrupt.h>
> >>>>+#include <linux/sched.h>
> >>>>+#include <linux/dma-mapping.h>
> >>>>+#include "scsi.h"
> >>>
> >>>
> >>>pleaese don't include "scsi.h" in new drivers.  It will go away soon.
> >>>Use the <scsi/*.h> headers and get rid of usage of obsolete constucts
> >>>in your driver.
> >>
> >>
> >>It stays until the rest of the libata drivers lose the include.
> >>
> >>After ATAPI support is done, I can stop 2.4.x support, and this and 
> >>several other compat-isms will go away.
> >
> >
> >NACK.  Jeff, I accept that you don't want to convert old drivers yet,
> >but this is not acceptable for new drivers.  We don't allow it for any
> >new scsi LLDDs, and that includes libata drivers.
> 
> Sorry, you don't get to NAK that change, since it affects 2.4.x 
> maintenance of this new driver.

Stop that crap now please.  Adding "scsi.h" includes is _not_ allowed
for new drivers, period.  There's no exceptions, not even for
Jeff "I'm part of the calal" Garzik.

