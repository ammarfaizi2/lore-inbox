Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTD2T4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTD2T4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:56:21 -0400
Received: from [195.208.223.247] ([195.208.223.247]:9088 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261618AbTD2T4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:56:20 -0400
Date: Wed, 30 Apr 2003 00:08:07 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: hch@infradead.org, Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030430000807.A731@localhost.park.msu.ru>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru> <wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org> <20030429162322.B5767@jurassic.park.msu.ru> <20030429134100.A30251@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030429134100.A30251@infradead.org>; from hch@infradead.org on Tue, Apr 29, 2003 at 01:41:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 01:41:00PM +0100, Christoph Hellwig wrote:
> If you have a struct device for them you need to set the dma_mask
> and it should better have some parent (real or fake, at least the
> data structures must be setup).  The old NULL argument will stay for
> while.  If at some point all drivers doing that are converted (or
> go away :)) it could be dropped.

Ok, for clean dma_* implementation on alpha (and others, I guess) we need
to move root level IO controller data from struct pci_dev (pdev->sysdata)
to struct dev. Actually, the latter already has such field (platform_data)
but right now it's kind of parisc specific. ;-)
I'll look into it after short vacation (4-5 days).

Ivan.
