Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWECVBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWECVBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWECVBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:01:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751345AbWECVBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:01:31 -0400
Subject: Re: How to replace bus_to_virt()?
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0605031615470.29989@chaos.analogic.com>
References: <4454CF35.7010803@s5r6.in-berlin.de>
	 <1146412215.20760.10.camel@laptopd505.fenrus.org>
	 <44554AFE.30804@s5r6.in-berlin.de>
	 <Pine.LNX.4.60.0605032109110.5865@poirot.grange>
	 <Pine.LNX.4.61.0605031615470.29989@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 03 May 2006 23:01:27 +0200
Message-Id: <1146690087.6818.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just make your own macro! When they change the "@(#*%^+@~%" kernel,
> which they will continue to do,

we're not changing 2.6.12. If you don't want changes you can just keep
using the kernel you are using ;)

>  just adapt your macro. You've
> probably already figured out that, for ix86-32 bits (no extended
> addressing), you OR in PAGE_OFFSET. That's an artifact of how the
> pages tables are set up.

and that isn't even possible like that on other architectures, like ones
which have IOMMU's. That is actually the reason stuff like this is
deprecated, and why we have a real API for dma nowadays. 

