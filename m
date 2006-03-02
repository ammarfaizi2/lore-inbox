Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWCBMXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWCBMXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWCBMXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:23:06 -0500
Received: from cantor.suse.de ([195.135.220.2]:22999 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750824AbWCBMXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:23:05 -0500
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 13:25:03 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fQuBESrDJvsZ+Rr"
Message-Id: <200603021325.03560.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_fQuBESrDJvsZ+Rr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry dropped l-k cc by mistake

--Boundary-00=_fQuBESrDJvsZ+Rr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: Andi Kleen <ak@suse.de>: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Content-Disposition: inline;
	filename*=

From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 13:16:37 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>,
 Jeff Garzik <jgarzik@pobox.com>
References: <200603020023.21916@zmi.at> <200603020203.49128.ak@suse.de> <20060302095959.GD4329@suse.de>
In-Reply-To: <20060302095959.GD4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021316.38077.ak@suse.de>

On Thursday 02 March 2006 10:59, Jens Axboe wrote:

[dropping closed suse list. Please never put both closed and open lists
into the same cc list]

> libata should also handle this case better. Usually we just need to
> defer command handling if the dma_map_sg() fails. Changing
> ata_qc_issue() to return nsegments for success, 0 for defer failure, and
> -1 for permanent failure should be enough. The SCSI path is easy at
> least, as we can just ask for a defer there. The internal qc_issue is a
> little more tricky.

Yes I've been thinking about adding a new sleeping interface to the IOMMU
that would block for new space to handle this. If I did that - would libata be 
able to use it?

-Andi

--Boundary-00=_fQuBESrDJvsZ+Rr--
