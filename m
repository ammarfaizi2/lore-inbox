Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUFSPBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUFSPBC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUFSPBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:01:02 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:17792 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263944AbUFSPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:00:59 -0400
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <m3fz8s79dz.fsf@defiant.pm.waw.pl>
References: <1087481331.2210.27.camel@mulgrave>
	<m33c4tsnex.fsf@defiant.pm.waw.pl> <1087523134.2210.97.camel@mulgrave> 
	<m3fz8s79dz.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Jun 2004 10:00:50 -0500
Message-Id: <1087657251.2162.49.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 18:07, Krzysztof Halasa wrote:
> James Bottomley <James.Bottomley@steeleye.com> writes:
> I don't think so. We already have separate masks for coherent
> and non-coherent mappings (in PCI API, and I'm told it's to be extended
> to DMA API as well). And we need them.
> 
> The problem is we're missing DMA masks for non-alloc calls (depending
> on the platform) and thus that it isn't very reliable. Drivers which
> need this are forced to bounce buffers themselves, and many of them
> will not work on 64-bit platforms (as of ~ 2.6.0, I don't check that
> regularly). And yes, we really need reliable masks for non-alloc
> mappings.

Could you elaborate on this?  In the current scheme the coherent mask is
for descriptor allocation (i.e. dma_alloc_coherent()) and the dma_mask
represents the bus physical addresses to which the device can DMA
directly; there's not much more the DMA API really does, what do you
think is missing?

James


