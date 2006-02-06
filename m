Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWBFW0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWBFW0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWBFW0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:26:42 -0500
Received: from mail.suse.de ([195.135.220.2]:28389 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932396AbWBFW0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:26:41 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
Date: Mon, 6 Feb 2006 23:13:17 +0100
User-Agent: KMail/1.8.2
Cc: Ryan Richter <ryan@tau.solarneutrino.net>, Brian King <brking@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com> <200602062211.29993.ak@suse.de> <Pine.LNX.4.61.0602062154430.3652@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602062154430.3652@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062313.18041.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 23:11, Hugh Dickins wrote:
> On Mon, 6 Feb 2006, Andi Kleen wrote:
> > On Monday 06 February 2006 17:45, Hugh Dickins wrote:
> > > 
> > > But all this presupposes that someone is suddenly going to change the
> > > x86_64 gart_map_sg (and subfunctions), or else force its iommu=nomerge:
> > > that won't be me.
> > 
> > Ok i changed it to conform to the gospel. I gave it some basic pounding LTP/dd IO with 
> > and without IOMMU force, but it's not that well tested. More testing welcome.
> 
> Great, thanks Andi.  One small correction to the comment...
> 
> > Don't touch the non DMA members in the sg list in dma_map_sg in the IOMMU
> > 
> > Some drivers (in particular ipr) ran into problems because they
> 
> No, the problem hasn't knowingly been sighted on ipr,

Ok. I was wondering anyways why people should use ipr on x86-64.

> it was the 
> st driver that Ryan's been seeing it with - ipr just came from
> my looking around for like instances.

I will fix the comment. Thanks.

-Andi
