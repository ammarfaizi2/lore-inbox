Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUIIIa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUIIIa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269372AbUIIIa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:30:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16558 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269371AbUIIIa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:30:56 -0400
Date: Thu, 9 Sep 2004 10:29:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
       Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in md write barrier support?
Message-ID: <20040909082922.GN1737@suse.de>
References: <20040903172414.GA6771@lst.de> <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de> <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de> <1094650500.11723.32.camel@localhost.localdomain> <20040908154608.GN2258@suse.de> <1094682098.12280.19.camel@localhost.localdomain> <20040909080612.GJ1737@suse.de> <1094718179.2801.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094718179.2801.3.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Arjan van de Ven wrote:
> 
> > Precisely, it's always possible to just drop queueing depth to zero at
> > that point. If I2O really does reorder around the cache flush (this
> > seems broken...),
> 
> why does this seem broken? semantics of "cache flush guarantees that all
> io submitted prior to it hits the spindle" are quite sane imo; no
> guarantee of later submitted IO.. compare the unix "sync" command; same
> level of semantics.

Depends on your angle, I think it breaks the principle of least
surprise.

-- 
Jens Axboe

