Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTD2LIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTD2LIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:08:04 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:42002 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261482AbTD2LID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:08:03 -0400
Date: Tue, 29 Apr 2003 12:20:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429122014.A27520@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
	linux-kernel@vger.kernel.org
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030429150532.A3984@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Apr 29, 2003 at 03:05:32PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 03:05:32PM +0400, Ivan Kokshaysky wrote:
> On Mon, Apr 28, 2003 at 08:38:27PM +0200, Marc Zyngier wrote:
> > As part of my effort to get the Jensen up and running on the latest
> > 2.5 kernels, I have introduced some support for the DMA API, rather
> > than relying on the generic PCI based one (which introduces problems
> > with the EISA bus).
> 
> Since the Jensen is the only non-PCI alpha, I'd really prefer to
> keep existing pci_* functions as is and make dma_* ones just
> wrappers.

Well, pci_* is a legacy API in Linux 2.5 now.  Currently architectures
can either implement dma_* or pci_* and the other one will be emulated,
but I hope we can get rid of this mess soon and dma_* is the one
implemented on the architectures and pci_* emulated in a single
place - and maybe it can go away two stables series from now.

