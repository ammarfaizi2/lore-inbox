Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTD2MTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTD2MTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:19:50 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:1299 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261871AbTD2MTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:19:49 -0400
Date: Tue, 29 Apr 2003 13:32:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429133202.A29182@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
	linux-kernel@vger.kernel.org
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru> <20030429122014.A27520@infradead.org> <20030429160824.A5767@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030429160824.A5767@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Apr 29, 2003 at 04:08:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 04:08:24PM +0400, Ivan Kokshaysky wrote:
> This won't change the fact that alpha is PCI-centric (as well as
> most other architectures) and in general "struct device" doesn't
> provide sufficient DMA information, unlike "struct pci_dev".
> pci_* being emulated means pci_dev to device translation and then
> rather complex and ugly device to pci_dev translation in arch code.

Well, if you're arch doesn't support any struct device * but those
embedded in struct pci_dev or NULL you don't need to do much
but sticking a to_pci_dev() ontop of each function.

Btw, did you read my posting from Friday on this issue?  The subjects is
'[HEADS UP] planned change to <asm-generic/dma-mapping.h> will cause
+arch breakage'
