Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTD2L5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTD2L5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:57:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22538 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261804AbTD2L5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:57:00 -0400
Date: Tue, 29 Apr 2003 16:08:24 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christoph Hellwig <hch@infradead.org>, Marc Zyngier <mzyngier@freesurf.fr>,
       rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429160824.A5767@jurassic.park.msu.ru>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru> <20030429122014.A27520@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030429122014.A27520@infradead.org>; from hch@infradead.org on Tue, Apr 29, 2003 at 12:20:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 12:20:14PM +0100, Christoph Hellwig wrote:
> Well, pci_* is a legacy API in Linux 2.5 now.  Currently architectures
> can either implement dma_* or pci_* and the other one will be emulated,
> but I hope we can get rid of this mess soon and dma_* is the one
> implemented on the architectures and pci_* emulated in a single
> place - and maybe it can go away two stables series from now.

This won't change the fact that alpha is PCI-centric (as well as
most other architectures) and in general "struct device" doesn't
provide sufficient DMA information, unlike "struct pci_dev".
pci_* being emulated means pci_dev to device translation and then
rather complex and ugly device to pci_dev translation in arch code.
Sigh...

Ivan.
