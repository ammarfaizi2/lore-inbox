Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFOGxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 02:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFOGxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 02:53:15 -0400
Received: from dp.samba.org ([66.70.73.150]:63118 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261960AbTFOGxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 02:53:13 -0400
Date: Sun, 15 Jun 2003 17:06:11 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
Message-ID: <20030615070611.GE31148@krispykreme>
References: <200306062013.h56KDcLe026713@napali.hpl.hp.com> <20030606.234401.104035537.davem@redhat.com> <16097.36514.763047.738847@napali.hpl.hp.com> <20030607.001140.08328499.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607.001140.08328499.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>    But you're creating a new mapping for the old buffer.  What if you had
>    a DMA API implementation which consolidates multiple mapping attempts
>    of the same buffer into a single mapping entry (along with a reference
>    count)?  That would break the workaround.
>    
> I hope nobody is doing this, it would probably break other things
> we haven't considered yet.

Dave, we talked about this ages ago as a possible alternative to skb
recycling and persistent IOMMU mappings for those skbs.

Unfortunately you need a hash to map from all of memory to a pci bus
address for each host bridge (well IOMMU), and so far I cant think of
anything that wouldnt chew gobs of RAM.

Anton
