Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTJPG6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 02:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTJPG6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 02:58:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52186 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262441AbTJPG6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 02:58:02 -0400
Date: Thu, 16 Oct 2003 08:57:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mika.penttila@kolumbus.fi, herbert@gondor.apana.org.au, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Message-ID: <20031016065743.GG1128@suse.de>
References: <20031015123722.CSSJ7495.fep07-app.kolumbus.fi@mta.imail.kolumbus.fi> <20031015215134.6f5a0479.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015215134.6f5a0479.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15 2003, David S. Miller wrote:
> On Wed, 15 Oct 2003 15:37:22 +0300
> <mika.penttila@kolumbus.fi> wrote:
> 
> > >It does matter if the driver can't cope with it.
> > 
> > But this fix may hurt performance with well behaving drivers in
> > iommu systems. It's better to fix the broken drivers I think. 
> 
> That's absolutely correct.
> 
> If you add Herbert's change, you will effectively turn off all
> of the IOMMU coalescing benefits we designed into the block layer.
> Please don't apply it, fix the broken drivers instead.

Just changing it to hw segments should be fine, but I agree phys
segments is the wrong check.

-- 
Jens Axboe

