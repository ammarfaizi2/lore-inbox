Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTFFRxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTFFRxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:53:23 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:45316 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262135AbTFFRxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:53:22 -0400
Subject: Re: problem with blk_queue_bounce_limit()
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Jun 2003 14:06:12 -0400
Message-Id: <1054922774.1753.53.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



       From: Christoph Hellwig <hch@infradead.org>
       Date: Fri, 6 Jun 2003 08:44:10 +0100
    
       PCI_DMA_BUS_IS_PHYS should be a propert of each struct device because
       a machine might have a iommu for one bus type but not another,
    
    We know of no such systems.  Even in mixed-bus environments such as
    sparc64 SBUS+PCI systems.
    
Actually, I know of such a system, although, I will admit they're
obscure.  Certain PA-RISC machines with EISA buses have an IOMMU on the
EISA bus alone (not on the GSC bus).  It's job was really to cope with
the ISA DMA issue nicely, but it qualifies.

It was for machines like this that I've already been thinking about
introducing a dma_is_phys(dev) macro, which I originally left out of the
generic device DMA API.

James


