Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTGBRGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTGBRGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:06:05 -0400
Received: from ns.suse.de ([213.95.15.193]:9988 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264143AbTGBRGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:06:03 -0400
Date: Wed, 2 Jul 2003 19:19:35 +0200
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       James.Bottomley@steeleye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030702171935.GA32261@wotan.suse.de>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030701.170323.59686965.davem@redhat.com> <20030702022244.030a8acc.ak@suse.de> <20030702165333.GB11739@dsl2.external.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702165333.GB11739@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:53:33AM -0600, Grant Grundler wrote:
> 
> > Maybe I'm missing something but from James description it sounds like the 
> > block layer assumes that it can pass in a sglist with arbitary elements 
> > and get it back remapped to continuous DMA addresses.
> 
> In the x86-64 case, If the 1k elements are not physically contigous,
> I think most of them would get their own mapping.

Yes, but it won't be continguous in bus space.

> 
> For x86-64, if an entry ends on a 4k alignment and the next one starts
> on a 4k alignment, could those be merged into one DMA segment that uses
> two adjacent mapping entries?

Yes, it is now in the version I wrote last night, but not in the 
previous code that's in the tree.

-Andi
