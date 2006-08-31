Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWHaKpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWHaKpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHaKpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:45:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42640 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750807AbWHaKpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:45:45 -0400
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 3/6] fault-injection capability for alloc_pages()
Date: Thu, 31 Aug 2006 12:45:40 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
References: <20060831100756.866727476@localhost.localdomain> <200608311225.02101.ak@suse.de> <20060831103528.GA14783@miraclelinux.com>
In-Reply-To: <20060831103528.GA14783@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311245.40578.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 12:35, Akinobu Mita wrote:
> On Thu, Aug 31, 2006 at 12:25:02PM +0200, Andi Kleen wrote:
> 
> > I still think this will need some better filters to be useful. At least
> > a optional uid filter perhaps (make sure to handle the interrupt case
> > correctly, interrupts don't belong to the uid) , and perhaps an option to only 
> > fail GFP_ATOMIC.
> 
> I wrote process filter.

Oops sorry. I overlooked that.

> Please patch 6/6. But I forgot to ignore 
> in_interrupt() case.

Ok fine then.

> 
> > With arbitary failing the system will just be unusable, right? Or would
> > you run some system you use this way? @)
> > 
> > Another possibility would be to look up __builtin_return_address(0) in 
> > the module table and allow failing only for a specific module.
> 
> That will be useful. Thanks.

It might unfortunately need architecture specific code. But I guess a i386
only implementation as start would be useful enough.

-Andi

