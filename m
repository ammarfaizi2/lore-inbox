Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTFOHCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTFOHCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:02:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1988 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261970AbTFOHC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:02:26 -0400
Date: Sun, 15 Jun 2003 00:11:07 -0700 (PDT)
Message-Id: <20030615.001107.88478922.davem@redhat.com>
To: anton@samba.org
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030615070611.GE31148@krispykreme>
References: <16097.36514.763047.738847@napali.hpl.hp.com>
	<20030607.001140.08328499.davem@redhat.com>
	<20030615070611.GE31148@krispykreme>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Sun, 15 Jun 2003 17:06:11 +1000

   Dave, we talked about this ages ago as a possible alternative to skb
   recycling and persistent IOMMU mappings for those skbs.
   
   Unfortunately you need a hash to map from all of memory to a pci bus
   address for each host bridge (well IOMMU), and so far I cant think of
   anything that wouldnt chew gobs of RAM.
   
The hash table need not be sized wrt. ram, but rather to the expected
amount of "DMA in flight" you can expect for the system.

You have to make these tables per-IOMMU anyways, which breaks down the
problem much further.

ROFL, whose workstation name is krispykreme? :-)
I just noticed that.
