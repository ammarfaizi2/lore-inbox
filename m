Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVCJBe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVCJBe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVCJBYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:24:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:50373 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262657AbVCJBNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:13:21 -0500
Subject: Re: [PATCH 0/15] ptwalk: pagetable walker cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: hugh@veritas.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20050309170224.3f368c98.davem@davemloft.net>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
	 <1110415184.32524.128.camel@gaston>
	 <20050309170224.3f368c98.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 12:08:18 +1100
Message-Id: <1110416898.32524.141.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 17:02 -0800, David S. Miller wrote:
> On Thu, 10 Mar 2005 11:39:44 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > There are some other bugs introduced by set_pte_at() caused by latent
> > bugs in the PTE walkers that 'drop' part of the address along the way,
> > notably the vmalloc.c ones are bogus, thus breaking ppc/ppc64 in subtle
> > ways. Before I send patches, I'd rather check if it's not all fixed by
> > your patches first :)
> 
> Ben, I fixed vmalloc and the other cases when I pushed the set_pte_at()
> changes to Linus.  Here is the changeset that fixes them, and it's certainly
> in Linus's tree:

Yah, but look at the cruft in arch/ppc64/mm/init.c, specifically,
unmap_im_area_{pte,pmd,pud,..} ...

I'll fix it.

Ben.


