Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932945AbWFMHSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbWFMHSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932947AbWFMHSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:18:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16620 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932945AbWFMHSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:18:35 -0400
Date: Tue, 13 Jun 2006 08:18:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Miller <davem@davemloft.net>
Cc: ak@suse.de, jeremy@goop.org, lkml@rtr.ca, mpm@selenic.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
Message-ID: <20060613071819.GB16358@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Miller <davem@davemloft.net>, ak@suse.de, jeremy@goop.org,
	lkml@rtr.ca, mpm@selenic.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <200606130547.49624.ak@suse.de> <20060612.214948.124554804.davem@davemloft.net> <200606130654.14477.ak@suse.de> <20060612.220346.71553967.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612.220346.71553967.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 10:03:46PM -0700, David Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Tue, 13 Jun 2006 06:54:14 +0200
> 
> > I guess if you use 1394 with remote DMA for other protocols (like
> > video etc.) there must be some way for the subsystem to map
> > the memory even on IOMMU systems. I admit I haven't dived that
> > deeply into the 1394 subsystem so I don't know how that works.
> 
> Video-1394 has it's own driver, which does a consistent DMA
> allocation, and then maps that into userspace using remap_pfn_range().
> Entirely portable.

That's actually not portable to certain arm platforms, but that's
a different story.

