Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTGBRHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTGBRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:06:14 -0400
Received: from ns.suse.de ([213.95.15.193]:15364 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264186AbTGBRGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:06:05 -0400
Date: Wed, 2 Jul 2003 19:20:26 +0200
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andi Kleen <ak@suse.de>, James Bottomley <James.Bottomley@steeleye.com>,
       axboe@suse.de, davem@redhat.com, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030702172026.GB32261@wotan.suse.de>
References: <1057077975.2135.54.camel@mulgrave> <20030702015701.6007ac26.ak@suse.de> <20030702165510.GC11739@dsl2.external.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702165510.GC11739@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:55:10AM -0600, Grant Grundler wrote:
> On Wed, Jul 02, 2003 at 01:57:01AM +0200, Andi Kleen wrote:
> > The K8 IOMMU cannot support this virtually contiguous thing. The reason
> > is that there is no guarantee that an entry in a sglist is a multiple
> > of page size.  And the aperture can only map 4K sized chunks, like 
> > a CPU MMU. So e.g. when you have an sglist with multiple 1K entries there is 
> > no way to get them continuous in IOMMU space (short of copying)
> 
> Can two adjacent IOMMU entries be used to map two 1K buffers?
> Assume the 1st buffer ends on a 4k alignment and the next one
> starts on a 4k alignment.

Yes, it could. But is that situation likely/worth to handle? 

-Andi
