Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTDXNYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbTDXNYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:24:00 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:24081 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263661AbTDXNXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:23:55 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha1740 update
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
	<20030424133641.A29770@infradead.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 24 Apr 2003 15:34:25 +0200
Message-ID: <wrpel3st3xa.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030424133641.A29770@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "CH" == Christoph Hellwig <hch@infradead.org> writes:

>> +/* This should really fit in driver/scsi/scsi.h, along with
>> + * scsi_to_{pci,sbus}_dma_dir.... */

CH> Right.  Please submit a patch to James.

I think this would cause some troubles. I would have to include
linux/dma-mapping in driver/scsi/scsi.h, but many non-PCI
architectures are still including asm-generic/dma-mapping.h, which has
lots of references to PCI functions... I'm afraid this would clash
badly on, say, sparc or m68k...

CH> Well, and as you're touching the driver big time a cleanup to follow
CH> Documentation/CondingStyle would be nice.

I totally agree with the rest of your comments, and will submit an
updated patch shortly.

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
