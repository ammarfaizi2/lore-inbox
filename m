Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTDXN1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbTDXN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:27:20 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:21779 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263657AbTDXN1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:27:18 -0400
Date: Thu, 24 Apr 2003 14:39:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha1740 update
Message-ID: <20030424143925.A31989@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org> <20030424133641.A29770@infradead.org> <wrpel3st3xa.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrpel3st3xa.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Thu, Apr 24, 2003 at 03:34:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 03:34:25PM +0200, Marc Zyngier wrote:
> >>>>> "CH" == Christoph Hellwig <hch@infradead.org> writes:
> 
> >> +/* This should really fit in driver/scsi/scsi.h, along with
> >> + * scsi_to_{pci,sbus}_dma_dir.... */
> 
> CH> Right.  Please submit a patch to James.
> 
> I think this would cause some troubles. I would have to include
> linux/dma-mapping in driver/scsi/scsi.h, but many non-PCI
> architectures are still including asm-generic/dma-mapping.h, which has
> lots of references to PCI functions... I'm afraid this would clash
> badly on, say, sparc or m68k...

Then make it conditional on COFIG_EISA && CONFIG_MAC for now and
add a big FIXME.  I'll break it at some point then, so I'll get
blamed instead of you :)

